# Exact cyclic skew-cover CEGAR audit

This is a construction-side experiment for the full global tournament property.
For odd `n`, choose one residue from every pair `{a,-a}` to form `D`, put
`H = D ∪ {0}`, and orient `x → y` when `y-x ∈ D`.  A set `X` dominates this
tournament exactly when `X + H = Z/nZ`.  Thus the target is precisely
`τ(H,Z/nZ) > k`; no local-witness relaxation is used.

## Reproducer

[`tools/cyclic_skew_cegar.py`](tools/cyclic_skew_cegar.py) implements two exact
SAT problems:

1. The master chooses the `(n-1)/2` signs defining a skew half-set `D`.
2. The adversary asks whether some `|X| ≤ k` covers `Z/nZ` by `X+H`.
3. A found `X` adds the exact cut
   `∃ y ∉ X, ∀ x ∈ X, y-x ∉ D`.

Counterexamples are translated to contain `0`, which is lossless for a Cayley
tournament.  The master also fixes `1 ∈ D`, losslessly quotienting the
`D ↔ -D` symmetry.  Terminal master UNSAT is replayed with a second SAT solver;
terminal constructions are independently checked by the second solver.

Requires Python and `python-sat`.  Examples:

```text
python tools/cyclic_skew_cegar.py --k 3 --n 17 --receipt tools/receipt-k3-n17.json
python tools/cyclic_skew_cegar.py --k 4 --n 67 --check-paley --receipt tools/receipt-paley67.json
```

The JSON receipts contain every adversarial cut and a SHA-256 digest.  They are
replay material, not proof certificates for a formally verified SAT checker.

## Exact completed runs

| `k` | `n` | result | cuts | second solver |
|---:|---:|:---|---:|:---:|
| 2 | 5 | no cyclic construction | 2 | pass |
| 2 | 7 | construction `D={1,2,4}` | 2 | pass |
| 3 | 17 | no cyclic construction | 17 | pass |
| 3 | 19 | Paley construction | direct check | pass |
| 4 | 33 | no cyclic construction | 101 | pass |
| 4 | 35 | no cyclic construction | 132 | pass |
| 4 | 37 | no cyclic construction | 165 | pass |
| 4 | 39 | no cyclic construction | 203 | pass |
| 4 | 41 | no cyclic construction | 245 | pass |
| 4 | 43 | no cyclic construction | 329 | pass |
| 4 | 45 | no cyclic construction | 373 | pass |
| 4 | 67 | Paley construction | direct check | pass |

The `k=4`, `n=33..45` computations are a cyclic-subclass audit inside the
already known global lower bound `f(4) ≥ 48`; they are not a new bound on
`f(4)`.  Bounded exploratory runs at `n=49` and `n=65` were inconclusive and
are recorded as `TIME_LIMIT`, not as negative results.  Paley half-sets at
orders 47 and 59 fail, with dominating sets `{0,4,7,9}` and `{0,7,9,12}`
respectively.

## Verdict

The exact engine is viable and rapidly recovers the sharp small transitions,
but this round found neither an order below 67 for `k=4` nor evidence strong
enough to kill the cyclic/Cayley program asymptotically.  The honest output is
therefore a reproducible theorem-discovery/falsification engine plus a measured
finite barrier—not an asymptotic claim.
