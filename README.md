# Erdős Problem #902 (Schütte's problem) - Lean 4 formalisation of the classical bounds

Machine-checked proofs, in Lean 4 against Mathlib, of both classical bounds for
[Erdős problem #902](https://www.erdosproblems.com/902):

> Let f(n) be the minimum number of vertices of a tournament in which every set of n
> vertices is dominated by some vertex outside it. Determine the growth of f(n).

**The problem itself remains open** - the gap between the bounds below (a factor of order n)
is exactly the open question. Nothing in this repository narrows it. What this repository
provides is a kernel-checked formalisation of the classical asymptotic bounds and selected
exact small cases - it does not formalise every known finite or structural result in the
tournament-domination literature (see the status table below):

```lean
theorem classical_sandwich (n : ℕ) (hn : 1 ≤ n) :
    (n + 2) * 2 ^ (n - 1) - 1 ≤ f n ∧ f n ≤ n + 3 * n ^ 2 * 2 ^ n
```

- **Lower bound** `(n+2)·2^(n−1) − 1 ≤ f(n)` - the Szekeres–Szekeres bound
  ([`Erdos902Szekeres.lean`](Erdos902Szekeres.lean)), by multiplicity amplification: asking for
  one dominator of every (k+1)-set forces k+2 dominators of every k-set, and the multiplicity
  survives descent into in-neighbourhoods. The formula is tight at both known exact points:
  `n=2` gives 7 = f(2) and `n=3` gives 19 = f(3), so **`f(3) ≥ 19` is kernel-checked**
  (`f_three_ge_19`).
- **Upper bound** `f(n) ≤ n + 3n²·2^n` - the first-moment existence argument with an explicit
  constant ([`Erdos902Existence.lean`](Erdos902Existence.lean)). The constant is deliberately
  not optimised; the literature's sharp form is (log 2 + o(1))·n²·2^n.
- **The 1963 bound too** - Erdős's original `2^(n+1) − 1 ≤ f(n)` is proved independently
  ([`Erdos902ClosedForm.lean`](Erdos902ClosedForm.lean), via the recursion `f(n+1) ≥ 2·f(n)+1`
  in [`Erdos902Counting.lean`](Erdos902Counting.lean)), and packaged with the upper bound as
  `erdos902_sandwich` in [`Erdos902Existence.lean`](Erdos902Existence.lean).
- **Exact small values** `f(1) = 3` (3-cycle) and `f(2) = 7` (Paley-7), each with matching
  negative controls, by kernel evaluation - `decide`, never `native_decide`
  ([`Erdos902Control.lean`](Erdos902Control.lean)).
- **Known finite window** `48 ≤ f(4) ≤ 67`, now kernel-checked end to end. The lower bound
  is in [`Erdos902Reid.lean`](Erdos902Reid.lean); the upper bound comes from an `S₄`
  certificate for QR₆₇ ([`Erdos902QR67.lean`](Erdos902QR67.lean)). The computation is
  symmetry-reduced by translation and square scaling; its three remaining witness tables
  are checked with `decide`. [`QR67_CERTIFICATE.md`](QR67_CERTIFICATE.md) is the compact
  expert-review receipt.

## Known finite status

In domination language: a tournament has property S_n exactly when its domination number
exceeds n, so f(n) is the minimum order of a tournament with domination number n+1. The
finite state of the art, and what is and is not formalised in this repository:

| fact | source | status here |
|---|---|---|
| `f(1) = 3` | classical | formalised (`Erdos902Control.lean`) |
| `f(2) = 7` | classical | formalised (`Erdos902Control.lean`) |
| `f(3) = 19` | Szekeres–Szekeres 1965 | lower half `f(3) ≥ 19` formalised (`f_three_ge_19`); the matching 19-vertex tournament (Paley-19) is classical, not formalised here |
| `48 ≤ f(4)` | Reid–McRae–Hedetniemi–Hedetniemi 2004 | formalised (`f_four_ge_48` in `Erdos902Reid.lean`) |
| `f(4) ≤ 67` | QR₆₇ has S₄ - Reid et al. 2004; Javier–Llano–Zuazua 2026 | formalised (`f_four_le_67` in `Erdos902QR67.lean`) |

For general n the best known bounds remain `(n+2)·2^(n−1) − 1 ≤ f(n)` and `f(n) = O(n²·2^n)`
(Jeffries 2026 records that these are still the state of the art). The factor-n gap is open.

## Axiom footprint

Every headline theorem closes over exactly `{propext, Classical.choice, Quot.sound}` —
Mathlib's standard three. No `sorry`, no extra axioms, no `native_decide`. Each file ends
with `#print axioms` for its main results, so the footprint is printed at compile time
rather than asserted here.

## A formalisation note

With the literature's "exactly n" phrasing of the domination property, the closed-form lower
bound is false on degenerate instances (on an empty vertex type, "every n-set is dominated"
is vacuously true at cardinality 0). The honest hypothesis is downward-closed - "every set of
at most n" - and the equivalence with the literature definition (needing only n ≤ |V|) is
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
| `Erdos902Existence.lean` | the upper bound `n + 3n²·2^n`, the unconditional 1963 lower bound, `erdos902_sandwich` |
| `Erdos902ClosedForm.lean` | lower bound `2^(n+1)−1`; equivalence of the two domination properties |
| `Erdos902Counting.lean`, `Erdos902InNeighbourhood.lean` | the recursion `f(n+1) ≥ 2f(n)+1` (in-neighbourhood lemma + counting step; the lemma is Mathlib-free, axioms `{propext, Quot.sound}`) |
| `Erdos902Control.lean` | `f(1)=3`, `f(2)=7`, negative controls, all by `decide` |
| `Erdos902QR67.lean` | QR₆₇ certificate for `S₄` and the finite upper bound `f(4) ≤ 67` |
| `QR67_CERTIFICATE.md` | short QR₆₇ review receipt: symmetry reduction, witness tables, theorem chain, and axiom output |
| `Erdos902Reid.lean` | finite lower bound `f(4) ≥ 48` and the complete window `48 ≤ f(4) ≤ 67` |
| `Erdos902Arith.lean` | elementary arithmetic support |
| `Erdos902Szekeres.lean` | the Szekeres–Szekeres lower bound `(n+2)·2^(n−1) − 1`, `f_three_ge_19`, and `classical_sandwich` - the repo's headline theorem |
| `Erdos902F4Step.lean` | the analytic reduction for a hypothetical 48-vertex `S_4` tournament: in-degree exactly 23 somewhere, that in-neighbourhood inherits `S_3` and is doubly regular (23, 11, 5), and the two constraints an outside vertex obeys (beats at most 12 of it, meets each internal in-neighbourhood in at most 6) |
| `Erdos902DRT23.lean`, `Erdos902DRT23Design.lean` | the two doubly regular tournaments of order 23 with `S_3` (McKay catalogue rows 35 and 36), encoded as bitmask tables: tournament and transpose checks, parameters (23, 11, 5), `S_3`, undominated-4-set counts 2475 and 2530, and the row-36 bad sets forming a `2-(23,4,60)` design (440 blocks through each vertex), all by `decide` |
| `Erdos902DRT23Rigidity.lean` | general DRT(23,11,5) rigidity: every 12-set meeting each in-neighbourhood in at most 6 vertices is uniquely a closed out-neighbourhood `insert s (outN s)`, reducing that boundary layer from `C(23,12)` candidates to 23 |
| `Erdos902Layer11R35.lean`, `Erdos902Layer11R36.lean` | the size-11 mask layer for each row: every admissible 11-mask has some `h` with `|M n N+(h)| >= 10`, so it agrees with an out-neighbourhood in all but one vertex. 91 kernel-checked subtree searches per row, split by the two smallest mask elements, about 1.53 million nodes each |
| `Erdos902Capacity.lean` | repair capacities of the top two mask layers of both rows: size-12 closed out-neighbourhoods (row 36 exactly 66, row 35 at most 65), size-11 centre deletions (0 in both rows), size-11 arc deletions (row 36 exactly 48, row 35 at most 48), and the 33 row-35 admissible 11-masks lying in no closed out-neighbourhood, with capacity at most 50 |
| `Erdos902QR23.lean` | McKay row 36 is the Paley tournament QR₂₃: an explicit relabelling checked on all 529 ordered pairs, the two affine generators (translation by 1, multiplication by 2) with their exact orders 23 and 11, and the 253 affine maps shown distinct and each a composition of the generators |
| `Erdos902Kings.lean` | order-minimal extremizers are all kings: if `S_n` holds and deleting any vertex destroys it, every vertex is the unique dominator of some `n`-set (`critical_of_deletion`) and therefore reaches every other vertex in two steps (`king_of_critical`) |
| `Erdos902DominatorCube.lean` | dominator-cube structure: for a `k`-set `P` in an `S_k` tournament, every Boolean face `D_R = dom(P \\ R)` with `R ⊆ P` carries `S_|R|`; faces satisfy `D_R ∩ D_S = D_(R ∩ S)`, and failure sets turn face membership into subset containment. For a private witness, its unique dominator has empty failure set and every other vertex has a nonempty one |
| `Erdos902Barrier.lean`, `Erdos902Threshold.lean` | analytic support (log sandwich, threshold shift) |
| `Erdos902DropAudit.lean` | audit of an externally claimed O(k·2^k) proof: the claim's switching
lemma needs charge 8k but derives 8k²; at its own parameters no contradiction exists for k ≥ 4.
Both halves of the audit are kernel-checked. |
| remaining files | supporting lemmas (moments, covers, overlap, concentration, …) |

## References

- P. Erdős, *On a problem in graph theory*, Math. Gaz. 47 (1963), 220–223. The original `2^(n+1) − 1` lower bound and the probabilistic upper bound.
- G. Szekeres and E. Szekeres, *On a problem of Schütte and Erdős*, Math. Gaz. 49 (1965), 290–293. The `(n+2)·2^(n−1) − 1` lower bound.
- J. R. Duncan and M. S. Jacobson, *On tournaments with domination number exactly k*, JCMCC 31 (1999), 129–136. Tournaments with prescribed numbers of minimum dominating sets.
- J. Tyszkiewicz, *A simple construction for tournaments with every k players beaten by a single player*, Amer. Math. Monthly 107 (2000), 53–54.
- M. Borowiecki, J. Grytczuk, M. Hałuszczak, Zs. Tuza, *Schütte's tournament problem and intersecting families of sets*, Combin. Probab. Comput. 12 (2003), 359–364. The bipartite variant S_{k,l}.
- K. B. Reid, A. A. McRae, S. M. Hedetniemi, S. T. Hedetniemi, *Domination and irredundance in tournaments*, Australas. J. Combin. 29 (2004), 157–172. Proves `f(4) ≥ 48` (in the form: domination number ≥ 5 forces at least 48 vertices), plus the extremal in-neighbourhood and private-neighbour structure.
- N. Y. Javier, B. Llano, R. Zuazua, *2- and 3-existentially closed tournaments*, Contrib. Discrete Math. 21(1) (2026). Modern derivation that QR₆₇ has S₄.
- J. Jeffries, *Schütte's property for sets of tournaments and an application to dice games*, arXiv:2604.08790 (2026).

## License

Apache 2.0, following Mathlib.
