# QR₆₇ certificate receipt

This note is the review map for the kernel-checked proof that the quadratic-residue tournament
on 67 vertices has Schütte's property `S₄`, and hence that `f(4) ≤ 67`.

## Receipt

- Public commit: [`fcefa2235dff3dc0babb27eb6f62ad073c70d808`](https://github.com/jaredwilder/erdos902/commit/fcefa2235dff3dc0babb27eb6f62ad073c70d808)
- Replay command: `lake env lean Erdos902QR67.lean`
- Certificate style: explicit witness arrays checked by Lean's kernel with `decide`; no `sorry` and no `native_decide`

## Symmetry reduction

[`Erdos902QR67Base.lean`](Erdos902QR67Base.lean) defines `qr67Z` on `ZMod 67` and proves its
translation and square-scaling symmetries. `qr67_canonical_scale` sends the second normalized
coordinate to `0`, `1`, or the fixed nonsquare `2`. In [`Erdos902QR67.lean`](Erdos902QR67.lean),
`qr67_normalized_certificate` applies exactly those three cases, then
`qr67Z_four_tuple` undoes the initial translation.

## Three witness tables

The explicit tables are split only to keep elaboration manageable:

- [`Erdos902QR67Case0.lean`](Erdos902QR67Case0.lean): normalized second coordinate `0`; exports `qr67_cert_0`.
- [`Erdos902QR67Case1.lean`](Erdos902QR67Case1.lean): normalized second coordinate `1`; exports `qr67_cert_1`.
- [`Erdos902QR67Case2.lean`](Erdos902QR67Case2.lean): normalized second coordinate `2`; exports `qr67_cert_2`.

Each private array entry is a concrete common dominator, and each table row is discharged by
`decide`. The public case theorem packages the 67 rows for its remaining coordinate.

## Theorem chain

```text
qr67_cert_0 / qr67_cert_1 / qr67_cert_2
  → qr67_normalized_certificate
  → qr67Z_four_tuple
  → qr67_four_tuple
  → qr67_hasS4
  → qr67_hasSle4
  → schutteAt_four_67
  → f_four_le_67
```

`qr67_isTournament` independently verifies that the transported relation on `Fin 67` is a
tournament.

## Axiom replay

Fresh output from `lake env lean Erdos902QR67.lean`:

```text
'qr67_normalized_certificate' depends on axioms: [propext, Classical.choice, Quot.sound]
'qr67Z_four_tuple' depends on axioms: [propext, Classical.choice, Quot.sound]
'qr67_four_tuple' depends on axioms: [propext, Classical.choice, Quot.sound]
'qr67_isTournament' depends on axioms: [propext, Quot.sound]
'qr67_hasS4' depends on axioms: [propext, Classical.choice, Quot.sound]
'f_four_le_67' depends on axioms: [propext, Classical.choice, Quot.sound]
```

These are Lean/Mathlib's standard logical axioms; the certificate introduces no project axiom.
