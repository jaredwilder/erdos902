import Erdos902Mass
import Erdos902ClosedForm

/-!
The dominator cube attached to a private witness.

For a `k`-set `P` and a face `R ⊆ P`, `privateFace T P R` consists of the vertices
which beat every point of `P \ R`.  The central theorem says that, in any tournament
with `S_k`, this face itself has `S_|R|`.  The faces also obey the exact Boolean law

`D_R ∩ D_S = D_(R ∩ S)`.

When `P` has a unique dominator `v`, failure sets turn membership in the cube into
literal subset containment, and every vertex other than `v` has a nonempty failure set.
-/

open Finset

namespace Erdos902DominatorCube

variable {V : Type*} [Fintype V] [DecidableEq V]
variable (T : V → V → Prop) [DecidableRel T]

/-- `S_n` relativised to a specified set of vertices. -/
def HasSleOn (W : Finset V) (n : ℕ) : Prop :=
  ∀ S : Finset V, S ⊆ W → S.card ≤ n → ∃ v ∈ W, v ∉ S ∧ ∀ s ∈ S, T v s

/-- The Boolean face indexed by `R`: vertices dominating `P \ R`. -/
def privateFace (P R : Finset V) : Finset V :=
  Erdos902Mass.domSet T (P \ R)

/-- Points of `P` not beaten by `w`. -/
def failureSet (P : Finset V) (w : V) : Finset V :=
  P.filter fun p => ¬ T w p

/-- **DOMINATOR-CUBE FACE THEOREM.** Every face `R` of a `k`-set `P` carries
the downward-closed Schuette property `S_|R|`, relativised to that face. -/
theorem private_face_hasS {k r : ℕ} (hS : HasSle T k)
    {P R : Finset V} (hRP : R ⊆ P) (hP : P.card = k) (hR : R.card = r) :
    HasSleOn T (privateFace T P R) r := by
  intro S hSface hScard
  have hdiff : (P \ R).card = k - r := by
    rw [Finset.card_sdiff, Finset.inter_eq_left.mpr hRP, hP, hR]
  have hunion : ((P \ R) ∪ S).card ≤ k := by
    calc
      ((P \ R) ∪ S).card ≤ (P \ R).card + S.card := Finset.card_union_le _ _
      _ ≤ (k - r) + r := by rw [hdiff]; exact Nat.add_le_add_left hScard _
      _ = k := by
        have hrk : r ≤ k := by simpa [hP, hR] using Finset.card_le_card hRP
        omega
  obtain ⟨w, hwout, hwbeats⟩ := hS ((P \ R) ∪ S) hunion
  refine ⟨w, ?_, ?_, ?_⟩
  · simp only [privateFace, Erdos902Mass.domSet, Finset.mem_filter,
      Finset.mem_univ, true_and, Erdos902Mass.DominatesAll]
    intro p hp
    exact hwbeats p (Finset.mem_union_left S hp)
  · intro hwS
    exact hwout (Finset.mem_union_right (P \ R) hwS)
  · intro s hs
    exact hwbeats s (Finset.mem_union_right (P \ R) hs)

/-- **EXACT BOOLEAN INTERSECTION LAW.** Cube faces reverse intersections exactly. -/
theorem private_face_inter {P R S : Finset V} :
    privateFace T P R ∩ privateFace T P S = privateFace T P (R ∩ S) := by
  ext w
  rw [Finset.mem_inter]
  simp only [privateFace, Erdos902Mass.domSet, Finset.mem_filter,
    Finset.mem_univ, true_and, Erdos902Mass.DominatesAll]
  constructor
  · rintro ⟨hR, hS⟩ p hp
    rw [Finset.mem_sdiff] at hp
    rcases hp with ⟨hpP, hpnot⟩
    by_cases hpR : p ∈ R
    · exact hS p (Finset.mem_sdiff.mpr ⟨hpP,
        fun hpS => hpnot (Finset.mem_inter.mpr ⟨hpR, hpS⟩)⟩)
    · exact hR p (Finset.mem_sdiff.mpr ⟨hpP, hpR⟩)
  · intro h
    constructor <;> intro p hp
    · exact h p (Finset.mem_sdiff.mpr ⟨(Finset.mem_sdiff.mp hp).1,
        fun hpRS => (Finset.mem_sdiff.mp hp).2 (Finset.mem_inter.mp hpRS).1⟩)
    · exact h p (Finset.mem_sdiff.mpr ⟨(Finset.mem_sdiff.mp hp).1,
        fun hpRS => (Finset.mem_sdiff.mp hp).2 (Finset.mem_inter.mp hpRS).2⟩)

/-- Face membership is exactly containment of the vertex's failure set. -/
theorem mem_privateFace_iff_failureSet_subset {P R : Finset V} {w : V} :
    w ∈ privateFace T P R ↔ failureSet T P w ⊆ R := by
  simp only [privateFace, Erdos902Mass.domSet, Finset.mem_filter,
    Finset.mem_univ, true_and, Erdos902Mass.DominatesAll]
  constructor
  · intro h p hp
    simp only [failureSet, Finset.mem_filter] at hp
    by_contra hpR
    exact hp.2 (h p (Finset.mem_sdiff.mpr ⟨hp.1, hpR⟩))
  · intro h p hp
    by_contra hn
    have : p ∈ failureSet T P w := by
      simp only [failureSet, Finset.mem_filter]
      exact ⟨(Finset.mem_sdiff.mp hp).1, hn⟩
    exact (Finset.mem_sdiff.mp hp).2 (h this)

/-- The unique private dominator has empty failure set. -/
theorem failureSet_private_vertex {P : Finset V} {v : V}
    (hprivate : Erdos902Mass.domSet T P = {v}) : failureSet T P v = ∅ := by
  have hv : v ∈ Erdos902Mass.domSet T P := by simp [hprivate]
  have hbeats : ∀ p ∈ P, T v p := by
    simpa [Erdos902Mass.domSet, Erdos902Mass.DominatesAll] using hv
  ext p
  simp only [failureSet, Finset.mem_filter]
  constructor
  · rintro ⟨hp, hn⟩
    simpa using hn (hbeats p hp)
  · intro hp
    simpa using hp

/-- Every other vertex has a nonempty failure set relative to a private witness. -/
theorem failureSet_nonempty_of_ne_private {P : Finset V} {v w : V}
    (hprivate : Erdos902Mass.domSet T P = {v}) (hwv : w ≠ v) :
    (failureSet T P w).Nonempty := by
  by_contra hempty
  rw [Finset.not_nonempty_iff_eq_empty] at hempty
  have hbeats : ∀ p ∈ P, T w p := by
    intro p hp
    by_contra hn
    have : p ∈ failureSet T P w := by simp [failureSet, hp, hn]
    simpa [hempty] using this
  have hw : w ∈ Erdos902Mass.domSet T P := by
    simpa [Erdos902Mass.domSet, Erdos902Mass.DominatesAll] using hbeats
  rw [hprivate, Finset.mem_singleton] at hw
  exact hwv hw

end Erdos902DominatorCube

#print axioms Erdos902DominatorCube.private_face_hasS
#print axioms Erdos902DominatorCube.private_face_inter
#print axioms Erdos902DominatorCube.mem_privateFace_iff_failureSet_subset
#print axioms Erdos902DominatorCube.failureSet_private_vertex
#print axioms Erdos902DominatorCube.failureSet_nonempty_of_ne_private
