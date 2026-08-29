#!/usr/bin/env python3
"""Exact monolithic SAT decision for cyclic S_4 tournaments on Z/49Z.

This is deliberately independent of cyclic_skew_cegar.py.  It generates one
CNF containing every translation orbit of four-sets, solves that frozen CNF,
and exhaustively verifies any returned orientation.
"""

from __future__ import annotations

import argparse
import hashlib
import itertools
import json
import os
import platform
import sys
import time
from pathlib import Path

from pysat.formula import CNF
from pysat.solvers import Solver


N = 49
K = 4
HALF = (N - 1) // 2
EXPECTED_REPS = 4324
EXPECTED_SELECTORS = EXPECTED_REPS * (N - K)
EXPECTED_VARS = HALF + EXPECTED_SELECTORS
EXPECTED_CLAUSES = 1 + EXPECTED_REPS * (1 + K * (N - K))


def canonical_translate(xs: tuple[int, ...]) -> tuple[int, ...]:
    """Lexicographically least translate of a subset of Z/49Z."""
    return min(tuple(sorted((x - a) % N for x in xs)) for a in xs)


def orbit_representatives():
    for xs in itertools.combinations(range(N), K):
        if xs == canonical_translate(xs):
            yield xs


def membership_literal(delta: int) -> int:
    """Literal saying nonzero delta belongs to the chosen skew half-set D."""
    if not 1 <= delta < N:
        raise ValueError(f"expected nonzero residue, got {delta}")
    return delta if delta <= HALF else -(N - delta)


def sha256_file(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def build_cnf(path: Path, metadata_path: Path) -> dict:
    started = time.perf_counter()
    path.parent.mkdir(parents=True, exist_ok=True)
    reps = list(orbit_representatives())
    if len(reps) != EXPECTED_REPS:
        raise RuntimeError(f"representative count {len(reps)} != {EXPECTED_REPS}")

    with path.open("w", encoding="ascii", newline="\n") as out:
        out.write(f"p cnf {EXPECTED_VARS} {EXPECTED_CLAUSES}\n")
        # Replacing D by -D preserves the property, so choose 1 in D WLOG.
        out.write("1 0\n")
        selector = HALF
        clauses = 1
        for xs in reps:
            selectors: list[int] = []
            xset = set(xs)
            for y in range(N):
                if y in xset:
                    continue
                selector += 1
                selectors.append(selector)
                for x in xs:
                    # The memo's convention: y beats x iff y-x is not in D.
                    lit_in_d = membership_literal((y - x) % N)
                    out.write(f"-{selector} {-lit_in_d} 0\n")
                    clauses += 1
            out.write(" ".join(map(str, selectors)) + " 0\n")
            clauses += 1

    if selector != EXPECTED_VARS or clauses != EXPECTED_CLAUSES:
        raise RuntimeError((selector, clauses))
    result = {
        "schema": "erdos902.order49-z49-monolithic-cnf.v1",
        "n": N,
        "k": K,
        "translation_orbits": len(reps),
        "orientation_variables": HALF,
        "selector_variables": EXPECTED_SELECTORS,
        "variables": EXPECTED_VARS,
        "clauses": EXPECTED_CLAUSES,
        "symmetry": "1 in D (valid under D -> -D)",
        "cnf": str(path.resolve()),
        "cnf_sha256": sha256_file(path),
        "build_seconds": time.perf_counter() - started,
    }
    metadata_path.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    return result


def orientation_from_model(model: list[int]) -> list[int]:
    positive = {lit for lit in model if 0 < lit <= HALF}
    return [r if r in positive else N - r for r in range(1, HALF + 1)]


def exhaustive_check(d_values: list[int]) -> dict:
    started = time.perf_counter()
    d = set(d_values)
    if len(d) != HALF or any(((N - a) % N) in d for a in d):
        raise ValueError("D is not a skew half-set")
    checked = 0
    for xs in itertools.combinations(range(N), K):
        checked += 1
        xset = set(xs)
        witness = next(
            (
                y
                for y in range(N)
                if y not in xset and all(((y - x) % N) not in d for x in xs)
            ),
            None,
        )
        if witness is None:
            return {
                "valid": False,
                "checked_four_sets": checked,
                "counterexample": list(xs),
                "seconds": time.perf_counter() - started,
            }
    return {
        "valid": True,
        "checked_four_sets": checked,
        "seconds": time.perf_counter() - started,
    }


def adjacency_matrix(d_values: list[int]) -> list[str]:
    d = set(d_values)
    # Entry (u,v)=1 means u -> v.  Under the CNF convention this is v-u in D.
    return [
        "".join("0" if u == v else ("1" if (v - u) % N in d else "0") for v in range(N))
        for u in range(N)
    ]


def solve_cnf(
    cnf_path: Path,
    solver_name: str,
    receipt_path: Path,
    artifact_prefix: Path,
    proof_path: Path | None,
) -> dict:
    started_load = time.perf_counter()
    formula = CNF(from_file=str(cnf_path))
    load_seconds = time.perf_counter() - started_load
    started = time.perf_counter()
    with Solver(
        name=solver_name,
        bootstrap_with=formula.clauses,
        with_proof=proof_path is not None,
    ) as solver:
        sat = solver.solve()
        solve_seconds = time.perf_counter() - started
        stats = solver.accum_stats()
        model = solver.get_model() if sat else None
        proof = solver.get_proof() if (not sat and proof_path is not None) else None

    receipt = {
        "schema": "erdos902.order49-z49-monolithic-result.v1",
        "n": N,
        "k": K,
        "solver": solver_name,
        "result": "SAT" if sat else "UNSAT",
        "cnf": str(cnf_path.resolve()),
        "cnf_sha256": sha256_file(cnf_path),
        "python": sys.version,
        "platform": platform.platform(),
        "load_seconds": load_seconds,
        "solve_seconds": solve_seconds,
        "solver_stats": stats,
    }
    if sat:
        d_values = orientation_from_model(model or [])
        check = exhaustive_check(d_values)
        if not check["valid"]:
            raise RuntimeError(f"SAT model failed exhaustive check: {check}")
        matrix = adjacency_matrix(d_values)
        json_path = artifact_prefix.with_suffix(".json")
        matrix_path = artifact_prefix.with_suffix(".adjacency.txt")
        artifact = {
            "schema": "erdos902.order49-z49-s4-tournament.v1",
            "group": "Z/49Z",
            "D": d_values,
            "arc_rule": "u -> v iff (v-u) mod 49 is in D",
            "exhaustive_check": check,
            "adjacency_matrix_rows": matrix,
        }
        json_path.write_text(json.dumps(artifact, indent=2) + "\n", encoding="utf-8")
        matrix_path.write_text("\n".join(matrix) + "\n", encoding="ascii")
        receipt.update(
            {
                "D": d_values,
                "exhaustive_check": check,
                "artifact_json": str(json_path.resolve()),
                "artifact_sha256": sha256_file(json_path),
                "adjacency_matrix": str(matrix_path.resolve()),
                "adjacency_sha256": sha256_file(matrix_path),
            }
        )
    elif proof_path is not None:
        if proof is None:
            receipt["proof"] = "solver returned no proof"
        else:
            proof_path.write_text("\n".join(proof) + "\n", encoding="ascii")
            receipt["proof"] = str(proof_path.resolve())
            receipt["proof_sha256"] = sha256_file(proof_path)
            receipt["proof_lines"] = len(proof)
    receipt_path.write_text(json.dumps(receipt, indent=2) + "\n", encoding="utf-8")
    return receipt


def verify_artifact(path: Path) -> dict:
    artifact = json.loads(path.read_text(encoding="utf-8"))
    d_values = artifact["D"]
    result = exhaustive_check(d_values)
    expected = adjacency_matrix(d_values)
    if artifact.get("adjacency_matrix_rows") != expected:
        raise RuntimeError("stored adjacency matrix does not match D")
    result["artifact_sha256"] = sha256_file(path)
    return result


def main() -> int:
    parser = argparse.ArgumentParser()
    sub = parser.add_subparsers(dest="command", required=True)
    build = sub.add_parser("build")
    build.add_argument("--cnf", type=Path, required=True)
    build.add_argument("--metadata", type=Path, required=True)
    solve = sub.add_parser("solve")
    solve.add_argument("--cnf", type=Path, required=True)
    solve.add_argument("--solver", required=True)
    solve.add_argument("--receipt", type=Path, required=True)
    solve.add_argument("--artifact-prefix", type=Path, required=True)
    solve.add_argument("--proof", type=Path)
    verify = sub.add_parser("verify")
    verify.add_argument("--artifact", type=Path, required=True)
    args = parser.parse_args()

    if args.command == "build":
        result = build_cnf(args.cnf, args.metadata)
    elif args.command == "solve":
        result = solve_cnf(
            args.cnf, args.solver, args.receipt, args.artifact_prefix, args.proof
        )
    else:
        result = verify_artifact(args.artifact)
    print(json.dumps(result, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
