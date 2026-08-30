#!/usr/bin/env python3
"""Exact lazy SAT/CEGAR search for arbitrary tournaments with Schuette property S_k.

A tournament on n labelled vertices is represented by one Boolean variable for each
unordered pair {u,v}; variable (u,v), u<v, is true iff u -> v.  The master SAT
instance initially contains only sound symmetry/structural constraints.  For each
candidate tournament, an exhaustive bitset adversary scans k-sets X.  Whenever X has
no common in-neighbour, the master receives the exact existential witness block

    OR_{y notin X} selector(X,y),
    selector(X,y) -> (y -> x)  for every x in X.

No candidate is rejected by a relaxation: every learned block is exactly one S_k
constraint.  SAT models are exhaustively rechecked before being reported.
"""
from __future__ import annotations

import argparse
import hashlib
import itertools
import json
import os
import platform
import socket
import time
from pathlib import Path

from pysat.solvers import Solver


def edge_table(n: int) -> dict[tuple[int, int], int]:
    return {edge: i for i, edge in enumerate(itertools.combinations(range(n), 2), 1)}


def beats_lit(u: int, v: int, edges: dict[tuple[int, int], int]) -> int:
    assert u != v
    return edges[(u, v)] if u < v else -edges[(v, u)]


def rows_from_model(n: int, model: list[int], edges: dict[tuple[int, int], int]) -> list[str]:
    positive = {v for v in model if 0 < v <= len(edges)}
    rows: list[str] = []
    for u in range(n):
        row = []
        for v in range(n):
            if u == v:
                row.append("0")
            else:
                var = edges[(u, v)] if u < v else edges[(v, u)]
                u_beats_v = var in positive if u < v else var not in positive
                row.append("1" if u_beats_v else "0")
        rows.append("".join(row))
    return rows


def in_masks_from_rows(rows: list[str]) -> list[int]:
    n = len(rows)
    masks: list[int] = []
    for x in range(n):
        mask = 0
        for y in range(n):
            if rows[y][x] == "1":
                mask |= 1 << y
        masks.append(mask)
    return masks


def find_bad_sets(rows: list[str], k: int, limit: int) -> list[tuple[int, ...]]:
    """Return up to limit k-sets with no common in-neighbour; limit=0 means all."""
    n = len(rows)
    ins = in_masks_from_rows(rows)
    bad: list[tuple[int, ...]] = []
    full = (1 << n) - 1
    for xs in itertools.combinations(range(n), k):
        common = full
        for x in xs:
            common &= ins[x]
            if not common:
                break
        if common == 0:
            bad.append(xs)
            if limit and len(bad) >= limit:
                break
    return bad


def add_target_block(solver: Solver, top: int, n: int, xs: tuple[int, ...],
                     edges: dict[tuple[int, int], int]) -> tuple[int, int]:
    """Add the exact S_k requirement for one target set. Returns (new_top, clauses_added)."""
    occupied = set(xs)
    selectors: list[int] = []
    clauses = 0
    for y in range(n):
        if y in occupied:
            continue
        top += 1
        s = top
        selectors.append(s)
        for x in xs:
            solver.add_clause([-s, beats_lit(y, x, edges)])
            clauses += 1
    solver.add_clause(selectors)
    clauses += 1
    return top, clauses


def sha256_text(text: str) -> str:
    return hashlib.sha256(text.encode("utf-8")).hexdigest()


def host_info() -> dict:
    return {
        "hostname": socket.gethostname(),
        "platform": platform.platform(),
        "python": platform.python_version(),
        "cpu_count": os.cpu_count(),
    }


def run(args: argparse.Namespace) -> int:
    n, k = args.n, args.k
    if n <= k or k <= 0:
        raise SystemExit("require n > k > 0")
    if args.f4step48 and (n != 48 or k != 4):
        raise SystemExit("--f4step48 is only sound/implemented for n=48,k=4")
    if args.f4step48 and args.fix_arc:
        raise SystemExit("do not combine --f4step48 with --fix-arc: F4Step fixes 1->0")
    if args.cube_depth < 0 or args.cube_depth > 20:
        raise SystemExit("--cube-depth must be between 0 and 20")
    if args.cube_index < 0 or args.cube_index >= (1 << args.cube_depth):
        raise SystemExit("--cube-index must satisfy 0 <= index < 2^depth")

    edges = edge_table(n)
    edge_vars = len(edges)
    top = edge_vars
    started = time.monotonic()
    cut_count = 0
    clause_count = 0
    iteration = 0
    seen: set[tuple[int, ...]] = set()

    # bootstrap_with deliberately empty: a tournament is already encoded by the
    # polarity of one variable per unordered pair.
    with Solver(name=args.solver) as solver:
        structural = []
        if args.fix_arc:
            lit = beats_lit(0, 1, edges)
            solver.add_clause([lit])
            clause_count += 1
            structural.append("relabel an arc as 0->1")

        fixed_edge_vars: set[int] = set()
        if args.fix_arc:
            fixed_edge_vars.add(abs(beats_lit(0, 1, edges)))

        if args.f4step48:
            # In any hypothetical 48-vertex S4 tournament there exists a vertex
            # of indegree exactly 23 (kernel-checked in Erdos902F4Step). Relabel it
            # as 0, its in-neighbours as 1..23, and its out-neighbours as 24..47.
            for v in range(1, 24):
                lit = beats_lit(v, 0, edges)
                solver.add_clause([lit])
                fixed_edge_vars.add(abs(lit))
                clause_count += 1
            for v in range(24, 48):
                lit = beats_lit(0, v, edges)
                solver.add_clause([lit])
                fixed_edge_vars.add(abs(lit))
                clause_count += 1
            structural.append("F4Step: indeg(0)=23; N-(0)={1..23}")

        # Deterministic cube partition over the first free edge variables. Across
        # all indices 0..2^depth-1 these cubes are disjoint and exhaustive.
        free_vars = [v for v in range(1, edge_vars + 1) if v not in fixed_edge_vars]
        cube_vars = free_vars[:args.cube_depth]
        cube_lits: list[int] = []
        for bit, var in enumerate(cube_vars):
            lit = var if ((args.cube_index >> bit) & 1) else -var
            solver.add_clause([lit])
            cube_lits.append(lit)
            clause_count += 1
        if cube_lits:
            structural.append(f"cube depth {args.cube_depth} index {args.cube_index}")

        # Append-only exact cut log. It doubles as a checkpoint: on restart every
        # previously learned target block is replayed before solving continues.
        cutlog_handle = None
        if args.cutlog:
            args.cutlog.parent.mkdir(parents=True, exist_ok=True)
            meta = {
                "schema": "erdos902.global-sk-cegar-cutlog.v1",
                "n": n, "k": k, "f4step48": bool(args.f4step48),
                "fix_arc": bool(args.fix_arc), "cube_depth": args.cube_depth,
                "cube_index": args.cube_index, "cube_lits": cube_lits,
            }
            if args.cutlog.exists() and args.cutlog.stat().st_size:
                with args.cutlog.open("r", encoding="utf-8") as src:
                    first = json.loads(src.readline())
                    if first != meta:
                        raise RuntimeError(f"cutlog metadata mismatch: {first} != {meta}")
                    for line in src:
                        item = json.loads(line)
                        xs = tuple(item["x"])
                        if xs in seen:
                            continue
                        seen.add(xs)
                        top, added = add_target_block(solver, top, n, xs, edges)
                        clause_count += added
                        cut_count += 1
            else:
                args.cutlog.write_text(json.dumps(meta, sort_keys=True) + "\n", encoding="utf-8")
            cutlog_handle = args.cutlog.open("a", encoding="utf-8", buffering=1)

        status = "UNKNOWN"
        final_rows: list[str] | None = None
        while iteration < args.max_iterations:
            iteration += 1
            elapsed = time.monotonic() - started
            if args.time_limit and elapsed >= args.time_limit:
                status = "TIME_LIMIT"
                break
            sat = solver.solve()
            if not sat:
                status = "UNSAT_UNDER_STRUCTURAL_CONSTRAINTS"
                break
            model = solver.get_model()
            assert model is not None
            rows = rows_from_model(n, model, edges)
            bad = find_bad_sets(rows, k, args.batch)
            if not bad:
                # Empty means the scan reached the end without a bad set, hence exact.
                status = "SAT_CONSTRUCTION"
                final_rows = rows
                break

            added_now = 0
            for xs in bad:
                if xs in seen:
                    # Impossible if exact target blocks were replayed correctly.
                    raise RuntimeError(f"repeated bad set despite exact cut: {xs}")
                seen.add(xs)
                top, added = add_target_block(solver, top, n, xs, edges)
                clause_count += added
                cut_count += 1
                added_now += 1
                if cutlog_handle is not None:
                    cutlog_handle.write(json.dumps({"x": list(xs)}, separators=(",", ":")) + "\n")

            if args.progress and (iteration <= 10 or iteration % args.progress == 0):
                stats = solver.accum_stats()
                print(json.dumps({
                    "iteration": iteration,
                    "cuts_total": cut_count,
                    "cuts_added": added_now,
                    "vars": top,
                    "clauses_added": clause_count,
                    "elapsed_seconds": round(time.monotonic() - started, 3),
                    "solver_stats": stats,
                }, sort_keys=True), flush=True)
        else:
            status = "ITERATION_LIMIT"

        stats = solver.accum_stats()
        if cutlog_handle is not None:
            cutlog_handle.close()

    receipt = {
        "schema": "erdos902.global-sk-cegar.v1",
        "n": n,
        "k": k,
        "status": status,
        "solver": args.solver,
        "edge_variables": edge_vars,
        "total_variables_used": top,
        "exact_target_blocks": cut_count,
        "clauses_added": clause_count,
        "iterations": iteration,
        "batch": args.batch,
        "structural_constraints": structural,
        "cube_depth": args.cube_depth,
        "cube_index": args.cube_index,
        "cube_lits": cube_lits,
        "cutlog": str(args.cutlog.resolve()) if args.cutlog else None,
        "unsat_certificate_warning": (
            "incremental UNSAT is discovery evidence only; freeze/replay the final exact "
            "cut set as static CNF with an independently checked DRAT/LRAT proof before "
            "making a mathematical nonexistence claim"
        ) if status == "UNSAT_UNDER_STRUCTURAL_CONSTRAINTS" else None,
        "elapsed_seconds": round(time.monotonic() - started, 6),
        "solver_stats": stats,
        "host": host_info(),
    }

    if final_rows is not None:
        # Independent implementation path: rescan the completed adjacency matrix.
        bad = find_bad_sets(final_rows, k, 1)
        if bad:
            raise RuntimeError(f"final SAT model failed exhaustive verification: {bad[0]}")
        matrix = "\n".join(final_rows) + "\n"
        receipt["exhaustive_verification"] = "PASS"
        receipt["adjacency_sha256"] = sha256_text(matrix)
        if args.matrix:
            args.matrix.parent.mkdir(parents=True, exist_ok=True)
            args.matrix.write_text(matrix, encoding="ascii")
            receipt["adjacency_matrix"] = str(args.matrix.resolve())

    rendered_core = json.dumps(receipt, sort_keys=True, separators=(",", ":"))
    receipt["receipt_sha256"] = sha256_text(rendered_core)
    rendered = json.dumps(receipt, indent=2, sort_keys=True) + "\n"
    if args.receipt:
        args.receipt.parent.mkdir(parents=True, exist_ok=True)
        args.receipt.write_text(rendered, encoding="utf-8")
    print(rendered, end="")
    return 0 if status in {"SAT_CONSTRUCTION", "UNSAT_UNDER_STRUCTURAL_CONSTRAINTS"} else 2


def main() -> int:
    p = argparse.ArgumentParser()
    p.add_argument("--n", type=int, required=True)
    p.add_argument("--k", type=int, default=4)
    p.add_argument("--solver", default="cadical195")
    p.add_argument("--batch", type=int, default=256,
                   help="bad target sets learned per candidate; 0 learns all bad sets")
    p.add_argument("--max-iterations", type=int, default=1_000_000)
    p.add_argument("--time-limit", type=float, default=0,
                   help="soft wall limit in seconds, checked between SAT calls")
    p.add_argument("--progress", type=int, default=10)
    p.add_argument("--fix-arc", action="store_true")
    p.add_argument("--f4step48", action="store_true",
                   help="sound n=48,k=4 reduction: fix a degree-23 vertex as 0")
    p.add_argument("--cube-depth", type=int, default=0,
                   help="partition on this many free edge variables")
    p.add_argument("--cube-index", type=int, default=0,
                   help="cube assignment index in [0,2^depth)")
    p.add_argument("--cutlog", type=Path,
                   help="append-only exact target log; existing log is resumed")
    p.add_argument("--receipt", type=Path)
    p.add_argument("--matrix", type=Path)
    return run(p.parse_args())


if __name__ == "__main__":
    raise SystemExit(main())
