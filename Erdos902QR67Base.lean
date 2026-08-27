import Erdos902ClosedForm
import Mathlib.Algebra.Field.ZMod

abbrev F67 := ZMod 67

/-- Nonzero quadratic residues modulo 67, represented as a constant-time Boolean table. -/
def isQR67 : F67 → Bool := fun d =>
  match d.val with
  | 1 | 4 | 6 | 9 | 10 | 14 | 15 | 16 | 17 | 19 | 21 | 22 | 23 | 24 | 25 | 26 | 29
  | 33 | 35 | 36 | 37 | 39 | 40 | 47 | 49 | 54 | 55 | 56 | 59 | 60 | 62 | 64 | 65 => true
  | _ => false

/-- The quadratic-residue tournament on the field with 67 elements. -/
def qr67Z : F67 → F67 → Prop := fun a b => isQR67 (b - a) = true

instance : DecidableRel qr67Z := fun a b =>
  inferInstanceAs (Decidable (isQR67 (b - a) = true))

theorem qr67Z_irrefl (a : F67) : ¬ qr67Z a a := by
  simp [qr67Z, isQR67]

theorem qr67Z_add_right (a x y : F67) : qr67Z (x + a) (y + a) ↔ qr67Z x y := by
  simp only [qr67Z, add_sub_add_right_eq_sub]

theorem isQR67_ne_zero : ∀ s : F67, isQR67 s = true → s ≠ 0 := by
  decide

set_option maxRecDepth 1000000 in
theorem isQR67_mul_iff : ∀ s d : F67, isQR67 s = true →
    (isQR67 (s * d) = true ↔ isQR67 d = true) := by
  decide

theorem qr67Z_mul_left (s x y : F67) (hs : isQR67 s = true) :
    qr67Z (s * x) (s * y) ↔ qr67Z x y := by
  rw [qr67Z, qr67Z, ← mul_sub]
  exact isQR67_mul_iff s (y - x) hs

/- A square multiplier sends any field element to 0, 1, or the fixed nonsquare 2. -/
set_option maxRecDepth 1000000 in
theorem qr67_canonical_scale : ∀ b : F67, ∃ s : F67,
    isQR67 s = true ∧ (s * b = 0 ∨ s * b = 1 ∨ s * b = 2) := by
  decide
