/-
Erdos 902 -- THE SIZE-11 MASK LAYER FOR ROW 35.

A mask `M` inside the 23-vertex core `H` is ADMISSIBLE when it meets every in-neighbourhood
of `H` in at most six vertices.  Write `a_h := |M n N^+(h)|`.  This file proves, for
catalogue row 35:

  every admissible 11-mask has some `h` with `a_h >= 10`.

`H` is 11-regular, so `a_h >= 10` says `M` agrees with the out-neighbourhood `N^+(h)` in all
but one vertex.  That is the size-11 analogue of `Erdos902DRT23Rigidity`, which pins the
size-12 layer to the closed out-neighbourhoods themselves.

It matters because of the elementary bound

  repair M  <=  C(|M|,4) - C(a_h,4)

(the `C(a_h,4)` four-subsets of `M n N^+(h)` are all dominated by `h`, hence not defects).
With `a_h >= 10` this gives `repair M <= 330 - 210 = 120` for every admissible 11-mask.

ENCODING.  The 23 counters `s_h = |M n N^-(h)|` are packed into one natural number, five
bits per counter, so adding a vertex is a single addition and the admissibility test is
`(s + KADD) &&& M8 == 0`: adding `KADD` raises every counter by one, and `M8` catches any
counter that reached eight.  `go` returns `true` exactly when the subtree below its argument
contains an admissible 11-mask with every `a_h <= 9`.  Each theorem below reports `false`.

CASE SPLIT.  An 11-subset of a 23-element set has a smallest element `i` and a second
smallest `j`.  Eleven elements must fit in `{i,...,22}`, so `i <= 12`; the remaining ten must
fit in `{j,...,22}`, so `j <= 13`.  The 91 pairs `i < j <= 13` therefore cover every
11-subset, and the 91 theorems below run one subtree each.  Splitting keeps each kernel
evaluation bounded; the whole search is about 1.53 million nodes.

The fuel argument 24 exceeds 23, which bounds the remaining depth of any subtree, so no
branch is cut short by exhausted fuel.
-/

import Erdos902DRT23

set_option maxRecDepth 10000
set_option maxHeartbeats 0

namespace Erdos902Layer11R35

open Erdos902DRT23

/-- `2^(5h)` summed over the 23 counters. -/
def KADD : Nat := 1339947576396084549298192601089057

/-- `2^(5h+3)` summed over the 23 counters. -/
def M8 : Nat := 10719580611168676394385540808712456

/-- `pk x` has a one in counter `h` exactly when `x` beats `h`. -/
def pk : List Nat := [37191016277640224, 39933549617176090472645632, 1339907923590204771328321574174720, 41872123821119682726091729928192, 1299381480525335609490428420685824, 1298115105378409674324173484196864, 1338639072565632929776304964796416, 1339907922419093588148579173696544, 40605671267560470830976766836768, 41872083890007341575557907219488, 1298115106549592265453739810227232, 1268928436001307767875024486432, 1308502659340473427608296521729, 1308541308331502269315940385793, 1338678649131194353811383438574593, 40566058357485968141544705754113, 40566095833006900342274368995329, 1299341865272895812975618209874945, 1338678686609074199473351805665313, 41832509739862585423943585236001, 1298075453821631536738203254915105, 1299341903919599447766603362467873, 39615327999966121116037054497]

/-- Counter `h` of a packed vector. -/
def fld (s h : Nat) : Nat := (s >>> (5 * h)) % 32

/-- The mask violates the conclusion: every `h` has `a_h <= 9`, i.e. `s_h + [h in M] >= 2`. -/
def allSmall (P s : Nat) : Bool :=
  (List.range 23).all fun h => 2 <= fld s h + (if Nat.testBit P h then 1 else 0)

/-- Depth-first search over the subtree below `(s, P, nxt, sz)`. -/
def go : Nat -> Nat -> Nat -> Nat -> Nat -> Bool
  | 0, _, _, _, _ => false
  | fuel + 1, s, P, nxt, sz =>
      if (s + KADD) &&& M8 != 0 then false
      else if sz == 11 then allSmall P s
      else if 23 < nxt + (11 - sz) then false
      else go fuel (s + pk.getD nxt 0) (P ||| (1 <<< nxt)) (nxt + 1) (sz + 1)
        || go fuel s P (nxt + 1) sz

/-- Start of the subtree whose two smallest mask elements are `i` and `j`. -/
def start (i j : Nat) : Bool :=
  go 24 (pk.getD i 0 + pk.getD j 0) ((1 <<< i) ||| (1 <<< j)) (j + 1) 2

theorem piece_0_1 : start 0 1 = false := by decide
theorem piece_0_2 : start 0 2 = false := by decide
theorem piece_0_3 : start 0 3 = false := by decide
theorem piece_0_4 : start 0 4 = false := by decide
theorem piece_0_5 : start 0 5 = false := by decide
theorem piece_0_6 : start 0 6 = false := by decide
theorem piece_0_7 : start 0 7 = false := by decide
theorem piece_0_8 : start 0 8 = false := by decide
theorem piece_0_9 : start 0 9 = false := by decide
theorem piece_0_10 : start 0 10 = false := by decide
theorem piece_0_11 : start 0 11 = false := by decide
theorem piece_0_12 : start 0 12 = false := by decide
theorem piece_0_13 : start 0 13 = false := by decide
theorem piece_1_2 : start 1 2 = false := by decide
theorem piece_1_3 : start 1 3 = false := by decide
theorem piece_1_4 : start 1 4 = false := by decide
theorem piece_1_5 : start 1 5 = false := by decide
theorem piece_1_6 : start 1 6 = false := by decide
theorem piece_1_7 : start 1 7 = false := by decide
theorem piece_1_8 : start 1 8 = false := by decide
theorem piece_1_9 : start 1 9 = false := by decide
theorem piece_1_10 : start 1 10 = false := by decide
theorem piece_1_11 : start 1 11 = false := by decide
theorem piece_1_12 : start 1 12 = false := by decide
theorem piece_1_13 : start 1 13 = false := by decide
theorem piece_2_3 : start 2 3 = false := by decide
theorem piece_2_4 : start 2 4 = false := by decide
theorem piece_2_5 : start 2 5 = false := by decide
theorem piece_2_6 : start 2 6 = false := by decide
theorem piece_2_7 : start 2 7 = false := by decide
theorem piece_2_8 : start 2 8 = false := by decide
theorem piece_2_9 : start 2 9 = false := by decide
theorem piece_2_10 : start 2 10 = false := by decide
theorem piece_2_11 : start 2 11 = false := by decide
theorem piece_2_12 : start 2 12 = false := by decide
theorem piece_2_13 : start 2 13 = false := by decide
theorem piece_3_4 : start 3 4 = false := by decide
theorem piece_3_5 : start 3 5 = false := by decide
theorem piece_3_6 : start 3 6 = false := by decide
theorem piece_3_7 : start 3 7 = false := by decide
theorem piece_3_8 : start 3 8 = false := by decide
theorem piece_3_9 : start 3 9 = false := by decide
theorem piece_3_10 : start 3 10 = false := by decide
theorem piece_3_11 : start 3 11 = false := by decide
theorem piece_3_12 : start 3 12 = false := by decide
theorem piece_3_13 : start 3 13 = false := by decide
theorem piece_4_5 : start 4 5 = false := by decide
theorem piece_4_6 : start 4 6 = false := by decide
theorem piece_4_7 : start 4 7 = false := by decide
theorem piece_4_8 : start 4 8 = false := by decide
theorem piece_4_9 : start 4 9 = false := by decide
theorem piece_4_10 : start 4 10 = false := by decide
theorem piece_4_11 : start 4 11 = false := by decide
theorem piece_4_12 : start 4 12 = false := by decide
theorem piece_4_13 : start 4 13 = false := by decide
theorem piece_5_6 : start 5 6 = false := by decide
theorem piece_5_7 : start 5 7 = false := by decide
theorem piece_5_8 : start 5 8 = false := by decide
theorem piece_5_9 : start 5 9 = false := by decide
theorem piece_5_10 : start 5 10 = false := by decide
theorem piece_5_11 : start 5 11 = false := by decide
theorem piece_5_12 : start 5 12 = false := by decide
theorem piece_5_13 : start 5 13 = false := by decide
theorem piece_6_7 : start 6 7 = false := by decide
theorem piece_6_8 : start 6 8 = false := by decide
theorem piece_6_9 : start 6 9 = false := by decide
theorem piece_6_10 : start 6 10 = false := by decide
theorem piece_6_11 : start 6 11 = false := by decide
theorem piece_6_12 : start 6 12 = false := by decide
theorem piece_6_13 : start 6 13 = false := by decide
theorem piece_7_8 : start 7 8 = false := by decide
theorem piece_7_9 : start 7 9 = false := by decide
theorem piece_7_10 : start 7 10 = false := by decide
theorem piece_7_11 : start 7 11 = false := by decide
theorem piece_7_12 : start 7 12 = false := by decide
theorem piece_7_13 : start 7 13 = false := by decide
theorem piece_8_9 : start 8 9 = false := by decide
theorem piece_8_10 : start 8 10 = false := by decide
theorem piece_8_11 : start 8 11 = false := by decide
theorem piece_8_12 : start 8 12 = false := by decide
theorem piece_8_13 : start 8 13 = false := by decide
theorem piece_9_10 : start 9 10 = false := by decide
theorem piece_9_11 : start 9 11 = false := by decide
theorem piece_9_12 : start 9 12 = false := by decide
theorem piece_9_13 : start 9 13 = false := by decide
theorem piece_10_11 : start 10 11 = false := by decide
theorem piece_10_12 : start 10 12 = false := by decide
theorem piece_10_13 : start 10 13 = false := by decide
theorem piece_11_12 : start 11 12 = false := by decide
theorem piece_11_13 : start 11 13 = false := by decide
theorem piece_12_13 : start 12 13 = false := by decide

end Erdos902Layer11R35

#print axioms Erdos902Layer11R35.piece_0_1
#print axioms Erdos902Layer11R35.piece_6_7
#print axioms Erdos902Layer11R35.piece_12_13
