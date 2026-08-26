# Erdős Problem #902 (Schütte's problem) — Lean 4 formalisation of the classical bounds

Machine-checked proofs, in Lean 4 against Mathlib, of both classical bounds for
[Erdős problem #902](https://www.erdosproblems.com/902):

> Let f(n) be the minimum number of vertices of a tournament in which every set of n
> vertices is dominated by some vertex outside it. Determine the growth of f(n).

**The problem itself remains open** — the gap between the bounds below (a factor of order n)
is exactly the open question. Nothing in this repository narrows it. What this repository
provides is a kernel-checked formalisation of what is known:

```lean
theorem erdos902_sandwich (n : ℕ) (hn : 1 ≤ n) :
    2 ^ (n + 1) - 1 ≤ f n ∧ f n ≤ n + 3 * n ^ 2 * 2 ^ n
```

- **Lower bound** `2^(n+1) − 1 ≤ f(n)` — Erdős's 1963 counting argument
  ([`Erdos902ClosedForm.lean`](Erdos902ClosedForm.lean), via the recursion
  `f(n+1) ≥ 2·f(n)+1` in [`Erdos902Counting.lean`](Erdos902Counting.lean)).
- **Upper bound** `f(n) ≤ n + 3n²·2^n` — the first-moment existence argument with an explicit
  constant ([`Erdos902Existence.lean`](Erdos902Existence.lean)). The constant is deliberately
  not optimised; the literature's sharp form is (log 2 + o(1))·n²·2^n.
- **Exact small values** `f(1) = 3` (3-cycle) and `f(2) = 7` (Paley-7), each with matching
  negative controls, by kernel evaluation — `decide`, never `native_decide`
  ([`Erdos902Control.lean`](Erdos902Control.lean)).

## Axiom footprint

Every headline theorem closes over exactly `{propext, Classical.choice, Quot.sound}` —
Mathlib's standard three. No `sorry`, no extra axioms, no `native_decide`. Each file ends
with `#print axioms` for its main results, so the footprint is printed at compile time
rather than asserted here.

## A formalisation note

With the literature's "exactly n" phrasing of the domination property, the closed-form lower
bound is false on degenerate instances (on an empty vertex type, "every n-set is dominated"
is vacuously true at cardinality 0). The honest hypothesis is downward-closed — "every set of
at most n" — and the equivalence with the literature definition (needing only n ≤ |V|) is
proved, not assumed, in [`Erdos902ClosedForm.lean`](Erdos902ClosedForm.lean).

## Verifying

```bash
elan toolchain install $(cat lean-toolchain)   # leanprover/lean4:v4.31.0-rc1
lake exe cache get                              # fetch Mathlib oleans
lake build                                      # builds Erdos902All → every file
```

Mathlib is pinned by `lake-manifest.json`. The root module `Erdos902All.lean` imports every
file, so a green `lake build` is a kernel check of the whole set.

## Layout

| file | contents |
|---|---|
| `Erdos902Existence.lean` | the upper bound, the unconditional lower bound, `erdos902_sandwich` |
| `Erdos902ClosedForm.lean` | lower bound `2^(n+1)−1`; equivalence of the two domination properties |
| `Erdos902Counting.lean` | the recursion `f(n+1) ≥ 2f(n)+1` |
| `Erdos902Control.lean` | `f(1)=3`, `f(2)=7`, negative controls, all by `decide` |
| `Erdos902Arith.lean` | elementary arithmetic support |
| `Erdos902Szekeres.lean` | Szekeres-style bound |
| `Erdos902Barrier.lean`, `Erdos902Threshold.lean` | analytic support (log sandwich, threshold shift) |
| `Erdos902DropAudit.lean` | audit of an externally claimed O(k·2^k) proof: the claim's switching
lemma needs charge 8k but derives 8k²; at its own parameters no contradiction exists for k ≥ 4.
Both halves of the audit are kernel-checked. |
| remaining files | supporting lemmas (moments, covers, overlap, concentration, …) |

## License

Apache 2.0, following Mathlib.
