import Erdos902Double

open Finset

namespace Erdos902DRT23Rigidity

universe u

variable {V : Type u} [Fintype V] [DecidableEq V]
  (T : V → V → Prop) [DecidableRel T]

abbrev inN (v : V) : Finset V := Erdos902Cover.inN T v
abbrev outN (v : V) : Finset V := Erdos902Mass.outN T v

private theorem internal_split (hT : IsTournament T) (W : Finset V) {h : V} (hh : h ∈ W) :
    (W ∩ inN T h).card + (W ∩ outN T h).card = W.card - 1 := by
  have hdisj : Disjoint (W ∩ inN T h) (W ∩ outN T h) := by
    rw [Finset.disjoint_left]
    intro z hz1 hz2
    exact hT.asymm z h ((Erdos902Rigid.mem_inN T).mp (Finset.mem_inter.mp hz1).2)
      ((Erdos902Rigid.mem_outN T).mp (Finset.mem_inter.mp hz2).2)
  have hunion : (W ∩ inN T h) ∪ (W ∩ outN T h) = W.erase h := by
    ext z
    simp only [Finset.mem_union, Finset.mem_inter, Finset.mem_erase]
    constructor
    · rintro (⟨hzW, hz⟩ | ⟨hzW, hz⟩)
      · refine ⟨?_, hzW⟩
        intro hc; subst z
        exact hT.irrefl h ((Erdos902Rigid.mem_inN T).mp hz)
      · refine ⟨?_, hzW⟩
        intro hc; subst z
        exact hT.irrefl h ((Erdos902Rigid.mem_outN T).mp hz)
    · rintro ⟨hzh, hzW⟩
      rcases hT.total z h hzh with h1 | h1
      · exact Or.inl ⟨hzW, (Erdos902Rigid.mem_inN T).mpr h1⟩
      · exact Or.inr ⟨hzW, (Erdos902Rigid.mem_outN T).mpr h1⟩
  rw [← Finset.card_union_of_disjoint hdisj, hunion, Finset.card_erase_of_mem hh]

private theorem two_mul_sum_internal_indeg (hT : IsTournament T) (W : Finset V) :
    2 * ∑ h ∈ W, (W ∩ inN T h).card = W.card * (W.card - 1) := by
  have hin : ∑ h ∈ W, (W ∩ inN T h).card
      = ∑ h ∈ W, ∑ z ∈ W, (if T z h then 1 else 0) := by
    refine Finset.sum_congr rfl (fun h _ => ?_)
    rw [show W ∩ inN T h = W.filter (fun z => T z h) by
      ext z; simp [inN, Erdos902Cover.inN, and_comm], Finset.card_filter]
  have hout : ∑ h ∈ W, (W ∩ outN T h).card
      = ∑ h ∈ W, ∑ z ∈ W, (if T h z then 1 else 0) := by
    refine Finset.sum_congr rfl (fun h _ => ?_)
    rw [show W ∩ outN T h = W.filter (fun z => T h z) by
      ext z; simp [outN, Erdos902Mass.outN, and_comm], Finset.card_filter]
  have hEq : ∑ h ∈ W, (W ∩ outN T h).card = ∑ h ∈ W, (W ∩ inN T h).card := by
    rw [hin, hout]
    exact Finset.sum_comm
  have hsum : ∑ h ∈ W, ((W ∩ inN T h).card + (W ∩ outN T h).card)
      = W.card * (W.card - 1) := by
    rw [Finset.sum_congr rfl (fun h hh => internal_split T hT W hh),
      Finset.sum_const, smul_eq_mul]
  rw [Finset.sum_add_distrib, hEq] at hsum
  omega

private theorem hit_count (W : Finset V) (h : V) :
    (W ∩ inN T h).card = ∑ w ∈ W, if T w h then 1 else 0 := by
  rw [show W ∩ inN T h = W.filter (fun w => T w h) by
    ext w; simp [inN, Erdos902Cover.inN]]
  exact Finset.card_filter _ _

private theorem sum_hits (W : Finset V) (hreg : ∀ w : V, (outN T w).card = 11) :
    ∑ h : V, (W ∩ inN T h).card = W.card * 11 := by
  simp_rw [hit_count T W]
  rw [Finset.sum_comm]
  have hout : ∀ w : V, ∑ h : V, (if T w h then 1 else 0) = 11 := by
    intro w
    rw [← Erdos902Double.card_outN T w, hreg w]
  rw [Finset.sum_congr rfl (fun w hw => hout w), Finset.sum_const, smul_eq_mul]

private theorem common_out_sum (x y : V) :
    ∑ h : V, (if T x h ∧ T y h then 1 else 0) = ((outN T x) ∩ (outN T y)).card := by
  rw [show (outN T x) ∩ (outN T y) = univ.filter (fun h => T x h ∧ T y h) by
    ext h; simp [outN, Erdos902Mass.outN]]
  rw [Finset.card_filter]

private theorem sum_sq_hits (W : Finset V)
    (hreg : ∀ w : V, (outN T w).card = 11)
    (hcod : ∀ x y : V, x ≠ y → ((outN T x) ∩ (outN T y)).card = 5) :
    ∑ h : V, ((W ∩ inN T h).card) ^ 2 = W.card * 11 + W.card * (W.card - 1) * 5 := by
  simp_rw [hit_count T W]
  have hexpand : ∀ h : V,
      (∑ w ∈ W, if T w h then 1 else 0) ^ 2 =
        ∑ x ∈ W, ∑ y ∈ W, (if T x h ∧ T y h then 1 else 0) := by
    intro h
    rw [sq, Finset.sum_mul_sum]
    refine Finset.sum_congr rfl (fun x hx => Finset.sum_congr rfl (fun y hy => ?_))
    by_cases hxh : T x h <;> by_cases hyh : T y h <;> simp [hxh, hyh]
  simp_rw [hexpand]
  rw [show (∑ h : V, ∑ x ∈ W, ∑ y ∈ W, (if T x h ∧ T y h then 1 else 0)) =
      ∑ x ∈ W, ∑ y ∈ W, ∑ h : V, (if T x h ∧ T y h then 1 else 0) by
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl (fun x hx => ?_)
    rw [Finset.sum_comm]]
  simp_rw [common_out_sum T]
  have hdiag : ∀ x : V, ((outN T x) ∩ (outN T x)).card = 11 := by
    intro x; rw [Finset.inter_self, hreg x]
  have hrow : ∀ x ∈ W,
      ∑ y ∈ W, ((outN T x) ∩ (outN T y)).card = 11 + (W.card - 1) * 5 := by
    intro x hx
    rw [← Finset.add_sum_erase _ _ hx, hdiag x]
    have hoff : ∑ y ∈ W.erase x, ((outN T x) ∩ (outN T y)).card = (W.card - 1) * 5 := by
      rw [Finset.sum_congr rfl (fun y hy => hcod x y (Finset.ne_of_mem_erase hy).symm),
        Finset.sum_const, Finset.card_erase_of_mem hx, smul_eq_mul]
    rw [hoff]
  rw [Finset.sum_congr rfl hrow, Finset.sum_const, smul_eq_mul]
  ring

private theorem deficit_rigidity {t : V → ℕ}
    (hcard : Fintype.card V = 23) (hle : ∀ h, t h ≤ 6)
    (hsum : ∑ h : V, t h = 132) (hsq : ∑ h : V, (t h) ^ 2 = 792) :
    ∃! s : V, t s = 0 := by
  let d : V → ℕ := fun h => 6 - t h
  have hdle : ∀ h, d h ≤ 6 := fun h => Nat.sub_le _ _
  have htplus : ∀ h, t h + d h = 6 := by
    intro h; dsimp [d]; have := hle h; omega
  have hdsum : ∑ h : V, d h = 6 := by
    have htotal : ∑ h : V, (t h + d h) = 23 * 6 := by
      rw [Finset.sum_congr rfl (fun h _ => htplus h), Finset.sum_const,
        Finset.card_univ, hcard, smul_eq_mul]
    rw [Finset.sum_add_distrib, hsum] at htotal
    omega
  have hdsq : ∑ h : V, (d h) ^ 2 = 36 := by
    have hpoint : ∀ h, (t h) ^ 2 + 12 * d h = 36 + (d h) ^ 2 := by
      intro h
      have := htplus h
      nlinarith
    have hall : ∑ h : V, ((t h) ^ 2 + 12 * d h) = ∑ h : V, (36 + (d h) ^ 2) :=
      Finset.sum_congr rfl (fun h _ => hpoint h)
    rw [Finset.sum_add_distrib, Finset.sum_add_distrib, hsq, ← Finset.mul_sum,
      hdsum, Finset.sum_const, Finset.card_univ, hcard, smul_eq_mul] at hall
    omega
  have heach : ∀ h, (d h) ^ 2 = 6 * d h := by
    have hlepoint : ∀ h, (d h) ^ 2 ≤ 6 * d h := by
      intro h
      simpa [pow_two, Nat.mul_comm] using Nat.mul_le_mul_left (d h) (hdle h)
    have htot : ∑ h : V, (d h) ^ 2 = ∑ h : V, 6 * d h := by
      rw [hdsq]
      rw [← Finset.mul_sum, hdsum]
      norm_num
    exact fun h => (Finset.sum_eq_sum_iff_of_le
      (fun i (_ : i ∈ (univ : Finset V)) => hlepoint i)).mp htot h (Finset.mem_univ h)
  have hzero_or_six : ∀ h, d h = 0 ∨ d h = 6 := by
    intro h
    by_cases hz : d h = 0
    · exact Or.inl hz
    · right
      have hp : 0 < d h := Nat.pos_of_ne_zero hz
      nlinarith [heach h]
  have hex : ∃ s, d s = 6 := by
    by_contra hc
    push Not at hc
    have hz : ∀ h, d h = 0 := fun h => (hzero_or_six h).resolve_right (hc h)
    have : ∑ h : V, d h = 0 := by simp [hz]
    omega
  obtain ⟨s, hs⟩ := hex
  refine ⟨s, ?_, ?_⟩
  · have := htplus s; omega
  · intro z hz
    have hdz : d z = 6 := by have := htplus z; omega
    by_contra hzs
    have hlow : 12 ≤ ∑ h : V, d h := by
      calc 12 = d s + d z := by omega
        _ ≤ ∑ h ∈ ({s, z} : Finset V), d h := by
          simp [Ne.symm hzs]
        _ ≤ ∑ h : V, d h := Finset.sum_le_sum_of_subset (by simp)
    omega

/-- In any DRT(23,11,5), a 12-set meeting every in-neighbourhood in at most six
vertices is the closed out-neighbourhood of a unique vertex. -/
theorem feasible_card12_eq_closed_outN
    (hT : IsTournament T) (hN : Fintype.card V = 23)
    (hreg : ∀ x : V, (outN T x).card = 11)
    (hcod : ∀ x y : V, x ≠ y → ((outN T x) ∩ (outN T y)).card = 5)
    (W : Finset V) (hW : W.card = 12)
    (hcap : ∀ h : V, (W ∩ inN T h).card ≤ 6) :
    ∃! s : V, W = insert s (outN T s) := by
  let t : V → ℕ := fun h => (W ∩ inN T h).card
  have hsum : ∑ h : V, t h = 132 := by
    dsimp [t]
    rw [sum_hits T W hreg, hW]
  have hsq : ∑ h : V, (t h) ^ 2 = 792 := by
    dsimp [t]
    rw [sum_sq_hits T W hreg hcod, hW]
  obtain ⟨s, hts, hsuniq⟩ := deficit_rigidity (V := V) hN hcap hsum hsq
  have hsW : s ∈ W := by
    by_contra hsnot
    have hinternal := two_mul_sum_internal_indeg T hT W
    have hinside : ∑ h ∈ W, t h = 66 := by
      dsimp [t]
      rw [hW] at hinternal
      norm_num at hinternal
      omega
    have houtside : ∑ h ∈ univ \ W, t h = 66 := by
      have hdisj : Disjoint W (univ \ W) := by
        rw [Finset.disjoint_left]
        intro x hxW hxout
        exact (Finset.mem_sdiff.mp hxout).2 hxW
      have hunion : W ∪ (univ \ W) = univ := Finset.union_sdiff_of_subset (Finset.subset_univ W)
      have hsplit : ∑ h : V, t h = ∑ h ∈ W, t h + ∑ h ∈ univ \ W, t h := by
        rw [← Finset.sum_union hdisj, hunion]
      rw [hsum, hinside] at hsplit
      omega
    have houtside_card : (univ \ W).card = 11 := by
      simp [Finset.card_sdiff, hN, hW]
    have heq : ∀ h ∈ univ \ W, t h = 6 := by
      have hconst : ∑ _h ∈ univ \ W, 6 = 66 := by
        rw [Finset.sum_const, houtside_card, smul_eq_mul]
      have hsame : ∑ h ∈ univ \ W, t h = ∑ _h ∈ univ \ W, 6 := by
        rw [houtside, hconst]
      exact (Finset.sum_eq_sum_iff_of_le (fun h hh => hcap h)).mp hsame
    have htsix : t s = 6 := heq s (by simp [hsnot])
    have htzero : t s = 0 := hts
    omega
  have hsub : W ⊆ insert s (outN T s) := by
    intro w hw
    by_cases hws : w = s
    · simp [hws]
    · have hn : ¬ T w s := by
        intro hws'
        have : w ∈ W ∩ inN T s := by
          exact Finset.mem_inter.mpr ⟨hw, (Erdos902Rigid.mem_inN T).mpr hws'⟩
        have hpos : 0 < (W ∩ inN T s).card := Finset.card_pos.mpr ⟨w, this⟩
        omega
      have hsw : T s w := (hT.total s w (Ne.symm hws)).resolve_right hn
      exact Finset.mem_insert.mpr (Or.inr ((Erdos902Rigid.mem_outN T).mpr hsw))
  have hcard_closed : (insert s (outN T s)).card = 12 := by
    have hsnot : s ∉ outN T s := by
      intro hs
      exact hT.irrefl s ((Erdos902Rigid.mem_outN T).mp hs)
    rw [Finset.card_insert_of_notMem hsnot, hreg s]
  have hEq : W = insert s (outN T s) :=
    Finset.eq_of_subset_of_card_le hsub (by rw [hcard_closed, hW])
  refine ⟨s, hEq, ?_⟩
  intro z hzEq
  apply hsuniq z
  rw [hzEq]
  rw [Finset.card_eq_zero]
  rw [Finset.eq_empty_iff_forall_notMem]
  intro u hu
  have huin : T u z := (Erdos902Rigid.mem_inN T).mp (Finset.mem_inter.mp hu).2
  rcases Finset.mem_insert.mp (Finset.mem_inter.mp hu).1 with huz | huout
  · subst u
    exact hT.irrefl z huin
  · exact hT.asymm z u ((Erdos902Rigid.mem_outN T).mp huout) huin

end Erdos902DRT23Rigidity

#print axioms Erdos902DRT23Rigidity.feasible_card12_eq_closed_outN
