#!/usr/bin/env python3
"""Classification-free SAT courts for the 48-vertex S4 reduction.

These formulas quantify over an arbitrary labelled DRT(23,11,5) with S3.
They are designed to remove any dependence on the external catalogue of 37
isomorphism classes.

Cases:

  size11
    Search for an 11-set W satisfying the outside-mask cap
        |W ∩ N^-(h)| <= 6 for every h
    but with
        |W ∩ N^+(h)| <= 9 for every h.
    By relabelling W is fixed to {0,...,10}.  UNSAT proves every admissible
    11-mask has some h with at least ten points in N^+(h), hence its repair
    capacity is at most C(11,4)-C(10,4)=120.

  size12
    Erdos902DRT23Rigidity already proves every admissible 12-mask is a closed
    out-neighbourhood.  Relabel its centre as 0 and fix N^+(0)={1,...,11}.
    Search for at least 67 triples B subset N^+(0) for which {0} union B has
    no common dominator.  UNSAT proves every admissible 12-mask repairs <=66.

  defects
    Search for a DRT(23,11,5) with S3 having at least 6407 dominated 4-sets,
    equivalently at most 2448 undominated 4-sets.  Fix N^+(0)={1,...,11}
    losslessly by relabelling.  UNSAT proves every possible 23-vertex core has
    at least 2449 defects, enough to beat the global 2448 repair budget.

UNSAT from the embedded solver is DISCOVERY EVIDENCE ONLY.  The generated static
DIMACS CNF is frozen and hashed so that a later external CaDiCaL + DRAT/LRAT
certificate can be checked independently before any mathematical claim is made.
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

from pysat.card import CardEnc, EncType
from pysat.formula import CNF, IDPool
from pysat.solvers import Solver

N = 23
K = 3


def sha256_file(path: Path) -> str:
    h = hashlib.sha256()
    with path.open('rb') as f:
        for chunk in iter(lambda: f.read(1 << 20), b''):
            h.update(chunk)
    return h.hexdigest()


class Builder:
    def __init__(self) -> None:
        self.pool = IDPool()
        self.cnf = CNF()
        self.edges = {}
        for u, v in itertools.combinations(range(N), 2):
            self.edges[(u, v)] = self.pool.id(('e', u, v))

    def beats(self, u: int, v: int) -> int:
        assert u != v
        return self.edges[(u, v)] if u < v else -self.edges[(v, u)]

    def equiv_and(self, key, lits: list[int]) -> int:
        z = self.pool.id(key)
        for lit in lits:
            self.cnf.append([-z, lit])
        self.cnf.append([z] + [-lit for lit in lits])
        return z

    def atmost(self, lits: list[int], bound: int) -> None:
        if bound >= len(lits):
            return
        enc = CardEnc.atmost(lits=lits, bound=bound, vpool=self.pool,
                             encoding=EncType.seqcounter)
        self.cnf.extend(enc.clauses)

    def atleast(self, lits: list[int], bound: int) -> None:
        if bound <= 0:
            return
        enc = CardEnc.atleast(lits=lits, bound=bound, vpool=self.pool,
                              encoding=EncType.seqcounter)
        self.cnf.extend(enc.clauses)

    def equals(self, lits: list[int], bound: int) -> None:
        enc = CardEnc.equals(lits=lits, bound=bound, vpool=self.pool,
                             encoding=EncType.seqcounter)
        self.cnf.extend(enc.clauses)

    def fix_standard_vertex0(self) -> None:
        """Lossless DRT relabelling: N+(0)=1..11 and N-(0)=12..22."""
        for v in range(1, 12):
            self.cnf.append([self.beats(0, v)])
        for v in range(12, 23):
            self.cnf.append([self.beats(v, 0)])

    def add_drt_s3(self) -> None:
        # Regularity: every vertex has outdegree 11.
        for u in range(N):
            self.equals([self.beats(u, v) for v in range(N) if v != u], 11)

        # Doubly regular: every pair has exactly five common out-neighbours.
        for u, v in itertools.combinations(range(N), 2):
            common = []
            for w in range(N):
                if w == u or w == v:
                    continue
                z = self.equiv_and(('co', u, v, w),
                                   [self.beats(u, w), self.beats(v, w)])
                common.append(z)
            self.equals(common, 5)

        # S3: every triple has a common dominator outside it.
        for xs in itertools.combinations(range(N), 3):
            occupied = set(xs)
            selectors = []
            for y in range(N):
                if y in occupied:
                    continue
                s = self.pool.id(('s3', xs, y))
                selectors.append(s)
                for x in xs:
                    self.cnf.append([-s, self.beats(y, x)])
            self.cnf.append(selectors)


def build_size11() -> tuple[Builder, dict]:
    b = Builder()
    b.add_drt_s3()
    # Relabel the distinguished violating 11-set W as 0..10.
    W = tuple(range(11))
    for h in range(N):
        in_hits = [b.beats(w, h) for w in W if w != h]
        out_hits = [b.beats(h, w) for w in W if w != h]
        b.atmost(in_hits, 6)   # admissible
        b.atmost(out_hits, 9)  # negation of "some overlap >= 10"
    return b, {
        'case': 'size11',
        'meaning': 'counterexample to universal 11-mask overlap>=10 lemma',
        'fixed_set_W': list(W),
    }


def build_size12() -> tuple[Builder, dict]:
    b = Builder()
    b.fix_standard_vertex0()
    b.add_drt_s3()
    # C_0={0} union N+(0)={0,...,11}.  Any four-subset not containing 0
    # is dominated by 0, so bad four-sets are exactly {0,b,c,d} where
    # b,c,d are in 1..11 and no y in 12..22 dominates all of b,c,d.
    bad_selectors = []
    for triple in itertools.combinations(range(1, 12), 3):
        q = b.pool.id(('badC0', triple))
        bad_selectors.append(q)
        for y in range(12, 23):
            # q -> not(y->b and y->c and y->d); y->0 is already fixed.
            b.cnf.append([-q] + [-b.beats(y, x) for x in triple])
    b.atleast(bad_selectors, 67)
    return b, {
        'case': 'size12',
        'meaning': 'DRT23 S3 closed out-neighbourhood with repair >=67',
        'fixed_center': 0,
        'fixed_outN0': list(range(1, 12)),
        'bad_threshold': 67,
    }


def build_defects() -> tuple[Builder, dict]:
    b = Builder()
    b.fix_standard_vertex0()
    b.add_drt_s3()

    # 330 four-sets entirely inside N+(0)={1..11} are automatically dominated by 0.
    known = set(itertools.combinations(range(1, 12), 4))
    assert len(known) == 330
    chosen_dominated = []
    for xs in itertools.combinations(range(N), 4):
        if xs in known:
            continue
        d = b.pool.id(('chosen_dom4', xs))
        chosen_dominated.append(d)
        occupied = set(xs)
        selectors = []
        for y in range(N):
            if y in occupied:
                continue
            s = b.pool.id(('dom4', xs, y))
            selectors.append(s)
            for x in xs:
                b.cnf.append([-s, b.beats(y, x)])
        # d can be true only if a genuine dominator selector is true.
        b.cnf.append([-d] + selectors)

    # bad <=2448 <=> dominated >=8855-2448=6407.  Of those, 330 are fixed.
    b.atleast(chosen_dominated, 6407 - 330)
    return b, {
        'case': 'defects',
        'meaning': 'DRT23 S3 with <=2448 undominated 4-sets',
        'total_four_sets': 8855,
        'bad_upper_bound': 2448,
        'dominated_lower_bound': 6407,
        'known_dominated_by_0': 330,
    }


def rows_from_model(model: list[int], b: Builder) -> list[str]:
    positive = {v for v in model if v > 0}
    rows = []
    for u in range(N):
        row = []
        for v in range(N):
            if u == v:
                row.append('0')
            else:
                lit = b.beats(u, v)
                truth = (lit in positive) if lit > 0 else ((-lit) not in positive)
                row.append('1' if truth else '0')
        rows.append(''.join(row))
    return rows


def verify_base(rows: list[str]) -> None:
    def beats(u, v): return rows[u][v] == '1'
    for u in range(N):
        assert sum(beats(u, v) for v in range(N) if v != u) == 11
    for u, v in itertools.combinations(range(N), 2):
        assert sum(beats(u, w) and beats(v, w)
                   for w in range(N) if w not in (u, v)) == 5
    for xs in itertools.combinations(range(N), 3):
        assert any(y not in xs and all(beats(y, x) for x in xs)
                   for y in range(N))


def bad4_count(rows: list[str]) -> int:
    def beats(u, v): return rows[u][v] == '1'
    bad = 0
    for xs in itertools.combinations(range(N), 4):
        if not any(y not in xs and all(beats(y, x) for x in xs)
                   for y in range(N)):
            bad += 1
    return bad


def verify_sat(case: str, rows: list[str]) -> dict:
    verify_base(rows)
    def beats(u, v): return rows[u][v] == '1'
    extra = {}
    if case == 'size11':
        W = set(range(11))
        inh = [sum(w != h and beats(w, h) for w in W) for h in range(N)]
        outh = [sum(w != h and beats(h, w) for w in W) for h in range(N)]
        assert max(inh) <= 6 and max(outh) <= 9
        extra.update({'max_in_hit': max(inh), 'max_out_hit': max(outh)})
    elif case == 'size12':
        assert all(beats(0, v) for v in range(1, 12))
        assert all(beats(v, 0) for v in range(12, 23))
        C = set(range(12))
        repair = 0
        for xs in itertools.combinations(C, 4):
            if not any(y not in xs and all(beats(y, x) for x in xs)
                       for y in range(N)):
                repair += 1
        assert repair >= 67
        extra['closed_out_repair'] = repair
    elif case == 'defects':
        bad = bad4_count(rows)
        assert bad <= 2448
        extra['bad4_count'] = bad
    return extra


def host_info() -> dict:
    return {
        'hostname': socket.gethostname(),
        'platform': platform.platform(),
        'python': platform.python_version(),
        'cpu_count': os.cpu_count(),
    }


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument('--case', choices=('size11', 'size12', 'defects'), required=True)
    ap.add_argument('--cnf', type=Path, required=True)
    ap.add_argument('--receipt', type=Path, required=True)
    ap.add_argument('--matrix', type=Path)
    ap.add_argument('--solver', default='cadical195')
    ap.add_argument('--generate-only', action='store_true')
    args = ap.parse_args()

    started = time.monotonic()
    build = {'size11': build_size11, 'size12': build_size12, 'defects': build_defects}[args.case]
    b, meta = build()
    generation_seconds = time.monotonic() - started

    args.cnf.parent.mkdir(parents=True, exist_ok=True)
    b.cnf.to_file(str(args.cnf))
    cnf_sha = sha256_file(args.cnf)
    receipt = {
        'schema': 'erdos902.f4-universal-meta-sat.v1',
        **meta,
        'variables': b.pool.top,
        'clauses': len(b.cnf.clauses),
        'cnf': str(args.cnf.resolve()),
        'cnf_sha256': cnf_sha,
        'generation_seconds': round(generation_seconds, 6),
        'host': host_info(),
    }

    if args.generate_only:
        receipt['status'] = 'GENERATED_NOT_SOLVED'
    else:
        solve_started = time.monotonic()
        with Solver(name=args.solver, bootstrap_with=b.cnf.clauses) as s:
            sat = s.solve()
            model = s.get_model() if sat else None
            stats = s.accum_stats()
        receipt.update({
            'solver': args.solver,
            'status': 'SAT_COUNTEREXAMPLE' if sat else 'UNSAT_DISCOVERY',
            'solve_seconds': round(time.monotonic() - solve_started, 6),
            'solver_stats': stats,
        })
        if sat:
            assert model is not None
            rows = rows_from_model(model, b)
            extra = verify_sat(args.case, rows)
            matrix = '\n'.join(rows) + '\n'
            receipt['independent_model_verification'] = 'PASS'
            receipt.update(extra)
            receipt['adjacency_sha256'] = hashlib.sha256(matrix.encode()).hexdigest()
            if args.matrix:
                args.matrix.parent.mkdir(parents=True, exist_ok=True)
                args.matrix.write_text(matrix, encoding='ascii')
                receipt['adjacency_matrix'] = str(args.matrix.resolve())
        else:
            receipt['unsat_warning'] = (
                'UNSAT is not yet a proof certificate. Freeze this exact CNF hash and '
                'obtain an independently checked DRAT/LRAT proof before claiming the lemma.'
            )

    args.receipt.parent.mkdir(parents=True, exist_ok=True)
    rendered_core = json.dumps(receipt, sort_keys=True, separators=(',', ':'))
    receipt['receipt_sha256'] = hashlib.sha256(rendered_core.encode()).hexdigest()
    args.receipt.write_text(json.dumps(receipt, indent=2, sort_keys=True) + '\n', encoding='utf-8')
    print(json.dumps(receipt, indent=2, sort_keys=True))
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
