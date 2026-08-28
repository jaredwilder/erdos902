# Private-cover route audit

## Verdict

The proposed condition “every selected row owns a private `k`-set” does **not** add
generic covering strength. For every finite cover it is exactly inclusion-irredundancy,
and every minimum-cardinality cover is irredundant. This is proved in
`Erdos902PrivateCoverBarrier.lean`.

Consequently, combining ordinary covering inequalities with private ownership cannot by
itself move the exponent of `k` in Erdős #902. Any improvement from the matrix
representation must use the remaining tournament-specific condition

```text
A_ij + A_ji = 1  (i != j)
```

in a way unavailable to generic set covers.

## Exact reduction that survives

Let `P_v` be a `k`-set whose unique common dominator is `v`, and let

```text
C_v = {v} union N^-(v).
```

The Lean module proves

```text
P_v intersect C_v = empty,
P_v intersect C_u != empty  when u != v.
```

Thus `(P_v,C_v)` is a Bollobás cross-intersecting set-pair system. This is a genuine,
kernel-checked reduction to a recognized extremal-set-theory object.

The classical set-pair inequality is nevertheless far too weak here. With
`|P_v| = k` and only the automatic bound `|C_v| <= n`, it gives at best

```text
n <= binom(k+n, k),
```

which is vacuous on the #902 scale. The stronger modern results for
`1`-cross-intersecting or linear systems require hypotheses such as
`|P_v intersect C_u| = 1` or pairwise linearity; private tournament witnesses do not
supply those hypotheses.

## Literature routing

- Bollobás cross-intersecting set-pair systems and the classical
  `m <= binom(a+b,a)` theorem are summarized, with modern strengthened hypotheses, by
  Füredi, Gyárfás and Király (2023):
  https://doi.org/10.1017/S0963548323000044
- Borowiecki, Grytczuk, Hałuszczak and Tuza (2003) reformulate a **bipartite variant**
  of Schütte's problem using intersecting families; it does not provide the missing
  inequality for the original self-indexed antisymmetric system:
  https://doi.org/10.1017/S0963548303005674
- Superimposed and cover-free codes impose noncontainment conditions involving unions
  or intersections of several codewords. Those hypotheses are not consequences of one
  private target per covering block, so their rate bounds cannot be imported here without
  an additional tournament lemma.

## The smaller live wall

The private-row component is burned. The remaining Round-2 question is now precisely:

> Prove a stronger-than-Bollobás inequality for the cross-intersecting pairs
> `(P_v, {v} union N^-(v))` using the fact that the second family is the system of
> closed in-neighbourhoods of one tournament and that the corresponding out-neighbourhoods
> cover every `k`-set.

Any claimed exponent improvement must enter through that coupled antisymmetry condition.
Re-running minimal-cover, private-element, generic Bollobás, cover-free-code, or ordinary
covering-array machinery without such a coupling is now a formally closed route.
