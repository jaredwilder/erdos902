#!/usr/bin/env python3
"""Streaming monolithic SAT encoding for a general 49-vertex S4 tournament."""

from __future__ import annotations

import argparse
import hashlib
import itertools
import json
import time
from pathlib import Path

from pysat.card import CardEnc, EncType
from pysat.solvers import Solver

N, K = 49, 4
EDGE_VARS = N * (N - 1) // 2
TARGETS = 211876
SELECTORS = TARGETS * (N - K)
VARIABLES = EDGE_VARS + SELECTORS
CLAUSES = 1 + TARGETS * ((N - K) * K + 1)


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as src:
        for chunk in iter(lambda: src.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def edge_table() -> dict[tuple[int, int], int]:
    return {edge: i for i, edge in enumerate(itertools.combinations(range(N), 2), 1)}


def beats_lit(u: int, v: int, edges: dict[tuple[int, int], int]) -> int:
    """Literal asserting u -> v; variable (a,b), a<b, means a -> b."""
    assert u != v
    return edges[(u, v)] if u < v else -edges[(v, u)]


def write_cnf(path: Path) -> dict:
    edges = edge_table()
    started = time.monotonic()
    digest = hashlib.sha256()
    target_count = clause_count = 0
    selector = EDGE_VARS
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("wb", buffering=1024 * 1024) as out:
        def emit(lits) -> None:
            nonlocal clause_count
            line = (" ".join(map(str, lits)) + " 0\n").encode("ascii")
            out.write(line)
            digest.update(line)
            clause_count += 1

        header = f"p cnf {VARIABLES} {CLAUSES}\n".encode("ascii")
        out.write(header)
        digest.update(header)
        # Every tournament has an arc, so relabel its endpoints as 0 -> 1.
        emit([edges[(0, 1)]])
        for xs in itertools.combinations(range(N), K):
            occupied = set(xs)
            witnesses = []
            for y in range(N):
                if y in occupied:
                    continue
                selector += 1
                witnesses.append(selector)
                for x in xs:
                    emit([-selector, beats_lit(y, x, edges)])
            emit(witnesses)
            target_count += 1

    assert target_count == TARGETS
    assert selector == VARIABLES
    assert clause_count == CLAUSES
    return {
        "schema": "erdos902.order49-general-monolithic-cnf.v1",
        "order": N, "k": K, "encoding": "full monolithic exact witness selectors",
        "edge_variables": EDGE_VARS, "selector_variables": SELECTORS,
        "variables": VARIABLES, "four_set_targets": TARGETS, "clauses": CLAUSES,
        "symmetry_break": "vertex relabeling fixes arc 0 -> 1",
        "cnf": str(path.resolve()), "cnf_sha256": digest.hexdigest(),
        "generation_seconds": round(time.monotonic() - started, 6),
    }


def adjacency_from_model(model: list[int]) -> list[str]:
    positive = {v for v in model if 0 < v <= EDGE_VARS}
    edges = edge_table()
    return [
        "".join(
            "0" if u == v else
            ("1" if (edges[(u, v)] in positive if u < v else
                     edges[(v, u)] not in positive) else "0")
            for v in range(N)
        )
        for u in range(N)
    ]


def exhaustive_verify(rows: list[str]) -> tuple[bool, tuple[int, ...] | None]:
    in_masks = []
    for x in range(N):
        mask = 0
        for y in range(N):
            if rows[y][x] == "1":
                mask |= 1 << y
        in_masks.append(mask)
    for xs in itertools.combinations(range(N), K):
        common = (1 << N) - 1
        for x in xs:
            common &= in_masks[x]
        if common == 0:
            return False, xs
    return True, None


def solve_native(cnf_path: Path, solution_path: Path, solver_name: str, branch: int) -> dict:
    load_started = time.monotonic()
    with Solver(name=solver_name) as solver, cnf_path.open("r", encoding="ascii") as src:
        header = src.readline().split()
        if header != ["p", "cnf", str(VARIABLES), str(CLAUSES)]:
            raise RuntimeError(f"unexpected header: {header}")
        loaded = 0
        for line in src:
            lits = [int(v) for v in line.split()]
            if not lits or lits[-1] != 0:
                raise RuntimeError(f"malformed clause at {loaded + 1}")
            solver.add_clause(lits[:-1])
            loaded += 1
        if loaded != CLAUSES:
            raise RuntimeError(f"loaded {loaded} clauses, expected {CLAUSES}")
        edges = edge_table()
        top = VARIABLES
        structural_clauses = 0

        # Label a minimum-indegree vertex as 0.  S4 gives min indegree >= 23,
        # while the average is 24, so its degree is exactly branch 23 or 24.
        out_count = N - 1 - branch
        for v in range(1, N):
            solver.add_clause([beats_lit(0, v, edges) if v <= out_count
                               else beats_lit(v, 0, edges)])
            structural_clauses += 1
        for v in range(N):
            indegree = [beats_lit(u, v, edges) for u in range(N) if u != v]
            lower = CardEnc.atleast(indegree, bound=branch if branch == 24 else 23,
                                    top_id=top, encoding=EncType.seqcounter)
            top = lower.nv
            for clause in lower.clauses:
                solver.add_clause(clause)
            structural_clauses += len(lower.clauses)
            if branch == 24:
                upper = CardEnc.atmost(indegree, bound=24, top_id=top,
                                       encoding=EncType.seqcounter)
                top = upper.nv
                for clause in upper.clauses:
                    solver.add_clause(clause)
                structural_clauses += len(upper.clauses)
        load_seconds = time.monotonic() - load_started
        solve_started = time.monotonic()
        sat = solver.solve()
        solve_seconds = time.monotonic() - solve_started
        model = solver.get_model() if sat else None
        stats = solver.accum_stats()
    receipt = {
        "schema": "erdos902.order49-general-monolithic-result.v1",
        "order": N, "k": K, "solver": solver_name,
        "result": "SAT" if sat else "UNSAT",
        "cnf": str(cnf_path.resolve()), "cnf_sha256": sha256_file(cnf_path),
        "variables": VARIABLES, "clauses": CLAUSES,
        "minimum_indegree_branch": branch,
        "structural_auxiliary_variables": top - VARIABLES,
        "structural_clauses": structural_clauses,
        "load_seconds": round(load_seconds, 6), "solve_seconds": round(solve_seconds, 6),
        "solver_stats": stats,
    }
    if sat:
        assert model is not None
        rows = adjacency_from_model(model)
        valid, bad = exhaustive_verify(rows)
        if not valid:
            raise RuntimeError(f"solver model failed exhaustive verification: {bad}")
        matrix_path = solution_path.with_suffix(".adjacency.txt")
        matrix = "\n".join(rows) + "\n"
        matrix_path.write_text(matrix, encoding="ascii")
        receipt.update({
            "exhaustive_4set_verification": "PASS",
            "adjacency_matrix": str(matrix_path.resolve()),
            "adjacency_sha256": hashlib.sha256(matrix.encode()).hexdigest(),
        })
    solution_path.write_text(json.dumps(receipt, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return receipt


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--cnf", type=Path, required=True)
    parser.add_argument("--receipt", type=Path)
    parser.add_argument("--solve-native", action="store_true")
    parser.add_argument("--solver", default="cadical195")
    parser.add_argument("--minimum-indegree-branch", type=int, choices=(23, 24))
    args = parser.parse_args()
    if args.solve_native:
        if not args.receipt:
            raise SystemExit("--solve-native requires --receipt")
        if args.minimum_indegree_branch is None:
            raise SystemExit("--solve-native requires --minimum-indegree-branch 23 or 24")
        receipt = solve_native(
            args.cnf, args.receipt, args.solver, args.minimum_indegree_branch
        )
    else:
        receipt = write_cnf(args.cnf)
    rendered = json.dumps(receipt, indent=2, sort_keys=True) + "\n"
    if args.receipt and not args.solve_native:
        args.receipt.parent.mkdir(parents=True, exist_ok=True)
        args.receipt.write_text(rendered, encoding="utf-8")
    print(rendered, end="")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
