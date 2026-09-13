# Erdős #902 — DRT(23) McKay catalogue replay receipt

**Author:** Jared Wilder  
**Promoted to static GitHub:** 2026-09-13

## Status

The verifier and workflow were already public. This note promotes the concrete successful output from GitHub Actions into a static result record.

This is an **external-to-internal finite classification receipt**. It is evidence for the catalogue bridge used by the `f(4)>=49` candidate architecture; it is not a substitute for stating that dependency explicitly.

## Public implementation

Session commits recorded by the release-day report:

- verifier: `d52b297633e0bdc36461622daad0b72079239bdb`;
- workflow: `58f2fdefcc1898af06c879626e572053036fded2`.

Workflow run:

- `34613940311` — **SUCCESS**.

The verifier downloaded Brendan McKay's complete DRT(23) catalogue and checked all 37 objects.

## Frozen catalogue input

- source URL: `https://users.cecs.anu.edu.au/~bdm/data/drtourn23.txt`;
- objects: **37**;
- bits per object: **253**;
- catalogue SHA-256:

```text
20dbad06e128f968e87ce5bec9ca3128b8d2e9a9f25152b29d82c48c967b45d0
```

## Forward-orientation `S_3` survivors

Exactly two catalogue rows survive the forward-orientation `S_3` filter recorded by the verifier.

### Row 35

- internally undominated four-sets: **2475**;
- row-bit SHA-256:

```text
3beab603fe0eab600098754d9f6771521c5ca2794cf28d7ea94532d75d4a2f4f
```

### Row 36

- internally undominated four-sets: **2530**;
- row-bit SHA-256:

```text
49a97a786e9c85ef4e5a3da234b2bb2cec9740933ccf5f5067f02e5fbe178544
```

## Converse-orientation control

Reversing the orientation convention yields the control survivors:

### Row 1

- internally undominated four-sets: **2475**;
- row-bit SHA-256:

```text
632fb7fe4e1fa55122dba8ed86eb11c836d847cf564f7daebdc29c53c462f8c2
```

### Row 36

- internally undominated four-sets: **2530**;
- row-bit SHA-256:

```text
49a97a786e9c85ef4e5a3da234b2bb2cec9740933ccf5f5067f02e5fbe178544
```

Thus the isomorphism-level invariant multiset `{2475,2530}` is stable under reversing the orientation convention.

## Workflow artifact

- artifact ID: `10269446949`;
- artifact ZIP SHA-256:

```text
f8d3adee2d4dfd1a6988a4d464e3f58462b474efcc8898cb27146222eaca2c93
```

## Role in the `f(4)>=49` candidate

The layerwise contradiction note in this repository derives a universal repair-capacity budget of **2448** for the outside vertices of a hypothetical 48-vertex `S_4` tournament.

The two surviving catalogue cores require **2475** or **2530** bad-four repairs. Hence the numerical contradiction is

\[
2448<2475<2530.
\]

The dependency that remains visible is the classification bridge connecting the forced internal DRT(23) `S_3` core to this complete external catalogue replay.

## Authority boundary

This note records a successful finite catalogue replay with frozen hashes. It should be cited as a computational/classification receipt, not as an independent kernel proof of the external completeness theorem underlying the catalogue itself.
