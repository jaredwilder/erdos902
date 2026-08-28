# Antisymmetric factorization relaxation: killed

## Relaxation under test

Retain only a tournament adjacency matrix `A` and a row-`k` witness matrix `X` with

```text
A + A^T = J - I,
X <= A,
X 1 = k 1,
X BooleanMultiply (I + A) = J - I.
```

Equivalently, every vertex `a` chooses `k` out-neighbours such that every other vertex
is either chosen directly or beaten by a chosen relay.

## Exact counterfamily

For every `k >= 1`, take the cyclic tournament on `Z/(2k+1)` in which `a` beats

```text
a+1, a+2, ..., a+k.
```

Choose precisely those `k` out-neighbours as the witness row of `a`. If `a` does not
beat `b`, write the reverse cyclic distance as `r` with `1 <= r <= k`. Then

```text
p = a + (k+1-r)
```

is a chosen out-neighbour of `a` and beats `b`; indeed `b-p = k` modulo `2k+1`.
Thus the Boolean product is exactly `J-I`.

`Erdos902FactorizationFalsifier.lean` kernel-checks, for symbolic arbitrary `k`:

- the cyclic relation is a tournament;
- every witness row has cardinality exactly `k`;
- every witness row is exactly the corresponding out-neighbourhood;
- the Boolean factorization holds for every ordered pair;
- the vertex count is exactly `2k+1`.

Therefore the relaxation admits

```text
n = 2k+1,
```

which is exponentially smaller than the scale sought in Erdős #902. The relaxation
cannot imply even `n = Omega(2^k)`, let alone `Omega(k^(1+epsilon) 2^k)`.

## Court ruling

Permanently burned:

- private-witness factorization without the global `S_k` condition;
- bounded two-step relay/king arguments;
- Boolean-rank arguments using only the displayed factorization identities.

The full-strength surviving wall is exactly the simultaneous global condition

```text
for every k-set S, some tournament row contains all of S.
```

Any next asymptotic attack must use the fact that the same antisymmetric row family
covers **all** `k`-sets, not merely one private witness per row.
