/-
Erdos 902 -- ORDER-MINIMAL EXTREMIZERS ARE ALL KINGS.

A vertex `v` is a KING when it reaches every other vertex in at most two steps.

The classical route to "every vertex of a minimum-order tournament with large domination
number is a king" goes through the theorem that the sub-tournament induced by the kings
carries the whole domination number.  That route is not needed here.

`HasSle T n` says every set of at most `n` vertices is dominated from outside.  Say a
vertex `v` is CRITICAL when some `n`-set `A` has `v` as its ONLY dominator.  Then:

  * `critical_of_deletion` -- if `T` has `S_n` and deleting any single vertex destroys it,
    every vertex is critical.  (The deleted witness set is extended to full size `n`; the
    extension is possible because `S_n` already forces `n < |V|`.)

  * `king_of_critical` -- a critical vertex is a king, in two lines: any other `u` fails to
    dominate `A`, so either `u` lies in `A` and `v` beats it directly, or some `a` in `A`
    beats `u` while `v` beats `a`.

  * `deletion_gives_kings` -- the two combined.

Nothing here uses `f`, and nothing here bears on the growth of `f`.  It is a structural
restriction on the extremizers.
-/

import Mathlib
import Erdos902Counting
import Erdos902ClosedForm
import Erdos902Mass

open Finset

namespace Erdos902Kings

variable {V : Type*} [Fintype V] [DecidableEq V]
variable (T : V → V → Prop) [DecidableRel T]

/-- The vertices dominating every element of `A`. -/
def domSet (A : Finset V) : Finset V := univ.filter (fun v => ∀ a ∈ A, T v a)

theorem mem_domSet {A : Finset V} {v : V} :
    v ∈ domSet T A ↔ ∀ a ∈ A, T v a := by simp [domSet]

/-- `S_n` relativised to a vertex subset `W`. -/
def HasSleOn (W : Finset V) (n : ℕ) : Prop :=
  ∀ S : Finset V, S ⊆ W → S.card ≤ n → ∃ v ∈ W, v ∉ S ∧ ∀ s ∈ S, T v s

/-- `v` is a king: it reaches every other vertex in at most two steps. -/
def IsKing (v : V) : Prop := ∀ u, u ≠ v → T v u ∨ ∃ w, T v w ∧ T w u

/-- `S_n` forces `n < |V|`: otherwise the whole vertex set would need a dominator
outside itself. -/
theorem card_gt_of_hasSle {n : ℕ} (h : HasSle T n) : n < Fintype.card V := by
  by_contra hc
  push_neg at hc
  obtain ⟨v, hv, -⟩ := h univ (by simpa using hc)
  exact hv (Finset.mem_univ v)

/-- **Deleting any vertex destroys `S_n` implies every vertex is critical.** -/
theorem critical_of_deletion {n : ℕ} (hT : IsTournament T) (hS : HasSle T n)
    (hmin : ∀ v : V, ¬ HasSleOn T (univ.erase v) n) (v : V) :
    ∃ A : Finset V, A.card = n ∧ v ∉ A ∧ domSet T A = {v} := by
  have h := hmin v
  unfold HasSleOn at h
  push_neg at h
  obtain ⟨A₀, hA₀sub, hA₀card, hA₀⟩ := h
  -- extend the failing set to full size, still avoiding `v`
  have hkle : n ≤ (univ.erase v).card := by
    rw [Finset.card_erase_of_mem (Finset.mem_univ v), Finset.card_univ]
    have := card_gt_of_hasSle T hS
    omega
  obtain ⟨A, hA0A, hAsub, hAcard⟩ :=
    Finset.exists_subsuperset_card_eq hA₀sub hA₀card hkle
  refine ⟨A, hAcard, fun hv => (Finset.mem_erase.mp (hAsub hv)).1 rfl, ?_⟩
  -- `A` has a dominator, and every dominator of `A` must be `v`
  obtain ⟨u, huA, hu⟩ := hS A (le_of_eq hAcard)
  have hall : ∀ w, w ∈ domSet T A → w = v := by
    intro w hw
    by_contra hne
    have hwe : w ∈ univ.erase v := Finset.mem_erase.mpr ⟨hne, Finset.mem_univ w⟩
    have hwA₀ : w ∉ A₀ := fun hc => hT.irrefl w ((mem_domSet T).mp hw w (hA0A hc))
    obtain ⟨s, hsA₀, hns⟩ := hA₀ w hwe hwA₀
    exact hns ((mem_domSet T).mp hw s (hA0A hsA₀))
  have hvD : v ∈ domSet T A := by
    have : u ∈ domSet T A := (mem_domSet T).mpr hu
    rw [← hall u this]; exact this
  ext x
  simp only [Finset.mem_singleton]
  exact ⟨hall x, fun hx => hx ▸ hvD⟩

/-- **A critical vertex is a king.** -/
theorem king_of_critical (hT : IsTournament T) {A : Finset V} {v : V}
    (hcrit : domSet T A = {v}) : IsKing T v := by
  have hvD : v ∈ domSet T A := by rw [hcrit]; exact Finset.mem_singleton_self v
  have hvA : ∀ a ∈ A, T v a := (mem_domSet T).mp hvD
  intro u hu
  have hnot : u ∉ domSet T A := by rw [hcrit, Finset.mem_singleton]; exact hu
  rw [mem_domSet] at hnot
  push_neg at hnot
  obtain ⟨a, haA, hua⟩ := hnot
  by_cases hau : a = u
  · subst hau
    exact Or.inl (hvA a haA)
  · rcases hT.total u a (fun hc => hau hc.symm) with h | h
    · exact absurd h hua
    · exact Or.inr ⟨a, hvA a haA, h⟩

/-- **Every vertex of an order-minimal `S_n` tournament is a king.** -/
theorem deletion_gives_kings {n : ℕ} (hT : IsTournament T) (hS : HasSle T n)
    (hmin : ∀ v : V, ¬ HasSleOn T (univ.erase v) n) (v : V) :
    IsKing T v := by
  obtain ⟨A, -, -, hcrit⟩ := critical_of_deletion T hT hS hmin v
  exact king_of_critical T hT hcrit

end Erdos902Kings

#print axioms Erdos902Kings.card_gt_of_hasSle
#print axioms Erdos902Kings.critical_of_deletion
#print axioms Erdos902Kings.king_of_critical
#print axioms Erdos902Kings.deletion_gives_kings
