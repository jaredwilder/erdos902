# Candidate theorem: `f(4) >= 49`

**Author:** Jared Wilder  
**Source date:** 2026-08-27  
**Public release:** 2026-09-11  
**Status:** **SERIOUS COMPUTER-ASSISTED PROOF CANDIDATE — NOT YET PROMOTED TO CANONICAL THEOREM**

The analytic reduction below should be Lean-formalized. The final finite step uses the published-complete classification of doubly regular tournaments on 23 vertices. No priority claim is made here.

## Candidate claim

There is no 48-vertex tournament with Schütte property `S_4`. Hence the candidate conclusion is

`f(4) >= 49`.

Together with the repository's established upper bound `f(4) <= 67`, this would narrow the current internal window to

`49 <= f(4) <= 67`.

## 1. Assume a 48-vertex `S_4` tournament

Let `T` be a tournament on 48 vertices with `S_4`.

Existing kernel-checked Szekeres amplification gives:

- every set of at most 3 vertices has at least 5 common dominators (`HasSleM 3 5`);
- every distinct pair has at least 11 common dominators;
- every vertex has indegree at least 23.

The average indegree is `47/2=23.5`, so some vertex `v` has indegree exactly 23.

Let

`H=N^-(v)`.

Then `|H|=23`, while `N^+(v)` has 24 vertices.

## 2. `H` has `S_3`

For any triple `A subset H`, apply `S_4` in `T` to `A union {v}`. Any common dominator of those four vertices beats `v`, so lies in `H` and dominates `A`.

Therefore

> `H` has property `S_3`.

## 3. `H` is a `DRT(23,11,5)`

Multiplicity descent into `H` gives `HasSleM 2 5`. Descending once more at any `h in H` gives indegree at least

`(5+1)2^1 - 1 = 11`.

Since the average indegree of a 23-vertex tournament is exactly 11, every vertex of `H` has indegree and outdegree 11.

Every pair has at least five common dominators. But the total pair/common-dominator incidence count is

`23*C(11,2)=1265=5*C(23,2)`.

So the average pair codegree is exactly 5; therefore every pair has codegree exactly 5.

Hence

> `H` is a doubly regular tournament `DRT(23,11,5)`.

This entire reduction is analytic and should be formalizable from existing repository machinery.

## 4. Complete DRT(23) classification leaves two local types

Brendan McKay's complete catalogue contains 37 nonisomorphic `DRT(23)` tournaments. The audit script in this directory checks:

- all 37 rows are `DRT(23,11,5)`;
- exactly two have `S_3`;
- they are catalogue lines 35 and 36 (1-indexed).

## 5. Bad 4-sets

For a surviving local tournament `H`, call a four-set `Q subset H` **bad** if no vertex of `H` dominates all of `Q`.

Exact counts:

- catalogue line 35: `2475` bad four-sets;
- catalogue line 36: `2530` bad four-sets.

Every bad four-set must be dominated from outside `H`. The root `v` cannot do so, hence only the 24 vertices of `N^+(v)` can repair them.

## 6. Constraints on one outside vertex

Fix `x in N^+(v)` and define

`W_x={h in H : x -> h}`.

A bad four-set can be repaired by `x` only if it is contained in `W_x`.

Two exact `S_4` consequences are:

### A. `|W_x| <= 12`

The common dominators of `{v,x}` are exactly `H \ W_x`. There are at least 11, hence `|W_x|<=12`.

### B. `|W_x intersect N_H^-(h)| <= 6` for every `h in H`

The triple `{v,x,h}` has at least five common dominators. They lie in `N_H^-(h) \ W_x`. Since `d_H^-(h)=11`, at most six in-neighbors of `h` can lie in `W_x`.

These are theorem consequences, not heuristic filters.

## 7. Exhaust every outside interaction mask

For each of the two surviving DRTs, enumerate all `2^23` subsets `W subset H`. Keep only masks satisfying

- `|W|<=12`;
- `|W intersect N_H^-(h)|<=6` for every `h`.

For each feasible `W`, count how many bad four-sets it contains.

The exact maxima are:

- line 35: **65**;
- line 36: **66**.

`f4_ge49_catalogue_audit.py` recomputes these values directly from McKay's canonical catalogue.

## 8. Final counting contradiction

Only 24 outside vertices are available. Even allowing repair families to overlap arbitrarily favorably,

`24*65 = 1560 < 2475`,

and

`24*66 = 1584 < 2530`.

Equivalently, either local type would need at least

`ceil(2475/65)=ceil(2530/66)=39`

outside repair vertices, but only 24 exist.

Therefore the candidate proof concludes that no 48-vertex `S_4` tournament exists and hence

`f(4)>=49`.

## Why this is still labelled a candidate

The finite audit is explicit and reproducible, but the public repository should not silently promote the result before the following chain is formalized/audited end-to-end:

1. order-48 indegree-23 extraction;
2. inheritance of `S_3` into the 23-vertex in-neighborhood;
3. derivation of the doubly-regular parameters;
4. the two outside-mask inequalities;
5. transparent use of completeness of the published 37-isomorphism DRT(23) catalogue.

The only external classification input is completeness of that catalogue. A future formalization should expose that dependency rather than hide it.

## Novelty boundary

The 2026-08-27 source search found the published lower bound `f(4)>=48` and the known `QR_67` upper construction, but no ordinary-`S_4` statement `f(4)>=49`. That is promising evidence, **not a priority certificate**.