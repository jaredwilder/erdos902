#!/usr/bin/env python3
"""Monolithic exact SAT decision for Cayley S4 tournaments on F_7^2.

The 24 primary variables choose one member of every inverse pair.  One
translation representative of each four-set gets 45 witness selectors.
All clauses are installed before the single SAT call; this is not CEGAR.
"""

from __future__ import annotations

import argparse
import hashlib
import itertools
import json
import time
from pathlib import Path

from pysat.solvers import Solver


Q = 7
N = Q * Q
K = 4


def add(u: int, v: int) -> int:
    return ((u // Q + v // Q) % Q) * Q + (u + v) % Q


def neg(u: int) -> int:
    return (-(u // Q) % Q) * Q + (-(u % Q) % Q)


def sub(u: int, v: int) -> int:
    return add(u, neg(v))


def inverse_pairs() -> tuple[list[tuple[int, int]], dict[int, int]]:
    pairs: list[tuple[int, int]] = []
    lit: dict[int, int] = {}
    unseen = set(range(1, N))
    while unseen:
        a = min(unseen)
        b = neg(a)
        lo, hi = sorted((a, b))
        pairs.append((lo, hi))
        var = len(pairs)
        lit[lo] = var
        lit[hi] = -var
        unseen.remove(a)
        unseen.remove(b)
    assert len(pairs) == 24 and len(lit) == 48
    return pairs, lit


def canonical_translate(xs: tuple[int, ...]) -> tuple[int, ...]:
    # A lexicographically least translate contains 0, hence it suffices to
    # translate each member of X to 0.
    return min(tuple(sorted(sub(x, anchor) for x in xs)) for anchor in xs)


def orbit_representatives() -> list[tuple[int, ...]]:
    reps = {canonical_translate(xs) for xs in itertools.combinations(range(N), K)}
    answer = sorted(reps)
    assert len(answer) == 4324
    return answer


def dimensions(reps: list[tuple[int, ...]]) -> tuple[int, int]:
    variables = 24 + len(reps) * (N - K)
    clauses = 1 + len(reps) * ((N - K) * K + 1)
    return variables, clauses


def clauses(reps: list[tuple[int, ...]], membership: dict[int, int]):
    # D -> -D is an isomorphism, so orient the first inverse pair positively.
    yield [1]
    selector = 24
    for xs in reps:
        occupied = set(xs)
        witness_vars = []
        for y in range(N):
            if y in occupied:
                continue
            selector += 1
            witness_vars.append(selector)
            for x in xs:
                delta = sub(y, x)
                assert delta != 0
                # s_(X,y) -> y-x not in D.
                yield [-selector, -membership[delta]]
        assert len(witness_vars) == 45
        yield witness_vars


def write_dimacs(path: Path, reps: list[tuple[int, ...]], membership: dict[int, int]) -> str:
    nvars, nclauses = dimensions(reps)
    digest = hashlib.sha256()
    with path.open("wb") as out:
        header = f"p cnf {nvars} {nclauses}\n".encode()
        out.write(header)
        digest.update(header)
        count = 0
        for clause in clauses(reps, membership):
            line = (" ".join(map(str, clause)) + " 0\n").encode()
            out.write(line)
            digest.update(line)
            count += 1
    assert count == nclauses
    return digest.hexdigest()


def solve_once(name: str, reps: list[tuple[int, ...]], membership: dict[int, int], proof: bool):
    started = time.monotonic()
    with Solver(name=name, with_proof=proof) as solver:
        solver.append_formula(clauses(reps, membership))
        sat = solver.solve()
        model = solver.get_model() if sat else None
        trace = solver.get_proof() if (proof and not sat) else None
    return sat, model, trace, time.monotonic() - started


def selected_half_set(model: list[int], pairs: list[tuple[int, int]]) -> list[int]:
    positive = {v for v in model if 0 < v <= 24}
    return [lo if i in positive else hi for i, (lo, hi) in enumerate(pairs, 1)]


def exhaustive_verify(d: list[int]) -> tuple[bool, tuple[int, ...] | None]:
    dset = set(d)
    for xs in itertools.combinations(range(N), K):
        occupied = set(xs)
        if not any(
            all(sub(y, x) not in dset for x in xs)
            for y in range(N) if y not in occupied
        ):
            return False, xs
    return True, None


def adjacency(d: list[int]) -> list[str]:
    dset = set(d)
    # A[u][v] = 1 iff u -> v.  This matches witness condition u-v notin D.
    return ["".join("0" if u == v else ("1" if sub(u, v) not in dset else "0")
                    for v in range(N)) for u in range(N)]


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--solver", default="cadical195")
    parser.add_argument("--verify-solver", default="glucose42")
    parser.add_argument("--out-dir", type=Path, default=Path("tools/order49_f7sq_receipt"))
    parser.add_argument("--write-cnf", action="store_true")
    parser.add_argument("--proof", action="store_true",
                        help="retain the primary solver's proof trace if UNSAT")
    parser.add_argument("--skip-independent", action="store_true",
                        help="skip the second solver (use only for proof regeneration)")
    args = parser.parse_args()
    args.out_dir.mkdir(parents=True, exist_ok=True)

    total_started = time.monotonic()
    pairs, membership = inverse_pairs()
    reps = orbit_representatives()
    nvars, nclauses = dimensions(reps)
    cnf_sha256 = None
    if args.write_cnf:
        cnf_path = args.out_dir / "order49_f7sq.cnf"
        cnf_sha256 = write_dimacs(cnf_path, reps, membership)

    sat1, model1, proof, elapsed1 = solve_once(args.solver, reps, membership, args.proof)
    if args.skip_independent:
        sat2, model2, elapsed2 = sat1, model1, 0.0
    else:
        sat2, model2, _, elapsed2 = solve_once(args.verify_solver, reps, membership, False)
        if sat1 != sat2:
            raise RuntimeError("independent solvers disagree")

    receipt: dict = {
        "group": "F_7^2", "order": N, "k": K,
        "encoding": "monolithic translation-quotiented exact witness selectors",
        "translation_orbits": len(reps), "primary_variables": 24,
        "variables": nvars, "clauses": nclauses,
        "symmetry_break": "first inverse-pair representative is in D (D -> -D)",
        "solver": args.solver, "solver_seconds": round(elapsed1, 6),
        "independent_solver": args.verify_solver,
        "independent_solver_seconds": round(elapsed2, 6),
        "independent_agreement": not args.skip_independent,
        "status": "SAT_CONSTRUCTION" if sat1 else "UNSAT_NO_F7SQ_CAYLEY_S4",
        "cnf_sha256": cnf_sha256,
    }
    if sat1:
        assert model1 is not None and model2 is not None
        d = selected_half_set(model1, pairs)
        verified, bad = exhaustive_verify(d)
        receipt.update({"D_indices": d,
                        "D_pairs": [[u // Q, u % Q] for u in d],
                        "exhaustive_4set_verification": verified,
                        "failed_4set": bad})
        if not verified:
            raise RuntimeError(f"SAT model failed exhaustive verification at {bad}")
        matrix = adjacency(d)
        (args.out_dir / "adjacency_matrix.txt").write_text("\n".join(matrix) + "\n")
        receipt["adjacency_sha256"] = hashlib.sha256(
            ("\n".join(matrix) + "\n").encode()).hexdigest()
    elif proof is not None:
        proof_path = args.out_dir / "order49_f7sq.drat"
        proof_path.write_text("\n".join(proof) + "\n", encoding="ascii")
        receipt["proof_lines"] = len(proof)
        receipt["proof_sha256"] = hashlib.sha256(proof_path.read_bytes()).hexdigest()

    receipt["total_seconds"] = round(time.monotonic() - total_started, 6)
    rendered = json.dumps(receipt, indent=2, sort_keys=True) + "\n"
    (args.out_dir / "receipt.json").write_text(rendered, encoding="utf-8")
    print(rendered, end="")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
