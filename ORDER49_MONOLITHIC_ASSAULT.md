# Order-49 monolithic assault

This round freezes the earlier CEGAR experiment and installs every target
four-set constraint before solving.  It uses the exact condition

```text
for every four-set X, some y outside X beats every x in X.
```

No local-witness relaxation is present.

## The two Cayley groups: certified UNSAT

There are two groups of order 49.  For each one, a skew half-set has 24 sign
variables.  Translation reduces the 211,876 four-sets to 4,324 full orbits.
The resulting frozen formula has 194,604 variables and 782,645 clauses.

| group | CNF SHA-256 | CaDiCaL | Glucose | DRAT |
|---|---|---:|---:|---|
| `Z/49Z` | `d15829cf...29667d6` | UNSAT, 98.96 s | UNSAT, 879.42 s | VERIFIED |
| `F_7^2` | `8f471ccb...272bb2` | UNSAT, 99.25 s | UNSAT, 808.50 s | VERIFIED |

The proof traces were checked by `drat-trim` commit
`2e3b2dc0ecf938addbd779d42877b6ed69d9a985`.  The verification receipts record
the full hashes, core sizes, and resolution-step counts.  Compressed proof
files decompress to the exact proof hashes in those receipts.

Consequently, **no Cayley tournament on either group of order 49 has `S_4`**.
This is a subclass result only; it does not decide arbitrary tournaments.

## General order 49

[`tools/order49_general_monolithic.py`](tools/order49_general_monolithic.py)
streams the unquotiented general instance.  It has:

```text
1,176 tournament-edge variables
9,534,420 witness selectors
9,535,596 total variables
211,876 four-set targets
38,349,557 clauses (including one safe vertex-relabeling symmetry unit)
```

The frozen CNF generated in 53.89 seconds with SHA-256
`2de45dca43fc37607a8c78069b29bb006a8818848408c4195f21544a041e619a`.
The generator includes a native monolithic solve path.  A SAT result is turned
into a 49-row adjacency matrix and independently checked over all 211,876
four-sets before it can be reported.

The raw instance exceeded the practical memory limit of a WSL CaDiCaL 3.0.1
run.  A native CaDiCaL195 run was then split exhaustively using the necessary
minimum-indegree bound: either a minimum-degree vertex has indegree 23, or the
tournament is regular of indegree 24.  The indegree-23 branch remained
undecided after 19,344 CPU seconds (5.37 CPU-hours) and was stopped.  These are
resource measurements, not evidence of satisfiability or unsatisfiability;
the unrestricted order-49 problem remains open in this artifact.

## Certificate boundary

`UNSAT` means nothing publicly until a proof-producing rerun and independent
DRAT/LRAT verification complete.  `SAT` means nothing until the exhaustive
matrix check passes.  Solver timeouts and memory failures are operational
facts, never mathematical conclusions.
