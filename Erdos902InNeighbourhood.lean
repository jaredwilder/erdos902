/-
Erdos 902 (Schutte).  The in-neighbourhood lemma, and the counting corollary that
turns it into the lower bound f(n) >= 2 f(n-1) + 1.

A tournament is modelled as a relation `T` with `T a b` meaning "a beats b".
Property S_n says every n-set is dominated by some vertex outside it.

THE LEMMA.  If `T` has S_n then, for every vertex `v`, the sub-tournament induced on
the in-neighbourhood of `v` (the vertices that beat `v`) has S_(n-1).

No mathlib: `List` and `Nodup` are Lean core, so the axiom footprint stays minimal.
-/

namespace Erdos902InNbhd

/-- `HasS T n`: every `n`-element duplicate-free list of vertices is dominated by
    some vertex outside it. -/
def HasS {V : Type} (T : V → V → Prop) (n : Nat) : Prop :=
  ∀ S : List V, S.length = n → S.Nodup → ∃ v, v ∉ S ∧ ∀ s ∈ S, T v s

/-- The in-neighbourhood of `v`: the vertices that beat `v`. -/
abbrev InNbhd {V : Type} (T : V → V → Prop) (v : V) : Type := {u : V // T u v}

/-- The induced sub-tournament on the in-neighbourhood. -/
def induced {V : Type} (T : V → V → Prop) (v : V) :
    InNbhd T v → InNbhd T v → Prop :=
  fun a b => T a.val b.val

/-- **The lemma.**  A dominator of `S ∪ {v}` must itself beat `v`, so it lies INSIDE
    the in-neighbourhood of `v`.  That is the whole content. -/
theorem inNbhd_hasS {V : Type} (T : V → V → Prop)
    (hirr : ∀ x, ¬ T x x) (n : Nat) (h : HasS T (n + 1)) (v : V) :
    HasS (induced T v) n := by
  intro S hlen hnd
  -- lift the n-set out of the subtype and stick `v` on the front
  have hvnot : v ∉ S.map Subtype.val := by
    intro hv
    obtain ⟨x, _, hx⟩ := List.mem_map.mp hv
    have hx' : T x.val v := x.property
    rw [hx] at hx'
    exact hirr v hx'
  -- Nodup is Pairwise (· ≠ ·); core gives Pairwise.map, mathlib's Nodup.map is unavailable here
  have hmapnd : (S.map Subtype.val).Nodup :=
    List.Pairwise.map Subtype.val (fun a b hab hEq => hab (Subtype.ext hEq)) hnd
  have hlen' : (v :: S.map Subtype.val).length = n + 1 := by
    simp [hlen]
  have hnd' : (v :: S.map Subtype.val).Nodup := by
    exact List.nodup_cons.mpr ⟨hvnot, hmapnd⟩
  obtain ⟨u, hunot, hubeats⟩ := h (v :: S.map Subtype.val) hlen' hnd'
  -- u beats v, hence u lives in the in-neighbourhood of v
  have huv : T u v := hubeats v List.mem_cons_self
  refine ⟨⟨u, huv⟩, ?_, ?_⟩
  · intro hmem
    exact hunot (List.mem_cons_of_mem _ (List.mem_map_of_mem hmem))
  · intro s hs
    exact hubeats s.val (List.mem_cons_of_mem _ (List.mem_map_of_mem hs))

#print axioms inNbhd_hasS

end Erdos902InNbhd
