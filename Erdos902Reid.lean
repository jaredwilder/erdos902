/-
The published finite lower bound f(4) >= 48.

Reid--McRae--Hedetniemi--Hedetniemi (2004), Proposition 14 and Corollary 7,
first force the equality-case parameters 5, 11, 23 on a hypothetical 47-vertex
tournament of domination number at least five.  Here the final obstruction is
made self-contained with the first two codegree moments already proved in this
repository.  No classification theorem or finite search is imported.
-/
import Erdos902Codeg
import Erdos902Double
import Erdos902Overlap
import Erdos902QR67
import Erdos902Szekeres

open Finset

namespace Erdos902Reid

universe u

variable {V : Type u} [Fintype V] [DecidableEq V]
  (T : V → V → Prop) [DecidableRel T]

abbrev inN (v : V) : Finset V := Erdos902Cover.inN T v
abbrev outN (v : V) : Finset V := Erdos902Mass.outN T v

/-- Two nested multiplicity-preserving descents give the published lower bound 11
for every pairwise common in-neighbourhood. -/
theorem pair_common_in_ge_eleven (hT : IsTournament T)
    (H3 : Erdos902Szekeres.HasSleM T 3 5) (x y : V) (hxy : x ≠ y) :
    11 ≤ ((inN T x) ∩ (inN T y)).card := by
  rcases hT.total x y hxy with hxy' | hyx'
  · let y' : {z // T z y} := ⟨x, hxy'⟩
    have H2 := Erdos902Szekeres.hasSleM_induced T hT 2 5 H3 y
    have H1 := Erdos902Szekeres.hasSleM_induced (induced T y)
      (induced_isTournament T hT y) 1 5 H2 y'
    have hcard := Erdos902Szekeres.card_ge_of_hasSleM 1 5 (by norm_num)
      (induced (induced T y) y') (induced_isTournament (induced T y)
        (induced_isTournament T hT y) y') H1
    norm_num at hcard
    let e : {z : {z // T z y} // induced T y z y'} ≃
        {z : V // z ∈ (inN T x) ∩ (inN T y)} :=
      { toFun := fun z => ⟨z.1.1, Finset.mem_inter.mpr
          ⟨(Erdos902Rigid.mem_inN T).mpr z.2, (Erdos902Rigid.mem_inN T).mpr z.1.2⟩⟩
        invFun := fun z =>
          ⟨⟨z.1, (Erdos902Rigid.mem_inN T).mp (Finset.mem_inter.mp z.2).2⟩,
            (Erdos902Rigid.mem_inN T).mp (Finset.mem_inter.mp z.2).1⟩
        left_inv := fun _ => rfl
        right_inv := fun _ => rfl }
    have heq : Fintype.card {z : {z // T z y} // induced T y z y'}
        = ((inN T x) ∩ (inN T y)).card := by
      calc
        _ = Fintype.card {z : V // z ∈ (inN T x) ∩ (inN T y)} := Fintype.card_congr e
        _ = _ := Fintype.card_coe _
    simpa [card_inNbhd, heq] using hcard
  · let y' : {z // T z x} := ⟨y, hyx'⟩
    have H2 := Erdos902Szekeres.hasSleM_induced T hT 2 5 H3 x
    have H1 := Erdos902Szekeres.hasSleM_induced (induced T x)
      (induced_isTournament T hT x) 1 5 H2 y'
    have hcard := Erdos902Szekeres.card_ge_of_hasSleM 1 5 (by norm_num)
      (induced (induced T x) y') (induced_isTournament (induced T x)
        (induced_isTournament T hT x) y') H1
    norm_num at hcard
    let e : {z : {z // T z x} // induced T x z y'} ≃
        {z : V // z ∈ (inN T x) ∩ (inN T y)} :=
      { toFun := fun z => ⟨z.1.1, Finset.mem_inter.mpr
          ⟨(Erdos902Rigid.mem_inN T).mpr z.1.2, (Erdos902Rigid.mem_inN T).mpr z.2⟩⟩
        invFun := fun z =>
          ⟨⟨z.1, (Erdos902Rigid.mem_inN T).mp (Finset.mem_inter.mp z.2).1⟩,
            (Erdos902Rigid.mem_inN T).mp (Finset.mem_inter.mp z.2).2⟩
        left_inv := fun _ => rfl
        right_inv := fun _ => rfl }
    have heq : Fintype.card {z : {z // T z x} // induced T x z y'}
        = ((inN T x) ∩ (inN T y)).card := by
      calc
        _ = Fintype.card {z : V // z ∈ (inN T x) ∩ (inN T y)} := Fintype.card_congr e
        _ = _ := Fintype.card_coe _
    simpa [card_inNbhd, heq] using hcard

/-- There is no 47-vertex tournament with `S₄`.  The final contradiction uses the first
two moments of the common-dominator count on triples. -/
theorem no_order_47 (hT : IsTournament T) (hN : Fintype.card V = 47)
    (H : HasSle T 4) : False := by
  classical
  have H4 : Erdos902Szekeres.HasSleM T 4 1 :=
    Erdos902Szekeres.hasSleM_one_of_hasSle T H
  have H3 : Erdos902Szekeres.HasSleM T 3 5 := by
    simpa using Erdos902Szekeres.amplification T hT 3 1 (by norm_num) H4
  have hmin : ∀ v : V, 23 ≤ (inN T v).card := by
    intro v
    have H2 := Erdos902Szekeres.hasSleM_induced T hT 2 5 H3 v
    have hc := Erdos902Szekeres.card_ge_of_hasSleM 2 5 (by norm_num)
      (induced T v) (induced_isTournament T hT v) H2
    norm_num at hc
    change 23 ≤ indeg T v
    rw [← card_inNbhd T v]
    exact hc
  have hN' : Fintype.card V = 2 * 23 + 1 := by omega
  have hin : ∀ v : V, (inN T v).card = 23 := by
    intro v
    exact Erdos902Rigid.regular_at_bound T hT 23 hmin hN' v
  have hout : ∀ v : V, (outN T v).card = 23 := by
    intro v
    have hs := indeg_add_outdeg_succ T hT v
    have hi := hin v
    change (inN T v).card + (outN T v).card + 1 = Fintype.card V at hs
    omega
  have hcodGe : ∀ x : V, ∀ y ∈ (univ : Finset V).erase x,
      11 ≤ ((inN T x) ∩ (inN T y)).card := by
    intro x y hy
    have hyx : y ≠ x := by simpa using hy
    exact pair_common_in_ge_eleven T hT H3 x y hyx.symm
  have hcod : ∀ x : V, ∀ y ∈ (univ : Finset V).erase x,
      ((inN T x) ∩ (inN T y)).card = 11 :=
    Erdos902Double.double_rigidity T 23 11 hN' hout hin hcodGe (by norm_num)
  have houtcod : ∀ x : V, ∀ y ∈ (univ : Finset V).erase x,
      ((outN T x) ∩ (outN T y)).card = 11 := by
    intro x y hy
    have hyx : y ≠ x := by simpa using hy
    have hxy : x ≠ y := hyx.symm
    rcases hT.total x y hxy with hxy' | hyx'
    · have hxmem : x ∈ inN T y := (Erdos902Rigid.mem_inN T).mpr hxy'
      rw [Erdos902Rigid.reach_eq_internal_indeg T hT 23 hmin hN' y x hxmem]
      exact hcod x y hy
    · have hymem : y ∈ inN T x := (Erdos902Rigid.mem_inN T).mpr hyx'
      rw [Finset.inter_comm (outN T x)]
      rw [Erdos902Rigid.reach_eq_internal_indeg T hT 23 hmin hN' x y hymem]
      rw [Finset.inter_comm (inN T y)]
      exact hcod x y hy

  let triples := (univ : Finset V).powersetCard 3
  let c : Finset V → ℕ := fun A => (Erdos902Mass.domSet T A).card
  have hfirst : ∑ A ∈ triples, c A = 83237 := by
    calc
      _ = ∑ x : V, ((outN T x).card).choose 3 := by
        simpa [triples, c] using Erdos902Mass.total_domination_general T 3
      _ = Fintype.card V * (Nat.choose 23 3) := by
        rw [Finset.sum_congr rfl (fun x _ => by rw [hout x]), Finset.sum_const,
          Finset.card_univ, smul_eq_mul]
      _ = 83237 := by rw [hN]; norm_num [Nat.choose]
  have hsecond : ∑ A ∈ triples, (c A) ^ 2 = 439967 := by
    have hrow : ∀ x : V, ∑ y : V,
        (((outN T x) ∩ (outN T y)).card).choose 3 =
          Nat.choose 23 3 + 46 * Nat.choose 11 3 := by
      intro x
      rw [← Finset.add_sum_erase _ _ (Finset.mem_univ x)]
      rw [Finset.inter_self, hout x]
      rw [Finset.sum_congr rfl (fun y hy => by rw [houtcod x y hy]),
        Finset.sum_const, Finset.card_erase_of_mem (Finset.mem_univ x),
        Finset.card_univ, hN, smul_eq_mul]
    calc
      _ = ∑ x : V, ∑ y : V,
          (((outN T x) ∩ (outN T y)).card).choose 3 := by
        simpa [triples, c] using Erdos902Overlap.second_moment T 3
      _ = Fintype.card V * (Nat.choose 23 3 + 46 * Nat.choose 11 3) := by
        rw [Finset.sum_congr rfl (fun x _ => hrow x), Finset.sum_const,
          Finset.card_univ, smul_eq_mul]
      _ = 439967 := by rw [hN]; norm_num [Nat.choose]

  have hlo : ∀ A ∈ triples, 5 ≤ c A := by
    intro A hA
    have hA' : A ∈ (univ : Finset V).powersetCard 3 := by simpa [triples] using hA
    exact H3 A (Finset.mem_powersetCard.mp hA').2.le
  have hup : ∀ A ∈ triples, c A ≤ 11 := by
    intro A hA
    have hA' : A ∈ (univ : Finset V).powersetCard 3 := by simpa [triples] using hA
    have hcardA : A.card = 3 := (Finset.mem_powersetCard.mp hA').2
    obtain ⟨x, y, z, hxy, -, -, rfl⟩ := Finset.card_eq_three.mp hcardA
    have hsub : Erdos902Mass.domSet T {x, y, z} ⊆ Erdos902Mass.domSet T {x, y} := by
      intro d hd
      simp only [Erdos902Mass.domSet, Finset.mem_filter, Finset.mem_univ, true_and,
        Erdos902Mass.DominatesAll] at hd ⊢
      intro s hs
      exact hd s (by
        simp only [Finset.mem_insert, Finset.mem_singleton] at hs ⊢
        tauto)
    have hset : Erdos902Mass.domSet T {x, y} = (inN T x) ∩ (inN T y) := by
      ext d
      simp [Erdos902Mass.domSet, Erdos902Mass.DominatesAll, inN,
        Erdos902Cover.inN]
    calc
      c {x, y, z} ≤ (Erdos902Mass.domSet T {x, y}).card := Finset.card_le_card hsub
      _ = ((inN T x) ∩ (inN T y)).card := by rw [hset]
      _ = 11 := hcod x y (Finset.mem_erase.mpr ⟨hxy.symm, Finset.mem_univ y⟩)

  have hcount : triples.card = 16215 := by
    simp [triples, Finset.card_powersetCard, hN, Nat.choose]
  have hfirstZ : ∑ A ∈ triples, (c A : ℤ) = 83237 := by exact_mod_cast hfirst
  have hsecondZ : ∑ A ∈ triples, ((c A : ℤ) ^ 2) = 439967 := by
    exact_mod_cast hsecond
  have hzero : ∑ A ∈ triples, ((c A : ℤ) - 5) * (11 - (c A : ℤ)) = 0 := by
    calc
      _ = ∑ A ∈ triples, (16 * (c A : ℤ) - (c A : ℤ) ^ 2 - 55) := by
        apply Finset.sum_congr rfl
        intro A _
        ring
      _ = 16 * 83237 - 439967 - 55 * 16215 := by
        rw [Finset.sum_sub_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum,
          hfirstZ, hsecondZ, Finset.sum_const, hcount, nsmul_eq_mul]
        ring
      _ = 0 := by norm_num
  have hends : ∀ A ∈ triples, c A = 5 ∨ c A = 11 := by
    intro A hA
    have h5z : (5 : ℤ) ≤ (c A : ℤ) := by exact_mod_cast hlo A hA
    have h11z : (c A : ℤ) ≤ 11 := by exact_mod_cast hup A hA
    have hn : 0 ≤ ((c A : ℤ) - 5) * (11 - (c A : ℤ)) :=
      mul_nonneg (sub_nonneg.mpr h5z) (sub_nonneg.mpr h11z)
    have hz := (Finset.sum_eq_zero_iff_of_nonneg (fun B hB => by
      have h5z' : (5 : ℤ) ≤ (c B : ℤ) := by exact_mod_cast hlo B hB
      have h11z' : (c B : ℤ) ≤ 11 := by exact_mod_cast hup B hB
      exact mul_nonneg (sub_nonneg.mpr h5z') (sub_nonneg.mpr h11z'))).mp hzero
    have hzA := hz A hA
    rcases mul_eq_zero.mp hzA with h5 | h11
    · left; omega
    · right; omega
  have hdiv : (6 : ℤ) ∣ ∑ A ∈ triples, ((c A : ℤ) - 5) := by
    apply Finset.dvd_sum
    intro A hA
    rcases hends A hA with h5 | h11
    · simp [h5]
    · simp [h11]
  have hexcess : ∑ A ∈ triples, ((c A : ℤ) - 5) = 2162 := by
    rw [Finset.sum_sub_distrib, hfirstZ, Finset.sum_const, hcount, nsmul_eq_mul]
    norm_num
  rw [hexcess] at hdiv
  norm_num at hdiv

/-- Every admissible order for `S₄` is at least 48. -/
theorem schutte_card_bound_four_48 (m : ℕ) (h : SchutteAt 4 m) : 48 ≤ m := by
  have h47 := Erdos902Szekeres.szekeres_card_bound 4 m (by norm_num) h
  norm_num at h47
  by_contra hm
  have hm47 : m = 47 := by omega
  subst m
  obtain ⟨T, inst, hT, hS⟩ := h
  letI := inst
  exact no_order_47 T hT rfl hS

/-- The published finite lower bound `f(4) ≥ 48`. -/
theorem f_four_ge_48 : 48 ≤ f 4 := by
  obtain ⟨M, hM⟩ := Erdos902Existence.erdos_existence 4 (by norm_num)
  have hmem : f 4 ∈ {m | SchutteAt 4 m} := Nat.sInf_mem ⟨M, hM⟩
  exact schutte_card_bound_four_48 (f 4) hmem

/-- The complete currently published finite window, now kernel-checked in this repository. -/
theorem f_four_known_window : 48 ≤ f 4 ∧ f 4 ≤ 67 :=
  ⟨f_four_ge_48, f_four_le_67⟩

#print axioms no_order_47
#print axioms schutte_card_bound_four_48
#print axioms f_four_ge_48
#print axioms f_four_known_window

end Erdos902Reid
