import Erdos902Mass

/-!
PRIVATE OWNERSHIP IS IRREDUNDANCY, NOT EXTRA COVERING STRENGTH.

The proposed antisymmetric-cover route singled out the fact that every row of a
vertex-critical tournament owns a private `k`-set. This file isolates the generic
covering content of that observation.

For every finite set cover, having one private target per selected block is exactly
the same as inclusion-irredundancy. In particular every minimum-cardinality cover
already has private ownership. Therefore private rows cannot, by themselves or via
generic minimal-cover inequalities, improve a covering-number lower bound. Any gain
for Erdos #902 from this representation must use the genuinely tournament-specific
condition that the incidence matrix is self-indexed and antisymmetric.
-/

open Finset

namespace Erdos902PrivateCoverBarrier

variable {X I : Type*} [DecidableEq X] [DecidableEq I]

/-- The blocks indexed by `C` cover every target in `U`. -/
def Covers (B : I → Finset X) (U : Finset X) (C : Finset I) : Prop :=
  ∀ x ∈ U, ∃ i ∈ C, x ∈ B i

/-- No selected block can be deleted while retaining the cover. -/
def Irredundant (B : I → Finset X) (U : Finset X) (C : Finset I) : Prop :=
  Covers B U C ∧ ∀ i ∈ C, ¬ Covers B U (C.erase i)

/-- Every selected block owns a target covered by no other selected block. -/
def HasPrivateTargets (B : I → Finset X) (U : Finset X) (C : Finset I) : Prop :=
  ∀ i ∈ C, ∃ x ∈ U, x ∈ B i ∧ ∀ j ∈ C, x ∈ B j → j = i

/-- An irredundant cover automatically gives every block a private target. -/
theorem private_targets_of_irredundant {B : I → Finset X} {U : Finset X} {C : Finset I}
    (h : Irredundant B U C) : HasPrivateTargets B U C := by
  rcases h with ⟨hcover, hdelete⟩
  intro i hi
  have hfail := hdelete i hi
  unfold Covers at hfail
  push Not at hfail
  obtain ⟨x, hxU, hxnone⟩ := hfail
  obtain ⟨q, hqC, hxq⟩ := hcover x hxU
  have hqi : q = i := by
    by_contra hne
    exact hxnone q (Finset.mem_erase.mpr ⟨hne, hqC⟩) hxq
  subst q
  refine ⟨x, hxU, hxq, ?_⟩
  intro j hjC hxj
  by_contra hne
  exact hxnone j (Finset.mem_erase.mpr ⟨hne, hjC⟩) hxj

/-- Conversely, private ownership makes every covered block indispensable. -/
theorem irredundant_of_private_targets {B : I → Finset X} {U : Finset X} {C : Finset I}
    (hcover : Covers B U C) (hprivate : HasPrivateTargets B U C) :
    Irredundant B U C := by
  refine ⟨hcover, ?_⟩
  intro i hi herase
  obtain ⟨x, hxU, hxi, hxprivate⟩ := hprivate i hi
  obtain ⟨j, hjErase, hxj⟩ := herase x hxU
  have hjC : j ∈ C := (Finset.mem_erase.mp hjErase).2
  have hji : j = i := hxprivate j hjC hxj
  exact (Finset.mem_erase.mp hjErase).1 hji

/-- Under the cover hypothesis, private ownership is exactly irredundancy. -/
theorem private_targets_iff_irredundant {B : I → Finset X} {U : Finset X} {C : Finset I}
    (hcover : Covers B U C) :
    HasPrivateTargets B U C ↔ Irredundant B U C := by
  constructor
  · exact irredundant_of_private_targets hcover
  · exact private_targets_of_irredundant

/-- A minimum-cardinality finite cover is inclusion-irredundant. -/
theorem irredundant_of_minimum_card {B : I → Finset X} {U : Finset X} {C : Finset I}
    (hcover : Covers B U C)
    (hmin : ∀ D : Finset I, Covers B U D → C.card ≤ D.card) :
    Irredundant B U C := by
  refine ⟨hcover, ?_⟩
  intro i hi herase
  have hle := hmin (C.erase i) herase
  have hlt : (C.erase i).card < C.card := Finset.card_erase_lt_of_mem hi
  exact (Nat.not_le_of_gt hlt) hle

/-- **ROUTE-KILL.** Every minimum finite cover has one private target per block.
Private ownership is therefore available before any antisymmetry is used. -/
theorem minimum_cover_has_private_targets
    {B : I → Finset X} {U : Finset X} {C : Finset I}
    (hcover : Covers B U C)
    (hmin : ∀ D : Finset I, Covers B U D → C.card ≤ D.card) :
    HasPrivateTargets B U C :=
  private_targets_of_irredundant (irredundant_of_minimum_card hcover hmin)

/-! ### The exact set-pair reduction for private tournament witnesses -/

variable {V : Type*} [Fintype V] [DecidableEq V]
variable (T : V → V → Prop) [DecidableRel T]

/-- A vertex together with every vertex which beats it. -/
def closedInN (v : V) : Finset V :=
  insert v (univ.filter fun p => T p v)

/-- A private witness and its owner's closed in-neighbourhood are disjoint. -/
theorem private_pair_self_disjoint (hT : IsTournament T) (P : V → Finset V)
    (hprivate : ∀ v, Erdos902Mass.domSet T (P v) = {v}) (v : V) :
    P v ∩ closedInN T v = ∅ := by
  have hvDom : v ∈ Erdos902Mass.domSet T (P v) := by rw [hprivate v]; simp
  have hvbeats : ∀ p ∈ P v, T v p := by
    simpa [Erdos902Mass.domSet, Erdos902Mass.DominatesAll] using hvDom
  ext p
  rw [Finset.mem_inter]
  constructor
  · rintro ⟨hpP, hpClosed⟩
    rw [closedInN, Finset.mem_insert] at hpClosed
    rcases hpClosed with hpEq | hpv
    · subst p
      exact False.elim (hT.irrefl v (hvbeats v hpP))
    · have hvp := hvbeats p hpP
      exact False.elim (hT.asymm v p hvp (Finset.mem_filter.mp hpv).2)
  · intro hp
    simpa using hp

/-- Private tournament witnesses form a Bollobas cross-intersecting set-pair system:
`P_v` is disjoint from the closed in-neighbourhood of `v`, but meets that of every
other vertex. -/
theorem private_pair_cross_intersects (hT : IsTournament T) (P : V → Finset V)
    (hprivate : ∀ v, Erdos902Mass.domSet T (P v) = {v})
    {u v : V} (huv : u ≠ v) :
    (P v ∩ closedInN T u).Nonempty := by
  by_cases huP : u ∈ P v
  · exact ⟨u, Finset.mem_inter.mpr ⟨huP, by simp [closedInN]⟩⟩
  · have huNotDom : u ∉ Erdos902Mass.domSet T (P v) := by
      rw [hprivate v, Finset.mem_singleton]
      exact huv
    simp only [Erdos902Mass.domSet, Finset.mem_filter, Finset.mem_univ, true_and,
      Erdos902Mass.DominatesAll] at huNotDom
    push Not at huNotDom
    obtain ⟨p, hpP, hnup⟩ := huNotDom
    have hup_ne : u ≠ p := by
      intro h
      subst p
      exact huP hpP
    have hpu : T p u := by
      rcases hT.total u p hup_ne with hup | hpu
      · exact False.elim (hnup hup)
      · exact hpu
    exact ⟨p, Finset.mem_inter.mpr ⟨hpP, by simp [closedInN, hpu]⟩⟩

end Erdos902PrivateCoverBarrier

#print axioms Erdos902PrivateCoverBarrier.private_targets_of_irredundant
#print axioms Erdos902PrivateCoverBarrier.irredundant_of_private_targets
#print axioms Erdos902PrivateCoverBarrier.private_targets_iff_irredundant
#print axioms Erdos902PrivateCoverBarrier.irredundant_of_minimum_card
#print axioms Erdos902PrivateCoverBarrier.minimum_cover_has_private_targets
#print axioms Erdos902PrivateCoverBarrier.private_pair_self_disjoint
#print axioms Erdos902PrivateCoverBarrier.private_pair_cross_intersects
