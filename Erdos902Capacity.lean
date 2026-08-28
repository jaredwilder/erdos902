/-
Erdos 902 -- REPAIR CAPACITY OF THE TOP MASK LAYERS OF THE TWO S_3 DRT(23) ROWS.

Setting.  `Erdos902F4Step` reduces a hypothetical 48-vertex `S_4` tournament to a 23-vertex
in-neighbourhood `H` that is doubly regular (23, 11, 5) and carries `S_3`, and shows every
outside vertex `x` meets `H` in a mask `W_x` with `|W_x| <= 12` and `|W_x n N^-(h)| <= 6`
for every `h`.  Call such a mask ADMISSIBLE.  The REPAIR CAPACITY of a mask is the number of
4-subsets of it that have no dominator inside `H`.

`Erdos902DRT23Rigidity` shows every admissible mask of size 12 is a closed out-neighbourhood
`C_a = {a} u N^+(a)`.  This file computes the capacities of the top two layers for both
catalogue rows, by `decide`:

  size 12, `C_a`                     row 36: 66 everywhere;  row 35: at most 65
  size 11, centre deleted, `N^+(a)`   both rows: 0
  size 11, arc deleted, `C_a \ {z}`  row 36: 48 everywhere;  row 35: at most 48

For row 36 the three values are constant across the layer, which is what the affine group of
`Erdos902QR23` predicts: the closed out-neighbourhoods form one orbit, and so do the 253
arc-deletions.  Row 36 has no other admissible 11-masks.  Row 35 has 33 admissible 11-masks
lying in no closed out-neighbourhood; they are listed here and their capacities are at most 50.

That the listed 33 are ALL of them is a computation not carried out in this file, and no claim
about `f 4` is made anywhere here.
-/

import Erdos902DRT23

set_option maxRecDepth 100000
set_option maxHeartbeats 1000000

namespace Erdos902Capacity

open Erdos902DRT23

/-- The vertices of a mask. -/
def elems (m : Nat) : List Nat := (List.range 23).filter (fun i => Nat.testBit m i)

/-- Repair capacity: the number of 4-subsets of the mask with no dominator inside `H`. -/
def repair (L : List Nat) (m : Nat) : Nat :=
  let e := elems m
  let N := e.length
  (((List.range N).map fun i =>
    (((List.range N).drop (i + 1)).map fun j =>
      (((List.range N).drop (j + 1)).map fun k =>
        (((List.range N).drop (k + 1)).map fun l =>
          if (get L (e.getD i 0) &&& get L (e.getD j 0) &&& get L (e.getD k 0)
                &&& get L (e.getD l 0)) == 0 then 1 else 0).sum).sum).sum).sum)

/-- The closed out-neighbourhood `C_a = {a} u N^+(a)`. -/
def closedOut (Lout : List Nat) (a : Nat) : Nat := (1 <<< a) ||| get Lout a

/-! ## Row 36 (= QR_23).  All three layer values are constant. -/

theorem repair_closedOut_36 :
    ((List.range 23).all fun a => repair im36 (closedOut om36 a) == 66) = true := by decide

theorem repair_centreDeleted_36 :
    ((List.range 23).all fun a => repair im36 (get om36 a) == 0) = true := by decide

theorem repair_arcDeleted_36 :
    ((List.range 23).all fun a => (List.range 23).all fun z =>
      !(bit (get om36 a) z) || (repair im36 (closedOut om36 a - (1 <<< z)) == 48)) = true := by
  decide

/-! ## Row 35.  The same layers, now only bounded. -/

theorem repair_closedOut_35 :
    ((List.range 23).all fun a => repair im35 (closedOut om35 a) <= 65) = true := by decide

theorem repair_centreDeleted_35 :
    ((List.range 23).all fun a => repair im35 (get om35 a) == 0) = true := by decide

theorem repair_arcDeleted_35 :
    ((List.range 23).all fun a => (List.range 23).all fun z =>
      !(bit (get om35 a) z) || (repair im35 (closedOut om35 a - (1 <<< z)) <= 48)) = true := by
  decide

/-- The 33 admissible 11-masks of row 35 that lie in no closed out-neighbourhood. -/
def exceptional35 : List Nat := [258676, 528374, 1195067, 1529730, 1942737, 2017573, 2444829, 2499561, 2734851, 2937018, 3114800, 3376945, 3377358, 3700044, 3786544, 3839792, 3876656, 3900336, 3900722, 3901204, 3901280, 3903024, 4310379, 5152328, 5185822, 5280669, 5860008, 5998384, 6483344, 7017637, 7644710, 7674224, 8012371]

theorem exceptional35_card : exceptional35.length = 33 := by decide

theorem exceptional35_size :
    (exceptional35.all fun m => (elems m).length == 11) = true := by decide

/-- Each exceptional mask is admissible: at most 12 vertices, and it meets every
in-neighbourhood in at most six. -/
theorem exceptional35_admissible :
    (exceptional35.all fun m =>
      (List.range 23).all fun h => POP (m &&& get im35 h) <= 6) = true := by decide

/-- None of them lies in a closed out-neighbourhood. -/
theorem exceptional35_not_contained :
    (exceptional35.all fun m =>
      (List.range 23).all fun a => !((m &&& closedOut om35 a) == m)) = true := by decide

/-- Their capacities are at most 50, well under the 65 of the size-12 layer. -/
theorem repair_exceptional35 :
    (exceptional35.all fun m => repair im35 m <= 50) = true := by decide

/-! ## The arithmetic these values feed. -/

/-- With every outside mask obeying `R(W) <= 66 + 72 * (12 - |W|)` and the outside deficit
budget `sum (12 - |W_x|) <= 12` over 24 vertices, the total repair available is at most
`24 * 66 + 72 * 12`, which is below both defect counts. -/
theorem envelope_arithmetic :
    24 * 66 + 72 * 12 = 2448 ∧ 2448 < 2475 ∧ 2448 < 2530 := by decide

end Erdos902Capacity

#print axioms Erdos902Capacity.repair_closedOut_36
#print axioms Erdos902Capacity.repair_centreDeleted_36
#print axioms Erdos902Capacity.repair_arcDeleted_36
#print axioms Erdos902Capacity.repair_closedOut_35
#print axioms Erdos902Capacity.repair_arcDeleted_35
#print axioms Erdos902Capacity.exceptional35_not_contained
#print axioms Erdos902Capacity.repair_exceptional35
#print axioms Erdos902Capacity.envelope_arithmetic
