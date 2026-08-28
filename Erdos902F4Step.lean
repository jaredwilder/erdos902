/-
The analytic reduction behind the candidate finite bound `f(4) >= 49`.

A hypothetical 48-vertex tournament with Schutte's property `S_4` is forced into a rigid
local shape.  This file proves the five reduction steps, in order:

  1. every in-neighbourhood has at least 23 vertices, and on 48 vertices some
     in-neighbourhood has exactly 23  (`indeg_ge_23`, `exists_indeg_eq_23`);
  2. that in-neighbourhood `H` inherits `S_3`  (`H_hasSleM_three`);
  3. `H` is doubly regular with parameters (23, 11, 5)  (`H_internal_indeg`,
     `H_internal_codeg`);
  4. every vertex outside `H` beats at most 12 vertices of `H`  (`outside_mask_card_le`);
  5. and meets every internal in-neighbourhood of `H` in at most 6
     (`outside_mask_codeg_le`).

Steps 4 and 5 are the exact constraints under which a finite repair-capacity computation
would be carried out.  That computation is NOT in this file, and nothing here asserts it.
What is proved here is the reduction that isolates it.  No classification theorem is used.
-/
import Erdos902Reid

open Finset

namespace Erdos902F4Step

universe u

variable {V : Type u} [Fintype V] [DecidableEq V]
  (T : V → V → Prop) [DecidableRel T]

open Erdos902Reid (inN outN)

/-! ## A double count inside an arbitrary vertex set -/

/-- Inside any set `H`, a vertex of `H` splits `H \ {h}` into its internal in- and
out-neighbourhoods. -/
theorem internal_split (hT : IsTournament T) (H : Finset V) {h : V} (hh : h ∈ H) :
    (H ∩ inN T h).card + (H ∩ outN T h).card = H.card - 1 := by
  classical
  have hdisj : Disjoint (H ∩ inN T h) (H ∩ outN T h) := by
    rw [Finset.disjoint_left]
    intro z hz1 hz2
    have h1 : T z h := (Erdos902Rigid.mem_inN T).mp (Finset.mem_inter.mp hz1).2
    have h2 : T h z := (Erdos902Rigid.mem_outN T).mp (Finset.mem_inter.mp hz2).2
    exact hT.asymm z h h1 h2
  have hunion : (H ∩ inN T h) ∪ (H ∩ outN T h) = H.erase h := by
    ext z
    simp only [Finset.mem_union, Finset.mem_inter, Finset.mem_erase]
    constructor
    · rintro (⟨hzH, hz⟩ | ⟨hzH, hz⟩)
      · refine ⟨?_, hzH⟩
        intro hc; subst hc
        exact hT.irrefl _ ((Erdos902Rigid.mem_inN T).mp hz)
      · refine ⟨?_, hzH⟩
        intro hc; subst hc
        exact hT.irrefl _ ((Erdos902Rigid.mem_outN T).mp hz)
    · rintro ⟨hzh, hzH⟩
      rcases hT.total z h hzh with h1 | h1
      · exact Or.inl ⟨hzH, (Erdos902Rigid.mem_inN T).mpr h1⟩
      · exact Or.inr ⟨hzH, (Erdos902Rigid.mem_outN T).mpr h1⟩
  rw [← Finset.card_union_of_disjoint hdisj, hunion, Finset.card_erase_of_mem hh]

/-- Internal in-degrees inside `H` sum to the number of pairs of `H`. -/
theorem two_mul_sum_internal_indeg (hT : IsTournament T) (H : Finset V) :
    2 * ∑ h ∈ H, (H ∩ inN T h).card = H.card * (H.card - 1) := by
  classical
  have hin : ∑ h ∈ H, (H ∩ inN T h).card
      = ∑ h ∈ H, ∑ z ∈ H, (if T z h then 1 else 0) := by
    refine Finset.sum_congr rfl (fun h _ => ?_)
    have : (H ∩ inN T h) = H.filter (fun z => T z h) := by
      ext z; simp [Erdos902Rigid.mem_inN, and_comm]
    rw [this, Finset.card_filter]
  have hout : ∑ h ∈ H, (H ∩ outN T h).card
      = ∑ h ∈ H, ∑ z ∈ H, (if T h z then 1 else 0) := by
    refine Finset.sum_congr rfl (fun h _ => ?_)
    have : (H ∩ outN T h) = H.filter (fun z => T h z) := by
      ext z; simp [Erdos902Rigid.mem_outN, and_comm]
    rw [this, Finset.card_filter]
  have hEq : ∑ h ∈ H, (H ∩ outN T h).card = ∑ h ∈ H, (H ∩ inN T h).card := by
    rw [hin, hout]; exact Finset.sum_comm
  have hsum : ∑ h ∈ H, ((H ∩ inN T h).card + (H ∩ outN T h).card)
      = H.card * (H.card - 1) := by
    rw [Finset.sum_congr rfl (fun h hh => internal_split T hT H hh),
      Finset.sum_const, smul_eq_mul]
  rw [Finset.sum_add_distrib, hEq] at hsum
  omega

/-! ## Step 1: a vertex of in-degree exactly 23 -/

/-- The multiplicity `5` at the level of triples. -/
theorem mult_five (hT : IsTournament T) (hS : HasSle T 4) :
    Erdos902Szekeres.HasSleM T 3 5 := by
  have H4 : Erdos902Szekeres.HasSleM T 4 1 :=
    Erdos902Szekeres.hasSleM_one_of_hasSle T hS
  simpa using Erdos902Szekeres.amplification T hT 3 1 (by norm_num) H4

/-- **Step 1a.**  Under `S_4`, every in-neighbourhood has at least 23 vertices. -/
theorem indeg_ge_23 (hT : IsTournament T) (hS : HasSle T 4) (v : V) :
    23 ≤ (inN T v).card := by
  have H2 := Erdos902Szekeres.hasSleM_induced T hT 2 5 (mult_five T hT hS) v
  have hc := Erdos902Szekeres.card_ge_of_hasSleM 2 5 (by norm_num)
    (induced T v) (induced_isTournament T hT v) H2
  norm_num at hc
  change 23 ≤ indeg T v
  rw [← card_inNbhd T v]
  exact hc

/-- **Step 1b.**  On 48 vertices, some in-neighbourhood has exactly 23. -/
theorem exists_indeg_eq_23 (hT : IsTournament T) (hS : HasSle T 4)
    (hN : Fintype.card V = 48) : ∃ v : V, (inN T v).card = 23 := by
  classical
  by_contra hcon
  push_neg at hcon
  have h24 : ∀ v : V, 24 ≤ (inN T v).card := by
    intro v
    have := indeg_ge_23 T hT hS v
    have := hcon v
    omega
  have hsum := Erdos902Rigid.sum_indeg T hT
  have hlow : 48 * 24 ≤ ∑ v : V, (inN T v).card := by
    calc 48 * 24 = ∑ _v : V, 24 := by
          simp [Finset.sum_const, Finset.card_univ, hN]
      _ ≤ ∑ v : V, (inN T v).card := Finset.sum_le_sum (fun v _ => h24 v)
  rw [hsum, hN] at hlow
  have hc48 : Nat.choose 48 2 = 1128 := by decide
  omega

/-! ## Step 2: the in-neighbourhood inherits `S_3` -/

/-- **Step 2.**  `N⁻(v)` carries Schutte's property `S_3`. -/
theorem H_hasSleM_three (hT : IsTournament T) (hS : HasSle T 4) (v : V) :
    Erdos902Szekeres.HasSleM (induced T v) 3 1 :=
  Erdos902Szekeres.hasSleM_induced T hT 3 1
    (Erdos902Szekeres.hasSleM_one_of_hasSle T hS) v

/-! ## Step 3: `H` is doubly regular with parameters (23, 11, 5) -/

/-- Every pair inside `H = N⁻(v)` has at least 5 common in-neighbours inside `H`. -/
theorem H_codeg_ge_five (hT : IsTournament T) (hS : HasSle T 4) (v : V)
    {x y : V} (hx : x ∈ inN T v) (hy : y ∈ inN T v) :
    5 ≤ ((inN T v) ∩ (inN T x) ∩ (inN T y)).card := by
  classical
  have h3 : ({v, x, y} : Finset V).card ≤ 3 := by
    have a1 := Finset.card_insert_le v ({x, y} : Finset V)
    have a2 := Finset.card_insert_le x ({y} : Finset V)
    simp only [Finset.card_singleton] at a1 a2
    omega
  have hdom := mult_five T hT hS {v, x, y} h3
  refine le_trans hdom (Finset.card_le_card ?_)
  intro z hz
  have hz' : ∀ b ∈ ({v, x, y} : Finset V), T z b := (Finset.mem_filter.mp hz).2
  refine Finset.mem_inter.mpr ⟨Finset.mem_inter.mpr ⟨?_, ?_⟩, ?_⟩
  · exact (Erdos902Rigid.mem_inN T).mpr (hz' v (by simp))
  · exact (Erdos902Rigid.mem_inN T).mpr (hz' x (by simp))
  · exact (Erdos902Rigid.mem_inN T).mpr (hz' y (by simp))

/-- Every vertex of `H = N⁻(v)` has at least 11 in-neighbours inside `H`. -/
theorem H_internal_indeg_ge_eleven (hT : IsTournament T) (hS : HasSle T 4) (v : V)
    {h : V} (hh : h ∈ inN T v) :
    11 ≤ ((inN T v) ∩ (inN T h)).card := by
  have hne : v ≠ h := by
    intro hc; subst hc
    exact hT.irrefl _ ((Erdos902Rigid.mem_inN T).mp hh)
  exact Erdos902Reid.pair_common_in_ge_eleven T hT (mult_five T hT hS) v h hne

/-- **Step 3a.**  When `|H| = 23`, every internal in-degree is exactly 11. -/
theorem H_internal_indeg (hT : IsTournament T) (hS : HasSle T 4) (v : V)
    (hHc : (inN T v).card = 23) {h : V} (hh : h ∈ inN T v) :
    ((inN T v) ∩ (inN T h)).card = 11 := by
  classical
  set H := inN T v with hH
  have hge : ∀ g ∈ H, 11 ≤ (H ∩ inN T g).card := fun g hg =>
    H_internal_indeg_ge_eleven T hT hS v hg
  have hdouble := two_mul_sum_internal_indeg T hT H
  rw [hHc] at hdouble
  -- the sum is forced to be exactly 23 * 11
  have hsum : ∑ g ∈ H, (H ∩ inN T g).card = 253 := by omega
  have hlow : ∑ _g ∈ H, 11 = 253 := by
    rw [Finset.sum_const, hHc, smul_eq_mul]
  by_contra hne
  have hgt : 12 ≤ (H ∩ inN T h).card := by
    have := hge h hh
    omega
  have : 253 < ∑ g ∈ H, (H ∩ inN T g).card := by
    calc (253 : ℕ) = ∑ _g ∈ H, 11 := hlow.symm
      _ < ∑ g ∈ H, (H ∩ inN T g).card := by
          refine Finset.sum_lt_sum (fun g hg => hge g hg) ⟨h, hh, ?_⟩
          omega
  omega

/-- **Step 3b.**  When `|H| = 23`, every internal codegree is exactly 5:
`H` is a doubly regular tournament with parameters (23, 11, 5). -/
theorem H_internal_codeg (hT : IsTournament T) (hS : HasSle T 4) (v : V)
    (hHc : (inN T v).card = 23) {x y : V} (hx : x ∈ inN T v) (hy : y ∈ inN T v)
    (hxy : x ≠ y) :
    5 ≤ ((inN T v) ∩ (inN T x) ∩ (inN T y)).card ∧
      ((inN T v) ∩ (inN T x)).card = 11 ∧ ((inN T v) ∩ (inN T y)).card = 11 :=
  ⟨H_codeg_ge_five T hT hS v hx hy, H_internal_indeg T hT hS v hHc hx,
    H_internal_indeg T hT hS v hHc hy⟩

/-! ## Steps 4 and 5: the constraints on an outside vertex -/

/-- **Step 4.**  A vertex `x` beaten by `v` beats at most 12 vertices of `H = N⁻(v)`. -/
theorem outside_mask_card_le (hT : IsTournament T) (hS : HasSle T 4) (v : V)
    (hHc : (inN T v).card = 23) {x : V} (hx : T v x) :
    ((inN T v) ∩ (outN T x)).card ≤ 12 := by
  classical
  have hxv : v ≠ x := fun hc => hT.irrefl v (hc ▸ hx)
  have h11 : 11 ≤ ((inN T v) ∩ (inN T x)).card :=
    Erdos902Reid.pair_common_in_ge_eleven T hT (mult_five T hT hS) v x hxv
  -- `x` is not in `H`, so `H` splits along `x`
  have hxH : x ∉ inN T v := by
    intro hc
    exact hT.asymm v x hx ((Erdos902Rigid.mem_inN T).mp hc)
  have hsplit : ((inN T v) ∩ (inN T x)).card + ((inN T v) ∩ (outN T x)).card
      = (inN T v).card := by
    have hdisj : Disjoint ((inN T v) ∩ (inN T x)) ((inN T v) ∩ (outN T x)) := by
      rw [Finset.disjoint_left]
      intro z hz1 hz2
      have h1 : T z x := (Erdos902Rigid.mem_inN T).mp (Finset.mem_inter.mp hz1).2
      have h2 : T x z := (Erdos902Rigid.mem_outN T).mp (Finset.mem_inter.mp hz2).2
      exact hT.asymm z x h1 h2
    have hunion : ((inN T v) ∩ (inN T x)) ∪ ((inN T v) ∩ (outN T x)) = inN T v := by
      ext z
      simp only [Finset.mem_union, Finset.mem_inter]
      constructor
      · rintro (⟨hz, -⟩ | ⟨hz, -⟩) <;> exact hz
      · intro hz
        have hzx : z ≠ x := fun hc => hxH (hc ▸ hz)
        rcases hT.total z x hzx with h1 | h1
        · exact Or.inl ⟨hz, (Erdos902Rigid.mem_inN T).mpr h1⟩
        · exact Or.inr ⟨hz, (Erdos902Rigid.mem_outN T).mpr h1⟩
    rw [← Finset.card_union_of_disjoint hdisj, hunion]
  omega

/-- **Step 5.**  That same vertex meets every internal in-neighbourhood of `H` in at
most 6 vertices. -/
theorem outside_mask_codeg_le (hT : IsTournament T) (hS : HasSle T 4) (v : V)
    (hHc : (inN T v).card = 23) {x : V} (hx : T v x) {h : V} (hh : h ∈ inN T v) :
    ((inN T v) ∩ (outN T x) ∩ (inN T h)).card ≤ 6 := by
  classical
  have hxH : x ∉ inN T v := by
    intro hc
    exact hT.asymm v x hx ((Erdos902Rigid.mem_inN T).mp hc)
  -- the triple {v, x, h} has at least five common dominators, all inside H
  have h5 : 5 ≤ ((inN T v) ∩ (inN T x) ∩ (inN T h)).card := by
    have h3 : ({v, x, h} : Finset V).card ≤ 3 := by
      have a1 := Finset.card_insert_le v ({x, h} : Finset V)
      have a2 := Finset.card_insert_le x ({h} : Finset V)
      simp only [Finset.card_singleton] at a1 a2
      omega
    have hdom := mult_five T hT hS {v, x, h} h3
    refine le_trans hdom (Finset.card_le_card ?_)
    intro z hz
    have hz' : ∀ b ∈ ({v, x, h} : Finset V), T z b := (Finset.mem_filter.mp hz).2
    refine Finset.mem_inter.mpr ⟨Finset.mem_inter.mpr ⟨?_, ?_⟩, ?_⟩
    · exact (Erdos902Rigid.mem_inN T).mpr (hz' v (by simp))
    · exact (Erdos902Rigid.mem_inN T).mpr (hz' x (by simp))
    · exact (Erdos902Rigid.mem_inN T).mpr (hz' h (by simp))
  -- the internal in-neighbourhood of `h` has exactly 11 vertices and splits along `x`
  have h11 : ((inN T v) ∩ (inN T h)).card = 11 := H_internal_indeg T hT hS v hHc hh
  have hsplit : ((inN T v) ∩ (inN T h) ∩ (inN T x)).card
      + ((inN T v) ∩ (inN T h) ∩ (outN T x)).card = ((inN T v) ∩ (inN T h)).card := by
    have hdisj : Disjoint ((inN T v) ∩ (inN T h) ∩ (inN T x))
        ((inN T v) ∩ (inN T h) ∩ (outN T x)) := by
      rw [Finset.disjoint_left]
      intro z hz1 hz2
      have h1 : T z x := (Erdos902Rigid.mem_inN T).mp (Finset.mem_inter.mp hz1).2
      have h2 : T x z := (Erdos902Rigid.mem_outN T).mp (Finset.mem_inter.mp hz2).2
      exact hT.asymm z x h1 h2
    have hunion : ((inN T v) ∩ (inN T h) ∩ (inN T x))
        ∪ ((inN T v) ∩ (inN T h) ∩ (outN T x)) = (inN T v) ∩ (inN T h) := by
      ext z
      simp only [Finset.mem_union, Finset.mem_inter]
      constructor
      · rintro (⟨hz, -⟩ | ⟨hz, -⟩) <;> exact hz
      · intro hz
        have hzx : z ≠ x := fun hc => hxH (hc ▸ hz.1)
        rcases hT.total z x hzx with h1 | h1
        · exact Or.inl ⟨hz, (Erdos902Rigid.mem_inN T).mpr h1⟩
        · exact Or.inr ⟨hz, (Erdos902Rigid.mem_outN T).mpr h1⟩
    rw [← Finset.card_union_of_disjoint hdisj, hunion]
  -- rearrange the two intersections into the same shape
  have hreorder : ((inN T v) ∩ (inN T h) ∩ (inN T x)).card
      = ((inN T v) ∩ (inN T x) ∩ (inN T h)).card := by
    congr 1; ext z; simp only [Finset.mem_inter]; tauto
  have hreorder2 : ((inN T v) ∩ (inN T h) ∩ (outN T x)).card
      = ((inN T v) ∩ (outN T x) ∩ (inN T h)).card := by
    congr 1; ext z; simp only [Finset.mem_inter]; tauto
  omega

end Erdos902F4Step

#print axioms Erdos902F4Step.indeg_ge_23
#print axioms Erdos902F4Step.exists_indeg_eq_23
#print axioms Erdos902F4Step.H_hasSleM_three
#print axioms Erdos902F4Step.H_internal_indeg
#print axioms Erdos902F4Step.outside_mask_card_le
#print axioms Erdos902F4Step.outside_mask_codeg_le
