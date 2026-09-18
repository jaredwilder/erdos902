# Order-49 Cayley tournament eliminations

For Schütte's tournament problem at `f(4)`, this note records an exact elimination of both Cayley-tournament families on groups of order 49.

There are exactly two groups of order 49:

\[
\mathbb Z/49\mathbb Z
\qquad\text{and}\qquad
\mathbb F_7^2.
\]

For each group, a Cayley tournament is determined by a skew half-set. Translation symmetry reduces the domination condition on four-sets to a finite SAT instance.

## Result

> **No Cayley tournament on either group of order 49 has the `S_4` domination property.**

For each family, the SAT instance is unsatisfiable and the unsatisfiability certificate was independently checked with `drat-trim`.

| group | variables | clauses | result |
|---|---:|---:|---|
| `Z/49Z` | 194,604 | 782,645 | UNSAT, DRAT verified |
| `F_7^2` | 194,604 | 782,645 | UNSAT, DRAT verified |

The group action reduces the 211,876 four-subsets to 4,324 translation orbits. The complete hashes and solver receipts are retained with the original computation.

## Scope

This is a construction-family theorem. It rules out Cayley tournaments of order 49; it does not rule out arbitrary 49-vertex tournaments.

A general order-49 SAT encoding was also generated, but the unrestricted instance was not decided within the recorded computational resources. That experiment is therefore a search boundary, not a mathematical conclusion.

## Historical source

The original computation note is retained as [`ORDER49_MONOLITHIC_ASSAULT.md`](ORDER49_MONOLITHIC_ASSAULT.md) so hashes and earlier references remain stable. This file is the recommended public reading surface for the result.

Author: Jared Wilder.
