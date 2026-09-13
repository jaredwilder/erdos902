# Erdős #902 — compact layerwise `f(4) >= 49` contradiction architecture

**Author:** Jared Wilder  
**Promoted to static GitHub:** 2026-09-13

## Status

This is a **candidate end-to-end contradiction architecture** assembled from already-public formal ingredients plus one external classification bridge.

It does **not** by itself remove the need to justify that external bridge. The point of this note is to make the final finite burden transparent and compact.

A serious `f(4)>=49` candidate writeup was already public in this repository before this note, so this document is not a priority/origination claim for the lower-bound candidate. It records a shorter composition exposed by the later Lean layers.

## Setup

Assume a 48-vertex `S_4` tournament and take the forced 23-vertex core `H` from `Erdos902F4Step.lean`.

For each of the 24 outside vertices `x`, define

\[
W_x=\{h\in H:x\to h\}.
\]

The existing formal reduction gives

\[
|W_x|\le12
\]

and, for every `h in H`,

\[
|W_x\cap N_H^-(h)|\le6.
\]

Call such a mask admissible. Let `R(W)` be the number of internally undominated 4-subsets of `H` contained in `W`.

## Layer 12

`Erdos902DRT23Rigidity.lean` forces every admissible 12-mask to be a closed out-neighborhood.

`Erdos902Capacity.lean` then gives:

- row 36: capacity exactly 66;
- row 35: capacity at most 65.

Hence uniformly

\[
R(W)\le66.
\]

## Layer 11

Both

- `Erdos902Layer11R35.lean`, and
- `Erdos902Layer11R36.lean`

prove that every admissible 11-mask has some `h` with

\[
|W\cap N_H^+(h)|\ge10.
\]

Those `\binom{10}{4}=210` four-subsets are internally dominated by `h`. Therefore

\[
R(W)\le\binom{11}{4}-\binom{10}{4}=330-210=120.
\]

In particular

\[
120<138=66+72.
\]

## Layers at most 10

Trivially,

\[
R(W)\le\binom{|W|}{4}.
\]

At the largest such layer,

\[
\binom{10}{4}=210=66+72\cdot2,
\]

and the same affine envelope is looser for smaller masks.

Thus every admissible mask obeys

\[
\boxed{R(W)\le66+72(12-|W|).}
\]

## Global deficit budget

There are 24 outside vertices.

Every `h in H` has total indegree at least 23 and exactly 11 in-neighbors inside `H`. The root vertex is beaten by `h`, so it is not an additional in-neighbor of `h`. Thus at least 12 of the 24 outside vertices beat each `h`.

Consequently

\[
\sum_x |W_x|\ge23\cdot12=276.
\]

Since each of the 24 masks has size at most 12,

\[
\sum_x(12-|W_x|)
=24\cdot12-\sum_x|W_x|
\le288-276=12.
\]

Therefore

\[
\sum_x R(W_x)
\le24\cdot66+72\sum_x(12-|W_x|)
\le24\cdot66+72\cdot12
=2448.
\]

## Collision with the surviving DRT(23) cores

The two surviving `S_3` DRT(23) cores contain respectively

\[
2475,\qquad2530
\]

internally undominated 4-sets.

Every such bad 4-set must be dominated by an outside vertex under `S_4`, hence must lie in the union of the repair families counted by the `R(W_x)`.

But

\[
2448<2475<2530.
\]

So either surviving core contradicts the global repair-capacity budget.

## Remaining bridge

The contradiction is immediate **once** one admits the external classification bridge that the forced DRT(23), `S_3` core is isomorphic to one of the two catalogue survivors.

That bridge is supported by the separate McKay-catalogue replay receipt in this repository, but the logical dependency is kept explicit here rather than hidden inside the phrase “computer checked.”

## Why this composition is useful

The finite burden separates cleanly into:

1. a formal size-12 rigidity/capacity theorem;
2. a formal size-11 domination theorem;
3. a trivial small-layer binomial estimate;
4. one elementary double count;
5. one external finite-classification bridge.

This is considerably easier to audit than treating an all-mask capacity computation as an opaque black box.
