import Erdos902QR67Case0
import Erdos902QR67Case1
import Erdos902QR67Case2

/-- Kernel-checked certificate after translating the first vertex to zero. -/
theorem qr67_normalized_certificate :
    ∀ b c d : F67, ∃ v : F67, qr67Z v 0 ∧ qr67Z v b ∧ qr67Z v c ∧ qr67Z v d := by
  letI : Fact (Nat.Prime 67) := ⟨by decide⟩
  intro b c d
  obtain ⟨s, hs, hsb⟩ := qr67_canonical_scale b
  have hs0 : s ≠ 0 := isQR67_ne_zero s hs
  have pull : ∀ x v : F67, qr67Z v (s * x) → qr67Z (s⁻¹ * v) x := by
    intro x v hv
    apply (qr67Z_mul_left s (s⁻¹ * v) x hs).mp
    rw [← mul_assoc, mul_inv_cancel₀ hs0, one_mul]
    exact hv
  rcases hsb with hsb | hsb | hsb
  · obtain ⟨v, hv0, hvb, hvc, hvd⟩ := qr67_cert_0 (s * c) (s * d)
    exact ⟨s⁻¹ * v, pull 0 v (by simpa using hv0), pull b v (by simpa [hsb] using hvb),
      pull c v hvc, pull d v hvd⟩
  · obtain ⟨v, hv0, hvb, hvc, hvd⟩ := qr67_cert_1 (s * c) (s * d)
    exact ⟨s⁻¹ * v, pull 0 v (by simpa using hv0), pull b v (by simpa [hsb] using hvb),
      pull c v hvc, pull d v hvd⟩
  · obtain ⟨v, hv0, hvb, hvc, hvd⟩ := qr67_cert_2 (s * c) (s * d)
    exact ⟨s⁻¹ * v, pull 0 v (by simpa using hv0), pull b v (by simpa [hsb] using hvb),
      pull c v hvc, pull d v hvd⟩

/-- Every ordered four-tuple, repetitions allowed, has a common dominator in QR₆₇. -/
theorem qr67Z_four_tuple (a b c d : F67) :
    ∃ v : F67, qr67Z v a ∧ qr67Z v b ∧ qr67Z v c ∧ qr67Z v d := by
  obtain ⟨w, hwa, hwb, hwc, hwd⟩ := qr67_normalized_certificate (b - a) (c - a) (d - a)
  refine ⟨w + a, ?_, ?_, ?_, ?_⟩
  · simpa using (qr67Z_add_right a w 0).mpr hwa
  · simpa using (qr67Z_add_right a w (b - a)).mpr hwb
  · simpa using (qr67Z_add_right a w (c - a)).mpr hwc
  · simpa using (qr67Z_add_right a w (d - a)).mpr hwd

/-- The QR₆₇ relation transported to the vertex type required by `SchutteAt`. -/
def qr67 : Fin 67 → Fin 67 → Prop := fun a b =>
  qr67Z (ZMod.finEquiv 67 a) (ZMod.finEquiv 67 b)

instance : DecidableRel qr67 := fun a b =>
  inferInstanceAs (Decidable (qr67Z (ZMod.finEquiv 67 a) (ZMod.finEquiv 67 b)))

theorem qr67_irrefl (a : Fin 67) : ¬ qr67 a a := qr67Z_irrefl _

theorem qr67_four_tuple (a b c d : Fin 67) :
    ∃ v : Fin 67, qr67 v a ∧ qr67 v b ∧ qr67 v c ∧ qr67 v d := by
  obtain ⟨w, hwa, hwb, hwc, hwd⟩ := qr67Z_four_tuple
    (ZMod.finEquiv 67 a) (ZMod.finEquiv 67 b) (ZMod.finEquiv 67 c) (ZMod.finEquiv 67 d)
  refine ⟨(ZMod.finEquiv 67).symm w, ?_, ?_, ?_, ?_⟩
  · simpa [qr67] using hwa
  · simpa [qr67] using hwb
  · simpa [qr67] using hwc
  · simpa [qr67] using hwd

theorem qr67_isTournament : IsTournament qr67 where
  irrefl := qr67_irrefl
  total := by decide
  asymm := by decide

/-- QR₆₇ has Schütte's property S₄. -/
theorem qr67_hasS4 : HasS qr67 4 := by
  intro S hlen _
  obtain ⟨a, b, c, d, rfl⟩ := List.length_eq_four.mp hlen
  obtain ⟨v, hva, hvb, hvc, hvd⟩ := qr67_four_tuple a b c d
  refine ⟨v, ?_, ?_⟩
  · simp only [List.mem_cons, List.not_mem_nil, or_false, not_or]
    exact ⟨fun h => qr67_irrefl a (h ▸ hva),
      fun h => qr67_irrefl b (h ▸ hvb),
      fun h => qr67_irrefl c (h ▸ hvc),
      fun h => qr67_irrefl d (h ▸ hvd)⟩
  · intro s hs
    simp only [List.mem_cons, List.not_mem_nil, or_false] at hs
    rcases hs with rfl | rfl | rfl | rfl
    · exact hva
    · exact hvb
    · exact hvc
    · exact hvd

theorem qr67_hasSle4 : HasSle qr67 4 :=
  hasSle_of_hasS qr67 4 (by decide) qr67_hasS4

theorem schutteAt_four_67 : SchutteAt 4 67 :=
  ⟨qr67, inferInstance, qr67_isTournament, qr67_hasSle4⟩

/-- The classical finite upper bound f(4) ≤ 67, witnessed by QR₆₇. -/
theorem f_four_le_67 : f 4 ≤ 67 :=
  Nat.sInf_le schutteAt_four_67

#print axioms qr67_normalized_certificate
#print axioms qr67Z_four_tuple
#print axioms qr67_four_tuple
#print axioms qr67_isTournament
#print axioms qr67_hasS4
#print axioms f_four_le_67
