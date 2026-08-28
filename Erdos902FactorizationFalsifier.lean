import Erdos902Mass

/-!
The private-witness Boolean-factorization relaxation is far too weak.

For every `k >= 1`, the standard cyclic tournament on `2k+1` vertices admits witnesses
of size `k` satisfying the exact anti-identity factorization: the witness at `a` is simply
the whole out-neighbourhood of `a`.  Thus the relaxation has examples with `n = 2k+1`,
so it cannot imply any exponential lower bound.
-/

open Finset

namespace Erdos902FactorizationFalsifier

abbrev cyclicOrder (k : ℕ) : ℕ := 2 * k + 1
abbrev CyclicVertex (k : ℕ) := ZMod (cyclicOrder k)

instance (k : ℕ) : NeZero (cyclicOrder k) := ⟨by simp [cyclicOrder]⟩

/-- `a` beats the next `k` residues cyclically. -/
def cyclicArc (k : ℕ) (a b : CyclicVertex k) : Prop :=
  1 ≤ (b - a).val ∧ (b - a).val ≤ k

instance (k : ℕ) : DecidableRel (cyclicArc k) := fun a b =>
  inferInstanceAs (Decidable (1 ≤ (b - a).val ∧ (b - a).val ≤ k))

/-- The `k` consecutive successors of `a`. -/
def cyclicWitness (k : ℕ) (a : CyclicVertex k) : Finset (CyclicVertex k) :=
  (univ : Finset (Fin k)).image fun r => a + (r.val + 1 : ℕ)

theorem mem_cyclicWitness_iff (k : ℕ) (a b : CyclicVertex k) :
    b ∈ cyclicWitness k a ↔ 1 ≤ (b - a).val ∧ (b - a).val ≤ k := by
  constructor
  · intro hb
    obtain ⟨r, -, rfl⟩ := Finset.mem_image.mp hb
    have hrlt : r.val + 1 < cyclicOrder k := by
      have := r.isLt
      simp only [cyclicOrder]
      omega
    have hval : ((a + (r.val + 1 : ℕ) - a : CyclicVertex k)).val = r.val + 1 := by
      rw [show a + (r.val + 1 : ℕ) - a = (r.val + 1 : ℕ) by abel]
      exact ZMod.val_natCast_of_lt hrlt
    rw [hval]
    exact ⟨by omega, by omega⟩
  · rintro ⟨hpos, hle⟩
    let d := (b - a).val
    let r : Fin k := ⟨d - 1, by dsimp [d]; omega⟩
    refine Finset.mem_image.mpr ⟨r, Finset.mem_univ r, ?_⟩
    have hd : r.val + 1 = d := by dsimp [r]; omega
    rw [hd]
    have hcast : (d : CyclicVertex k) = b - a := ZMod.natCast_zmod_val (b - a)
    rw [hcast]
    abel

theorem cyclicWitness_card (k : ℕ) (a : CyclicVertex k) :
    (cyclicWitness k a).card = k := by
  rw [cyclicWitness, Finset.card_image_of_injective]
  · simp
  · intro r s hrs
    have hcast : ((r.val + 1 : ℕ) : CyclicVertex k) = (s.val + 1 : ℕ) :=
      add_left_cancel hrs
    have hrlt : r.val + 1 < cyclicOrder k := by
      have := r.isLt
      simp only [cyclicOrder]
      omega
    have hslt : s.val + 1 < cyclicOrder k := by
      have := s.isLt
      simp only [cyclicOrder]
      omega
    have hv := congrArg ZMod.val hcast
    rw [ZMod.val_natCast_of_lt hrlt, ZMod.val_natCast_of_lt hslt] at hv
    exact Fin.ext (by omega)

private theorem reverse_val {k : ℕ} {a b : CyclicVertex k} (hab : a ≠ b) :
    (a - b).val = cyclicOrder k - (b - a).val := by
  have hx : b - a ≠ 0 := sub_ne_zero.mpr hab.symm
  rw [show a - b = -(b - a) by abel, ZMod.neg_val, if_neg hx]

theorem cyclic_isTournament (k : ℕ) : IsTournament (cyclicArc k) where
  irrefl := by simp [cyclicArc]
  total := by
    intro a b hab
    have hx : b - a ≠ 0 := sub_ne_zero.mpr hab.symm
    have hpos : 1 ≤ (b - a).val := by
      have := (ZMod.val_eq_zero (b - a)).not.mpr hx
      omega
    by_cases hle : (b - a).val ≤ k
    · exact Or.inl ⟨hpos, hle⟩
    · right
      rw [cyclicArc, reverse_val hab]
      have hlt := ZMod.val_lt (b - a)
      simp only [cyclicOrder] at hlt ⊢
      omega
  asymm := by
    intro a b hab hba
    have hne : a ≠ b := by
      intro h
      subst b
      simpa [cyclicArc] using hab
    rw [cyclicArc] at hab
    rw [cyclicArc, reverse_val hne] at hba
    have hlt := ZMod.val_lt (b - a)
    simp only [cyclicOrder] at hba
    simp only [cyclicOrder] at hlt
    omega

/-- The witness row is exactly the out-neighbourhood row. -/
theorem cyclicWitness_eq_outN (k : ℕ) (a : CyclicVertex k) :
    cyclicWitness k a = Erdos902Mass.outN (cyclicArc k) a := by
  ext b
  simp only [mem_cyclicWitness_iff, Erdos902Mass.outN, Finset.mem_filter,
    Finset.mem_univ, true_and, cyclicArc]

/-- Every vertex is a king, with a relay in its cyclic witness. -/
theorem cyclic_factorization (k : ℕ) (hk : 1 ≤ k) (a b : CyclicVertex k) :
    (∃ p ∈ cyclicWitness k a, p = b ∨ cyclicArc k p b) ↔ a ≠ b := by
  constructor
  · rintro ⟨p, hp, rfl | hpb⟩
    · have hap : cyclicArc k a p := (mem_cyclicWitness_iff k a p).mp hp
      intro h
      subst p
      exact (cyclic_isTournament k).irrefl a hap
    · have hap : cyclicArc k a p := (mem_cyclicWitness_iff k a p).mp hp
      intro h
      subst b
      exact (cyclic_isTournament k).asymm a p hap hpb
  · intro hab
    rcases (cyclic_isTournament k).total a b hab with hab' | hba
    · exact ⟨b, (mem_cyclicWitness_iff k a b).mpr hab', Or.inl rfl⟩
    · let r := (a - b).val
      let q := k + 1 - r
      let p : CyclicVertex k := a + (q : ℕ)
      have hr : 1 ≤ r ∧ r ≤ k := hba
      have hq : 1 ≤ q ∧ q ≤ k := by dsimp [q]; omega
      have hqval : ((p - a : CyclicVertex k)).val = q := by
        rw [show p - a = (q : ℕ) by dsimp [p]; abel]
        apply ZMod.val_natCast_of_lt
        simp only [cyclicOrder]
        omega
      have hpW : p ∈ cyclicWitness k a := by
        apply (mem_cyclicWitness_iff k a p).mpr
        rw [hqval]
        exact hq
      have hrCast : (r : CyclicVertex k) = a - b := ZMod.natCast_zmod_val (a - b)
      have hneg : -((k + 1 : ℕ) : CyclicVertex k) = (k : ℕ) := by
        rw [eq_comm, eq_neg_iff_add_eq_zero, ← Nat.cast_add]
        rw [show k + (k + 1) = cyclicOrder k by simp [cyclicOrder]; omega,
          ZMod.natCast_self]
      have hdiff : b - p = (k : ℕ) := by
        calc
          b - p = -(a - b) - (q : ℕ) := by dsimp [p]; abel
          _ = -(r : CyclicVertex k) - (q : ℕ) := by rw [hrCast]
          _ = -((r + q : ℕ) : CyclicVertex k) := by push_cast; ring
          _ = -((k + 1 : ℕ) : CyclicVertex k) := by congr 2; dsimp [q]; omega
          _ = (k : ℕ) := hneg
      have hkb : cyclicArc k p b := by
        rw [cyclicArc, hdiff, ZMod.val_natCast_of_lt]
        · exact ⟨hk, le_rfl⟩
        · simp only [cyclicOrder]
          omega
      exact ⟨p, hpW, Or.inr hkb⟩

/-- The relaxation has a witness on exactly `2k+1` vertices, with row weight `k`. -/
theorem linear_size_falsifier (k : ℕ) (hk : 1 ≤ k) :
    Fintype.card (CyclicVertex k) = 2 * k + 1 ∧
    (∀ a, (cyclicWitness k a).card = k) ∧
    (∀ a b, (∃ p ∈ cyclicWitness k a, p = b ∨ cyclicArc k p b) ↔ a ≠ b) := by
  refine ⟨by simp [CyclicVertex, cyclicOrder], cyclicWitness_card k, ?_⟩
  exact cyclic_factorization k hk

/-- Complete packaged counterfamily: a tournament of order `2k+1`, row weight `k`,
and the exact anti-identity witness factorization. -/
theorem antisymmetric_factorization_has_linear_examples (k : ℕ) (hk : 1 ≤ k) :
    IsTournament (cyclicArc k) ∧
    Fintype.card (CyclicVertex k) = 2 * k + 1 ∧
    (∀ a, (cyclicWitness k a).card = k) ∧
    (∀ a, cyclicWitness k a = Erdos902Mass.outN (cyclicArc k) a) ∧
    (∀ a b, (∃ p ∈ cyclicWitness k a, p = b ∨ cyclicArc k p b) ↔ a ≠ b) := by
  refine ⟨cyclic_isTournament k, by simp [CyclicVertex, cyclicOrder],
    cyclicWitness_card k, cyclicWitness_eq_outN k, ?_⟩
  exact cyclic_factorization k hk

end Erdos902FactorizationFalsifier

#print axioms Erdos902FactorizationFalsifier.cyclic_isTournament
#print axioms Erdos902FactorizationFalsifier.cyclicWitness_card
#print axioms Erdos902FactorizationFalsifier.cyclic_factorization
#print axioms Erdos902FactorizationFalsifier.linear_size_falsifier
#print axioms Erdos902FactorizationFalsifier.antisymmetric_factorization_has_linear_examples
