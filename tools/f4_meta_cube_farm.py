#!/usr/bin/env python3
"""Parallel exhaustive cube farm for a frozen universal meta-SAT CNF.

The base CNF is partitioned by assignments to a chosen sequence of free tournament
edge variables.  All 2^depth cubes are disjoint and exhaustive.  Worker processes
load the frozen CNF once, keep one incremental CaDiCaL instance, and solve cubes via
assumptions.  Thus 32 workers use 32 physical/vCPU lanes while preserving an exact
partition of the original formula.

Discovery semantics:
  * any SAT cube => base formula SAT (counterexample route)
  * every cube UNSAT => base formula UNSAT
For publication, replace discovery UNSAT by independently checked static proof
certificates; this driver is not itself a proof checker.
"""
from __future__ import annotations

import argparse
import hashlib
import itertools
import json
import multiprocessing as mp
import os
import time
from pathlib import Path

from pysat.formula import CNF
from pysat.solvers import Solver

_worker_solver = None
_worker_case = None
_worker_depth = None
_worker_vars = None


def sha256_file(path: Path) -> str:
    h = hashlib.sha256()
    with path.open('rb') as f:
        for chunk in iter(lambda: f.read(1 << 20), b''):
            h.update(chunk)
    return h.hexdigest()


def cube_lits(idx: int, vars_: list[int]) -> list[int]:
    return [v if ((idx >> bit) & 1) else -v for bit, v in enumerate(vars_)]


def init_worker(cnf_path: str, solver_name: str, case: str, vars_: list[int]) -> None:
    global _worker_solver, _worker_case, _worker_vars
    cnf = CNF(from_file=cnf_path)
    _worker_solver = Solver(name=solver_name, bootstrap_with=cnf.clauses)
    _worker_case = case
    _worker_vars = vars_


def solve_cube(idx: int) -> dict:
    global _worker_solver, _worker_vars
    assert _worker_solver is not None and _worker_vars is not None
    lits = cube_lits(idx, _worker_vars)
    t0 = time.monotonic()
    sat = _worker_solver.solve(assumptions=lits)
    elapsed = time.monotonic() - t0
    out = {
        'cube': idx,
        'status': 'SAT' if sat else 'UNSAT',
        'seconds': round(elapsed, 6),
        'pid': os.getpid(),
    }
    if sat:
        model = _worker_solver.get_model() or []
        # Edge variables are IDs 1..253 in Builder construction order.
        positive = {x for x in model if x > 0}
        edges = list(itertools.combinations(range(23), 2))
        rows = []
        for u in range(23):
            row = []
            for v in range(23):
                if u == v:
                    row.append('0')
                else:
                    a, b = (u, v) if u < v else (v, u)
                    var = edges.index((a, b)) + 1
                    truth = (var in positive) if u < v else (var not in positive)
                    row.append('1' if truth else '0')
            rows.append(''.join(row))
        out['rows'] = rows
    return out


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument('--case', choices=('size11','size12','defects'), required=True)
    ap.add_argument('--cnf', type=Path, required=True)
    ap.add_argument('--receipt', type=Path, required=True)
    ap.add_argument('--workers', type=int, default=os.cpu_count() or 1)
    ap.add_argument('--depth', type=int, default=10,
                    help='2^depth disjoint cubes; default 1024')
    ap.add_argument('--solver', default='cadical195')
    args = ap.parse_args()

    if not args.cnf.exists():
        raise SystemExit(f'missing CNF: {args.cnf}')
    if not (1 <= args.depth <= 16):
        raise SystemExit('depth must be 1..16')

    # Builder assigns tournament edge variables first. IDs 1..22 are edges (0,v),
    # which are fixed in size12/defects.  IDs 23 onward are edges among vertices 1..22
    # and are free in all three courts.  Use a deterministic consecutive block.
    vars_ = list(range(23, 23 + args.depth))
    total = 1 << args.depth
    started = time.monotonic()
    solved = 0
    unsat = 0
    sat_result = None
    slowest = {'cube': None, 'seconds': -1.0}
    next_report = max(1, total // 20)

    ctx = mp.get_context('fork')
    pool = ctx.Pool(
        processes=args.workers,
        initializer=init_worker,
        initargs=(str(args.cnf), args.solver, args.case, vars_),
    )
    try:
        for result in pool.imap_unordered(solve_cube, range(total), chunksize=1):
            solved += 1
            if result['seconds'] > slowest['seconds']:
                slowest = {'cube': result['cube'], 'seconds': result['seconds']}
            if result['status'] == 'SAT':
                sat_result = result
                pool.terminate()
                break
            unsat += 1
            if solved % next_report == 0 or solved == total:
                print(json.dumps({
                    'case': args.case,
                    'solved': solved,
                    'total': total,
                    'unsat': unsat,
                    'workers': args.workers,
                    'elapsed_seconds': round(time.monotonic() - started, 3),
                    'slowest_cube': slowest,
                }, sort_keys=True), flush=True)
        if sat_result is None:
            pool.close()
    finally:
        pool.join()

    receipt = {
        'schema': 'erdos902.f4-meta-cube-farm.v1',
        'case': args.case,
        'cnf': str(args.cnf.resolve()),
        'cnf_sha256': sha256_file(args.cnf),
        'solver': args.solver,
        'workers': args.workers,
        'cube_depth': args.depth,
        'cube_variables': vars_,
        'cubes_total': total,
        'cubes_solved': solved,
        'cubes_unsat': unsat,
        'status': 'SAT_COUNTEREXAMPLE_CUBE' if sat_result else 'ALL_CUBES_UNSAT_DISCOVERY',
        'elapsed_seconds': round(time.monotonic() - started, 6),
        'slowest_cube': slowest,
        'proof_warning': (
            'Cube farm gives exact discovery status because cubes are disjoint/exhaustive, '
            'but UNSAT publication still requires independently checked proof certificates.'
        ),
    }
    if sat_result:
        receipt['sat_cube'] = sat_result['cube']
        receipt['sat_cube_seconds'] = sat_result['seconds']
        matrix = '\n'.join(sat_result['rows']) + '\n'
        matrix_path = args.receipt.with_suffix('.adjacency.txt')
        matrix_path.write_text(matrix, encoding='ascii')
        receipt['adjacency_matrix'] = str(matrix_path.resolve())
        receipt['adjacency_sha256'] = hashlib.sha256(matrix.encode()).hexdigest()

    core = json.dumps(receipt, sort_keys=True, separators=(',', ':')).encode()
    receipt['receipt_sha256'] = hashlib.sha256(core).hexdigest()
    args.receipt.parent.mkdir(parents=True, exist_ok=True)
    args.receipt.write_text(json.dumps(receipt, indent=2, sort_keys=True) + '\n')
    print(json.dumps(receipt, indent=2, sort_keys=True), flush=True)
    return 42 if sat_result else 0


if __name__ == '__main__':
    raise SystemExit(main())
