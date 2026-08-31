#!/usr/bin/env python3
"""Parallel exhaustive cube farm for a frozen universal meta-SAT CNF.

The base CNF is partitioned by assignments to a chosen sequence of free tournament
edge variables. All 2^depth cubes are disjoint and exhaustive. Worker processes
load the frozen CNF once, keep one incremental CaDiCaL instance, and solve cubes via
assumptions. Thus 32 workers use 32 CPU lanes while preserving an exact partition.

Live observability is a hard requirement: a heartbeat thread atomically writes a
status JSON every few seconds even if no cube has completed. This makes metered
compute externally inspectable rather than a foreground-terminal trust exercise.

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
import threading
import time
from pathlib import Path

from pysat.formula import CNF
from pysat.solvers import Solver

_worker_solver = None
_worker_case = None
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
        positive = {x for x in model if x > 0}
        edges = list(itertools.combinations(range(23), 2))
        edge_var = {e: i + 1 for i, e in enumerate(edges)}
        rows = []
        for u in range(23):
            row = []
            for v in range(23):
                if u == v:
                    row.append('0')
                else:
                    a, b = (u, v) if u < v else (v, u)
                    var = edge_var[(a, b)]
                    truth = (var in positive) if u < v else (var not in positive)
                    row.append('1' if truth else '0')
            rows.append(''.join(row))
        out['rows'] = rows
    return out


def meminfo_gib() -> dict:
    vals = {}
    try:
        with open('/proc/meminfo', 'r', encoding='utf-8') as f:
            for line in f:
                k, rest = line.split(':', 1)
                if k in {'MemTotal', 'MemAvailable', 'MemFree'}:
                    vals[k] = int(rest.strip().split()[0]) * 1024
    except OSError:
        return {}
    gib = 1024 ** 3
    total = vals.get('MemTotal', 0)
    avail = vals.get('MemAvailable', vals.get('MemFree', 0))
    return {
        'ram_total_gib': round(total / gib, 3),
        'ram_available_gib': round(avail / gib, 3),
        'ram_used_gib': round((total - avail) / gib, 3),
    }


def atomic_json(path: Path, data: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    tmp = path.with_suffix(path.suffix + '.tmp')
    tmp.write_text(json.dumps(data, indent=2, sort_keys=True) + '\n', encoding='utf-8')
    os.replace(tmp, path)


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument('--case', choices=('size11','size12','defects'), required=True)
    ap.add_argument('--cnf', type=Path, required=True)
    ap.add_argument('--receipt', type=Path, required=True)
    ap.add_argument('--live-status', type=Path,
                    help='persistent heartbeat JSON (default: receipt stem + .live.json)')
    ap.add_argument('--workers', type=int, default=os.cpu_count() or 1)
    ap.add_argument('--depth', type=int, default=10,
                    help='2^depth disjoint cubes; default 1024')
    ap.add_argument('--solver', default='cadical195')
    ap.add_argument('--heartbeat', type=float, default=5.0)
    args = ap.parse_args()

    if not args.cnf.exists():
        raise SystemExit(f'missing CNF: {args.cnf}')
    if not (1 <= args.depth <= 16):
        raise SystemExit('depth must be 1..16')
    if args.workers < 1:
        raise SystemExit('workers must be >=1')

    live_path = args.live_status or args.receipt.with_suffix('.live.json')
    vars_ = list(range(23, 23 + args.depth))
    total = 1 << args.depth
    started = time.monotonic()
    state_lock = threading.Lock()
    state = {
        'solved': 0,
        'unsat': 0,
        'sat': 0,
        'slowest_cube': {'cube': None, 'seconds': -1.0},
        'last_completion_monotonic': None,
        'last_cube': None,
        'finished': False,
        'final_status': None,
    }

    ctx = mp.get_context('fork')
    pool = ctx.Pool(
        processes=args.workers,
        initializer=init_worker,
        initargs=(str(args.cnf), args.solver, args.case, vars_),
    )

    def snapshot() -> dict:
        now = time.monotonic()
        with state_lock:
            solved = int(state['solved'])
            unsat = int(state['unsat'])
            sat = int(state['sat'])
            slowest = dict(state['slowest_cube'])
            last_done = state['last_completion_monotonic']
            last_cube = state['last_cube']
            finished = bool(state['finished'])
            final_status = state['final_status']
        elapsed = max(now - started, 1e-9)
        rate = solved / elapsed
        remaining = total - solved
        eta = (remaining / rate) if rate > 0 else None
        try:
            alive = sum(1 for p in pool._pool if p.is_alive())
        except Exception:
            alive = None
        try:
            load1, load5, load15 = os.getloadavg()
            loads = {'load_1m': round(load1, 3), 'load_5m': round(load5, 3), 'load_15m': round(load15, 3)}
        except OSError:
            loads = {}
        out = {
            'schema': 'erdos902.f4-meta-cube-farm-live.v1',
            'case': args.case,
            'status': final_status if finished else 'RUNNING',
            'cubes_total': total,
            'cubes_solved': solved,
            'cubes_remaining': remaining,
            'percent_complete': round(100.0 * solved / total, 3),
            'cubes_unsat': unsat,
            'cubes_sat': sat,
            'workers_requested': args.workers,
            'workers_alive': alive,
            'elapsed_seconds': round(elapsed, 3),
            'completed_cubes_per_minute': round(rate * 60.0, 3),
            'naive_eta_seconds': round(eta, 3) if eta is not None else None,
            'seconds_since_last_completion': round(now - last_done, 3) if last_done is not None else None,
            'last_completed_cube': last_cube,
            'slowest_completed_cube': slowest,
            'cnf_sha256': sha256_file(args.cnf),
            **loads,
            **meminfo_gib(),
        }
        return out

    stop_heartbeat = threading.Event()

    def heartbeat_loop() -> None:
        while not stop_heartbeat.is_set():
            snap = snapshot()
            atomic_json(live_path, snap)
            print('HEARTBEAT ' + json.dumps({
                'case': snap['case'],
                'done': f"{snap['cubes_solved']}/{snap['cubes_total']}",
                'pct': snap['percent_complete'],
                'workers_alive': snap['workers_alive'],
                'elapsed_s': snap['elapsed_seconds'],
                'rate_per_min': snap['completed_cubes_per_minute'],
                'eta_s': snap['naive_eta_seconds'],
                'since_last_done_s': snap['seconds_since_last_completion'],
                'ram_used_gib': snap.get('ram_used_gib'),
                'load_1m': snap.get('load_1m'),
            }, sort_keys=True), flush=True)
            stop_heartbeat.wait(args.heartbeat)

    hb = threading.Thread(target=heartbeat_loop, daemon=True)
    hb.start()

    sat_result = None
    try:
        for result in pool.imap_unordered(solve_cube, range(total), chunksize=1):
            with state_lock:
                state['solved'] += 1
                state['last_completion_monotonic'] = time.monotonic()
                state['last_cube'] = result['cube']
                if result['seconds'] > state['slowest_cube']['seconds']:
                    state['slowest_cube'] = {'cube': result['cube'], 'seconds': result['seconds']}
                if result['status'] == 'SAT':
                    state['sat'] += 1
                else:
                    state['unsat'] += 1
            if result['status'] == 'SAT':
                sat_result = result
                pool.terminate()
                break
        if sat_result is None:
            pool.close()
    finally:
        pool.join()

    final_status = 'SAT_COUNTEREXAMPLE_CUBE' if sat_result else 'ALL_CUBES_UNSAT_DISCOVERY'
    with state_lock:
        state['finished'] = True
        state['final_status'] = final_status
    stop_heartbeat.set()
    hb.join(timeout=max(1.0, args.heartbeat + 1.0))
    atomic_json(live_path, snapshot())

    with state_lock:
        solved = int(state['solved'])
        unsat = int(state['unsat'])
        slowest = dict(state['slowest_cube'])
    receipt = {
        'schema': 'erdos902.f4-meta-cube-farm.v2',
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
        'status': final_status,
        'elapsed_seconds': round(time.monotonic() - started, 6),
        'slowest_cube': slowest,
        'live_status': str(live_path.resolve()),
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
    args.receipt.write_text(json.dumps(receipt, indent=2, sort_keys=True) + '\n', encoding='utf-8')
    print(json.dumps(receipt, indent=2, sort_keys=True), flush=True)
    return 42 if sat_result else 0


if __name__ == '__main__':
    raise SystemExit(main())
