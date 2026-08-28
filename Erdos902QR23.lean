import Erdos902DRT23

/-!
An explicit certificate that McKay catalogue row 36 is the Paley tournament `QR_23`.

The list `row36ToQR23` is the independently supplied isomorphism from the catalogue
labels to `Z/23Z`.  Besides checking all 529 ordered pairs, this file checks two
affine-square automorphisms of `QR_23`:

* `x ↦ x + 1`, of order 23;
* `x ↦ 2x`, of order 11 (2 is a quadratic residue modulo 23).

Together these generate the standard affine-square subgroup of order `23 * 11 = 253`.
The declarations below only assert the finite facts they directly check; no capacity
bound or claim about `f(4)` is made here.
-/

set_option maxRecDepth 100000
set_option maxHeartbeats 1000000

namespace Erdos902QR23

open Erdos902DRT23

/-- Nonzero quadratic residues modulo 23. -/
def residues23 : List Nat := [1, 2, 3, 4, 6, 8, 9, 12, 13, 16, 18]

/-- The Paley orientation on representatives modulo 23. -/
def qrArc (x y : Nat) : Bool :=
  x % 23 != y % 23 && residues23.contains ((y % 23 + 23 - x % 23) % 23)

/-- Isomorphism from McKay row-36 labels to the standard `QR_23` labels. -/
def row36ToQR23 : List Nat :=
  [0, 1, 9, 2, 13, 3, 4, 18, 8, 16, 12, 6, 19, 14, 7, 5, 17, 10, 20, 21, 22, 11, 15]

def phi (x : Nat) : Nat := row36ToQR23.getD x 0

/-- Translation by one. -/
def translate (x : Nat) : Nat := (x + 1) % 23

/-- Multiplication by the square 2 modulo 23. -/
def double (x : Nat) : Nat := (2 * x) % 23

def iterate (f : Nat → Nat) : Nat → Nat → Nat
  | 0, x => x
  | n + 1, x => f (iterate f n x)

/-- The displayed residue list is exactly the set of nonzero squares modulo 23. -/
theorem residues23_exact :
    ((List.range 23).all fun x =>
      residues23.contains x == (x != 0 && (List.range 23).any fun y => (y * y) % 23 == x)) = true := by
  decide

/-- The explicit label map is a permutation of the 23 residues. -/
theorem row36ToQR23_permutation :
    row36ToQR23.length = 23 ∧ row36ToQR23.Nodup ∧
      ((List.range 23).all fun x => phi x < 23) = true := by
  decide

/-- Complete ordered-pair check of the row-36/Paley isomorphism. -/
theorem row36_is_QR23 :
    ((List.range 23).all fun x => (List.range 23).all fun y =>
      bit (get om36 x) y == qrArc (phi x) (phi y)) = true := by
  decide

/-- Translation by one permutes the vertices and preserves every Paley arc. -/
theorem translate_automorphism :
    (((List.range 23).map translate).Nodup) ∧
      (((List.range 23).all fun x => (List.range 23).all fun y =>
        qrArc (translate x) (translate y) == qrArc x y) = true) := by
  exact ⟨by decide, by decide⟩

/-- Multiplication by two permutes the vertices and preserves every Paley arc. -/
theorem double_automorphism :
    (((List.range 23).map double).Nodup) ∧
      (((List.range 23).all fun x => (List.range 23).all fun y =>
        qrArc (double x) (double y) == qrArc x y) = true) := by
  exact ⟨by decide, by decide⟩

/-- Translation has exact order 23 on the 23 vertices. -/
theorem translate_order_23 :
    ((List.range 23).all fun x => iterate translate 23 x == x) = true ∧
      ((List.range 22).all fun n => iterate translate (n + 1) 0 != 0) = true := by
  decide

/-- Multiplication by two has exact order 11 on the nonzero vertices. -/
theorem double_order_11 :
    ((List.range 23).all fun x => iterate double 11 x == x) = true ∧
      ((List.range 10).all fun n => iterate double (n + 1) 1 != 1) = true := by
  decide

/-! ## The full affine symmetry group

The two generators above generate the affine group `x ↦ 2^i * x + j` of order `11 * 23 = 253`.
`sq23` lists the eleven powers of `2`; they are exactly the eleven nonzero squares, which is
why every one of these maps preserves the Paley orientation. -/

/-- `2^i mod 23` for `i < 11`. -/
def sq23 : List Nat := [1, 2, 4, 8, 16, 9, 18, 13, 3, 6, 12]

/-- The affine map `x ↦ 2^i * x + j` on `Z/23`. -/
def aff (i j x : Nat) : Nat := (sq23.getD i 1 * x + j) % 23

/-- The powers of `2` are exactly the nonzero squares modulo 23, and they close at `i = 11`. -/
theorem sq23_exact :
    ((List.range 11).all fun i => residues23.contains (sq23.getD i 1)) = true
      && ((List.range 11).all fun i => (List.range 11).any fun j =>
            sq23.getD i 1 == sq23.getD j 1) = true
      && (residues23.all fun r => (List.range 11).any fun i => sq23.getD i 1 == r) = true := by
  decide

/-- Each affine map is a composition of the two generators: `aff i j = translate^j ∘ double^i`.
Arc preservation therefore follows from `translate_automorphism` and `double_automorphism`
without any further search. -/
theorem aff_eq_comp :
    ((List.range 11).all fun i => (List.range 23).all fun j =>
      (List.range 23).all fun x =>
        aff i j x == iterate translate j (iterate double i x)) = true := by
  decide

/-- The 253 affine maps are pairwise distinct: they already differ on the two points `0` and
`1`, so `QR_23` has at least `11 * 23 = 253` automorphisms. -/
theorem aff_distinct :
    (((List.range 253).map fun p =>
      (aff (p / 23) (p % 23) 0, aff (p / 23) (p % 23) 1)).Nodup) := by
  decide


end Erdos902QR23

#print axioms Erdos902QR23.row36_is_QR23
#print axioms Erdos902QR23.translate_automorphism
#print axioms Erdos902QR23.double_automorphism
#print axioms Erdos902QR23.translate_order_23
#print axioms Erdos902QR23.double_order_11
#print axioms Erdos902QR23.sq23_exact
#print axioms Erdos902QR23.aff_eq_comp
#print axioms Erdos902QR23.aff_distinct
