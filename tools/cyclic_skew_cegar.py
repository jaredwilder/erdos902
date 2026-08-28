#!/usr/bin/env python3
"""Exact CEGAR search for cyclic tournaments with domination number > k.

The master chooses a skew half-set D in Z/nZ.  The adversary searches for
X, |X| <= k, with X + (D union {0}) = Z/nZ.  Every counterexample X adds
an exact master cut requiring X to miss some vertex on the next candidate.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import time
from pathlib import Path

from pysat.card import CardEnc, EncType
from pysat.formula import CNF
from pysat.solvers import Solver


def membership_lit(a: int, n: int) -> int:
    """Literal saying nonzero residue a belongs to the skew half-set D."""
    assert 0 < a < n
    m = (n - 1) // 2
    return a if a <= m else -(n - a)


def half_set(model: list[int], n: int) -> list[int]:
    positive = {v for v in model if v > 0}
    m = (n - 1) // 2
    return [r if r in positive else n - r for r in range(1, m + 1)]


def adversary_cnf(n: int, k: int, d: list[int]) -> CNF:
    h = {0, *d}
    cnf = CNF()
    # Variable x+1 says x is in the dominating set X.
    for y in range(n):
        cnf.append([x + 1 for x in range(n) if (y - x) % n in h])
    cnf.extend(CardEnc.atmost(
        lits=list(range(1, n + 1)), bound=k, top_id=n,
        encoding=EncType.seqcounter,
    ).clauses)
    return cnf


def solve_cnf(cnf: CNF, solver_name: str) -> tuple[bool, list[int]]:
    with Solver(name=solver_name, bootstrap_with=cnf.clauses) as solver:
        sat = solver.solve()
        return sat, solver.get_model() if sat else []


def find_dominator(n: int, k: int, d: list[int], solver: str) -> list[int] | None:
    sat, model = solve_cnf(adversary_cnf(n, k, d), solver)
    if not sat:
        return None
    return [i for i in range(n) if i + 1 in {v for v in model if v > 0}]


def add_failure_cut(cnf: CNF, top: int, n: int, xset: list[int]) -> int:
    """Require this exact X to fail to dominate the next master candidate."""
    selectors = []
    occupied = set(xset)
    for y in range(n):
        if y in occupied:
            continue
        top += 1
        selector = top
        selectors.append(selector)
        for x in xset:
            # y is missed iff every y-x is outside H.  Here y != x, so nonzero.
            cnf.append([-selector, -membership_lit((y - x) % n, n)])
    cnf.append(selectors)
    return top


def qr_half_set(p: int) -> list[int]:
    residues = {x * x % p for x in range(1, p)}
    if len(residues) != (p - 1) // 2 or any((-x) % p in residues for x in residues):
        raise ValueError(f"{p} does not give a skew quadratic-residue half-set")
    return sorted(residues)


def digest_receipt(data: dict) -> str:
    core = json.dumps(data, sort_keys=True, separators=(",", ":")).encode()
    return hashlib.sha256(core).hexdigest()


def write_receipt(path: str | None, data: dict) -> None:
    data["sha256"] = digest_receipt(data)
    rendered = json.dumps(data, indent=2, sort_keys=True)
    if path:
        Path(path).write_text(rendered + "\n", encoding="utf-8")
    summary = {key: value for key, value in data.items() if key != "cuts"}
    if "cuts" in data:
        summary["cuts_sha256"] = hashlib.sha256(
            json.dumps(data["cuts"], separators=(",", ":")).encode()
        ).hexdigest()
    print(json.dumps(summary, indent=2, sort_keys=True))


def run(args: argparse.Namespace) -> int:
    n, k = args.n, args.k
    if n < 3 or n % 2 == 0 or not 0 < k < n:
        raise SystemExit("require odd n >= 3 and 0 < k < n")
    started = time.monotonic()

    if args.check_paley:
        d = qr_half_set(n)
        xset = find_dominator(n, k, d, args.solver)
        result = {
            "mode": "check-paley", "n": n, "k": k, "D": d,
            "status": "SAT_CONSTRUCTION" if xset is None else "COUNTEREXAMPLE",
            "dominating_set": xset, "solver": args.solver,
            "elapsed_seconds": round(time.monotonic() - started, 6),
        }
        if args.verify_solver:
            second = find_dominator(n, k, d, args.verify_solver)
            result["independent_verifier"] = args.verify_solver
            result["independent_verification"] = (
                "PASS" if (second is None) == (xset is None) else "FAIL"
            )
        write_receipt(args.receipt, result)
        return 0 if xset is None else 1

    m = (n - 1) // 2
    master = CNF()
    master.append([1])  # D -> -D symmetry: fix 1 in D without loss.
    top = m
    cuts: list[list[int]] = []

    with Solver(name=args.solver, bootstrap_with=master.clauses) as master_solver:
        while len(cuts) < args.max_iterations:
            if args.time_limit and time.monotonic() - started >= args.time_limit:
                status, d = "TIME_LIMIT", []
                break
            if not master_solver.solve():
                status, d = "UNSAT_NO_CYCLIC_CONSTRUCTION", []
                break
            d = sorted(half_set(master_solver.get_model(), n))
            xset = find_dominator(n, k, d, args.solver)
            if xset is None:
                status = "SAT_CONSTRUCTION"
                break
            # Translation preserves domination in a Cayley tournament.  Store the
            # canonical translate containing 0 to avoid rediscovering its orbit.
            anchor = min(xset)
            xset = sorted((x - anchor) % n for x in xset)
            cuts.append(xset)
            old_len = len(master.clauses)
            top = add_failure_cut(master, top, n, xset)
            for clause in master.clauses[old_len:]:
                master_solver.add_clause(clause)
            if args.progress and (len(cuts) <= 10 or len(cuts) % args.progress == 0):
                print(json.dumps({"iteration": len(cuts), "D": d, "X": xset}), flush=True)
        else:
            status, d = "ITERATION_LIMIT", []

    result = {
        "mode": "cegar", "n": n, "k": k, "status": status,
        "D": d, "cuts": cuts, "cut_count": len(cuts), "solver": args.solver,
        "symmetry_break": "1 in D (valid under D -> -D)",
        "elapsed_seconds": round(time.monotonic() - started, 6),
    }
    if status == "SAT_CONSTRUCTION" and args.verify_solver:
        result["independent_verifier"] = args.verify_solver
        result["independent_verification"] = (
            "PASS" if find_dominator(n, k, d, args.verify_solver) is None else "FAIL"
        )
    if status == "UNSAT_NO_CYCLIC_CONSTRUCTION" and args.verify_solver:
        result["independent_verifier"] = args.verify_solver
        result["independent_verification"] = (
            "PASS" if not solve_cnf(master, args.verify_solver)[0] else "FAIL"
        )
    write_receipt(args.receipt, result)
    return 0 if status in {"SAT_CONSTRUCTION", "UNSAT_NO_CYCLIC_CONSTRUCTION"} else 2


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--n", type=int, required=True)
    parser.add_argument("--k", type=int, required=True)
    parser.add_argument("--solver", default="cadical195")
    parser.add_argument("--verify-solver", default="glucose42")
    parser.add_argument("--max-iterations", type=int, default=1_000_000)
    parser.add_argument("--time-limit", type=float, default=0,
                        help="soft wall limit checked between SAT calls (seconds)")
    parser.add_argument("--progress", type=int, default=1000,
                        help="print every N cuts; 0 disables")
    parser.add_argument("--check-paley", action="store_true")
    parser.add_argument("--receipt")
    return run(parser.parse_args())


if __name__ == "__main__":
    raise SystemExit(main())
