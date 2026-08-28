set_option maxRecDepth 100000

/-
The two doubly regular tournaments on 23 vertices that carry Schutte's property S_3.

McKay's catalogue `drtourn23.txt` lists 37 pairwise non-isomorphic doubly regular
tournaments of order 23.  Exactly two of them, rows 35 and 36, satisfy S_3.  This file
encodes those two as explicit bitmask tables and kernel-checks, for each:

  * the table really is a tournament, and the in- and out-masks agree  (`tournament_*`);
  * every out-degree is 11 and every pair of out-neighbourhoods meets in 5, so it is a
    doubly regular tournament with parameters (23, 11, 5)  (`outdeg_*`, `codeg_*`);
  * every 3-set has a dominator, i.e. it has S_3  (`s3_*`);
  * the number of 4-sets with no dominator is 2475 and 2530 respectively  (`bad4_*`).

Everything below is Lean 4 core, closed by `decide`.  Nothing here asserts anything about
f(4); the arithmetic that would use these counts is not in this file.  That every doubly
regular tournament of order 23 is isomorphic to one of McKay's 37 is an external
classification input, used nowhere in this file.
-/

namespace Erdos902DRT23

/-- Bit `i` of a mask. -/
def bit (m i : Nat) : Bool := Nat.testBit m i

/-- Population count, with fuel. -/
def pc : Nat -> Nat -> Nat
  | 0, _ => 0
  | f + 1, n => if n == 0 then 0 else n % 2 + pc f (n / 2)

def POP (x : Nat) : Nat := pc 40 x

def get (L : List Nat) (i : Nat) : Nat := L.getD i 0

/-- Number of 4-sets `a < b < c < d` whose in-masks have empty intersection: the 4-sets
with no dominator inside the tournament. -/
def bad4 (L : List Nat) : Nat :=
  ((List.range 23).map fun a =>
    (((List.range 23).drop (a + 1)).map fun b =>
      (((List.range 23).drop (b + 1)).map fun c =>
        (((List.range 23).drop (c + 1)).map fun d =>
          if (get L a &&& get L b &&& get L c &&& get L d) == 0 then 1 else 0).sum).sum).sum).sum

/-- Out-neighbourhood bitmasks of catalogue row 35. -/
def om35 : List Nat := [4094, 258172, 7674200, 3901232, 5860064, 5152324, 6483336, 7643694, 2939058, 3700038, 5185942, 1529482, 1877209, 1984813, 6886573, 2453013, 2503649, 5297045, 6963803, 3377351, 4572515, 5389363, 637707]
/-- In-neighbourhood bitmasks of catalogue row 35. -/
def im35 : List Nat := [8384512, 8130433, 714403, 4487367, 2528527, 3236251, 1905207, 744785, 5449293, 4688057, 3201641, 6857077, 6507302, 6395602, 1485650, 5902826, 5819422, 2960490, 1162660, 4486968, 2767516, 902092, 3556596]
/-- Out-neighbourhood bitmasks of catalogue row 36. -/
def om36 : List Nat := [4094, 258172, 8062168, 6728160, 5847848, 6872644, 1560336, 3953010, 3089958, 3512462, 5038746, 5404038, 1877325, 5587685, 6689565, 2714005, 941225, 3192497, 5933111, 3304011, 6407467, 4537427, 758723]
/-- In-neighbourhood bitmasks of catalogue row 36. -/
def im36 : List Nat := [8384512, 8130433, 326435, 1660439, 2540743, 1515931, 6828207, 4435469, 5298393, 4875633, 3348837, 2982521, 6507186, 2792730, 1682658, 5641834, 7381846, 5065038, 2193352, 4560308, 932564, 1754028, 3435580]

/-! ## Row 35 -/

/-- The table is a tournament: irreflexive, and exactly one of each pair of arcs. -/
theorem tournament_35 :
    ((List.range 23).all fun a => (List.range 23).all fun b =>
      if a == b then !(bit (get om35 a) b)
      else (bit (get om35 a) b) != (bit (get om35 b) a)) = true := by decide

/-- The in-masks are the transpose of the out-masks. -/
theorem transpose_35 :
    ((List.range 23).all fun a => (List.range 23).all fun b =>
      bit (get im35 b) a == bit (get om35 a) b) = true := by decide

/-- Every out-degree is 11. -/
theorem outdeg_35 :
    ((List.range 23).all fun a => POP (get om35 a) == 11) = true := by decide

/-- Every pair of out-neighbourhoods meets in exactly 5: doubly regular (23, 11, 5). -/
theorem codeg_35 :
    ((List.range 23).all fun a => ((List.range 23).drop (a + 1)).all fun b =>
      POP (get om35 a &&& get om35 b) == 5) = true := by decide

/-- Every 3-set has a dominator: the tournament has `S_3`. -/
theorem s3_35 :
    ((List.range 23).all fun a => ((List.range 23).drop (a + 1)).all fun b =>
      ((List.range 23).drop (b + 1)).all fun c =>
        !((get im35 a &&& get im35 b &&& get im35 c) == 0)) = true := by decide

/-! ## Row 36 -/

/-- The table is a tournament: irreflexive, and exactly one of each pair of arcs. -/
theorem tournament_36 :
    ((List.range 23).all fun a => (List.range 23).all fun b =>
      if a == b then !(bit (get om36 a) b)
      else (bit (get om36 a) b) != (bit (get om36 b) a)) = true := by decide

/-- The in-masks are the transpose of the out-masks. -/
theorem transpose_36 :
    ((List.range 23).all fun a => (List.range 23).all fun b =>
      bit (get im36 b) a == bit (get om36 a) b) = true := by decide

/-- Every out-degree is 11. -/
theorem outdeg_36 :
    ((List.range 23).all fun a => POP (get om36 a) == 11) = true := by decide

/-- Every pair of out-neighbourhoods meets in exactly 5: doubly regular (23, 11, 5). -/
theorem codeg_36 :
    ((List.range 23).all fun a => ((List.range 23).drop (a + 1)).all fun b =>
      POP (get om36 a &&& get om36 b) == 5) = true := by decide

/-- Every 3-set has a dominator: the tournament has `S_3`. -/
theorem s3_36 :
    ((List.range 23).all fun a => ((List.range 23).drop (a + 1)).all fun b =>
      ((List.range 23).drop (b + 1)).all fun c =>
        !((get im36 a &&& get im36 b &&& get im36 c) == 0)) = true := by decide

/-- Row 35 has exactly 2475 undominated 4-sets. -/
theorem bad4_35 : bad4 im35 = 2475 := by decide

/-- Row 36 has exactly 2530 undominated 4-sets. -/
theorem bad4_36 : bad4 im36 = 2530 := by decide

end Erdos902DRT23

#print axioms Erdos902DRT23.tournament_35
#print axioms Erdos902DRT23.outdeg_35
#print axioms Erdos902DRT23.codeg_35
#print axioms Erdos902DRT23.s3_35
#print axioms Erdos902DRT23.bad4_35
#print axioms Erdos902DRT23.tournament_36
#print axioms Erdos902DRT23.codeg_36
#print axioms Erdos902DRT23.s3_36
#print axioms Erdos902DRT23.bad4_36
