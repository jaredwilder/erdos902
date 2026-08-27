import Erdos902QR67Base

private def qr67Witness_2_0 : Array Nat := #[5,13,5,5,7,7,5,20,7,5,13,5,20,7,5,5,7,7,20,5,5,5,5,7,5,30,5,5,5,5,5,5,7,7,5,13,7,13,5,13,5,5,5,7,5,5,7,7,13,13,13,30,5,13,5,20,7,20,32,5,5,5,7,7,5,5,7]
private def qr67Witness_2_0At (d : F67) : F67 :=
  (qr67Witness_2_0.getD d.val 0 : Nat)
private theorem qr67Witness_2_0_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_0At d) 0 ∧ qr67Z (qr67Witness_2_0At d) 2 ∧
    qr67Z (qr67Witness_2_0At d) 0 ∧ qr67Z (qr67Witness_2_0At d) d := by
  decide

private def qr67Witness_2_1 : Array Nat := #[13,13,13,44,32,13,13,45,13,43,13,13,32,43,13,43,43,13,45,13,32,32,13,13,32,32,44,13,13,13,13,43,13,32,13,13,13,13,13,13,43,32,13,45,43,44,13,32,13,13,13,32,13,13,32,32,32,32,32,43,13,32,13,44,43,32,43]
private def qr67Witness_2_1At (d : F67) : F67 :=
  (qr67Witness_2_1.getD d.val 0 : Nat)
private theorem qr67Witness_2_1_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_1At d) 0 ∧ qr67Z (qr67Witness_2_1At d) 2 ∧
    qr67Z (qr67Witness_2_1At d) 1 ∧ qr67Z (qr67Witness_2_1At d) d := by
  decide

private def qr67Witness_2_2 : Array Nat := #[5,13,5,5,7,7,5,20,7,5,13,5,20,7,5,5,7,7,20,5,5,5,5,7,5,30,5,5,5,5,5,5,7,7,5,13,7,13,5,13,5,5,5,7,5,5,7,7,13,13,13,30,5,13,5,20,7,20,32,5,5,5,7,7,5,5,7]
private def qr67Witness_2_2At (d : F67) : F67 :=
  (qr67Witness_2_2.getD d.val 0 : Nat)
private theorem qr67Witness_2_2_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_2At d) 0 ∧ qr67Z (qr67Witness_2_2At d) 2 ∧
    qr67Z (qr67Witness_2_2At d) 2 ∧ qr67Z (qr67Witness_2_2At d) d := by
  decide

private def qr67Witness_2_3 : Array Nat := #[5,44,5,5,34,46,5,34,46,5,30,5,30,44,5,5,34,30,30,5,5,5,5,30,5,30,5,5,5,5,5,5,34,44,5,34,30,44,5,30,5,5,5,34,5,5,30,30,34,30,34,30,5,30,5,30,30,34,34,5,5,5,45,30,5,5,30]
private def qr67Witness_2_3At (d : F67) : F67 :=
  (qr67Witness_2_3.getD d.val 0 : Nat)
private theorem qr67Witness_2_3_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_3At d) 0 ∧ qr67Z (qr67Witness_2_3At d) 2 ∧
    qr67Z (qr67Witness_2_3At d) 3 ∧ qr67Z (qr67Witness_2_3At d) d := by
  decide

private def qr67Witness_2_4 : Array Nat := #[7,32,7,34,7,7,34,34,7,50,48,7,32,7,32,45,7,7,45,32,32,7,7,7,7,32,7,32,7,7,7,7,7,7,45,34,7,45,32,46,7,32,7,7,7,48,7,7,32,32,34,32,46,32,7,32,7,32,32,34,34,7,7,7,45,32,7]
private def qr67Witness_2_4At (d : F67) : F67 :=
  (qr67Witness_2_4.getD d.val 0 : Nat)
private theorem qr67Witness_2_4_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_4At d) 0 ∧ qr67Z (qr67Witness_2_4At d) 2 ∧
    qr67Z (qr67Witness_2_4At d) 4 ∧ qr67Z (qr67Witness_2_4At d) d := by
  decide

private def qr67Witness_2_5 : Array Nat := #[7,13,7,46,7,7,13,48,7,43,13,7,32,7,13,43,7,7,46,13,32,7,7,7,7,32,7,13,7,7,7,7,7,7,13,13,7,13,13,13,7,32,7,7,7,48,7,7,13,13,13,32,13,13,7,32,7,32,32,43,13,7,7,7,43,32,7]
private def qr67Witness_2_5At (d : F67) : F67 :=
  (qr67Witness_2_5.getD d.val 0 : Nat)
private theorem qr67Witness_2_5_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_5At d) 0 ∧ qr67Z (qr67Witness_2_5At d) 2 ∧
    qr67Z (qr67Witness_2_5At d) 5 ∧ qr67Z (qr67Witness_2_5At d) d := by
  decide

private def qr67Witness_2_6 : Array Nat := #[5,13,5,5,34,13,5,34,13,5,13,5,44,44,5,5,34,13,48,5,5,5,5,13,5,52,5,5,5,5,5,5,13,44,5,13,13,13,5,13,5,5,5,34,5,5,13,50,13,13,13,34,5,13,5,34,34,34,34,5,5,5,13,34,5,5,44]
private def qr67Witness_2_6At (d : F67) : F67 :=
  (qr67Witness_2_6.getD d.val 0 : Nat)
private theorem qr67Witness_2_6_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_6At d) 0 ∧ qr67Z (qr67Witness_2_6At d) 2 ∧
    qr67Z (qr67Witness_2_6At d) 6 ∧ qr67Z (qr67Witness_2_6At d) d := by
  decide

private def qr67Witness_2_7 : Array Nat := #[20,45,20,34,34,48,34,20,20,20,48,45,20,20,34,20,34,20,20,50,48,20,34,34,20,45,20,34,48,20,20,34,34,45,20,20,20,20,34,20,34,20,20,20,20,20,20,50,34,20,34,34,48,20,45,20,20,20,34,20,20,45,45,34,45,48,45]
private def qr67Witness_2_7At (d : F67) : F67 :=
  (qr67Witness_2_7.getD d.val 0 : Nat)
private theorem qr67Witness_2_7_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_7At d) 0 ∧ qr67Z (qr67Witness_2_7At d) 2 ∧
    qr67Z (qr67Witness_2_7At d) 7 ∧ qr67Z (qr67Witness_2_7At d) d := by
  decide

private def qr67Witness_2_8 : Array Nat := #[7,13,7,46,7,7,13,20,7,20,13,7,20,7,13,20,7,7,20,13,50,7,7,7,7,52,7,13,7,7,7,7,7,7,13,13,7,13,13,13,7,20,7,7,7,20,7,7,13,13,13,50,13,13,7,20,7,20,52,20,13,7,7,7,50,46,7]
private def qr67Witness_2_8At (d : F67) : F67 :=
  (qr67Witness_2_8.getD d.val 0 : Nat)
private theorem qr67Witness_2_8_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_8At d) 0 ∧ qr67Z (qr67Witness_2_8At d) 2 ∧
    qr67Z (qr67Witness_2_8At d) 8 ∧ qr67Z (qr67Witness_2_8At d) d := by
  decide

private def qr67Witness_2_9 : Array Nat := #[5,43,5,5,50,43,5,20,20,5,52,5,20,20,5,5,43,20,20,5,5,5,5,43,5,43,5,5,5,5,5,5,43,53,5,20,20,20,5,20,5,5,5,20,5,5,20,43,50,20,52,50,5,20,5,20,20,20,43,5,5,5,43,53,5,5,43]
private def qr67Witness_2_9At (d : F67) : F67 :=
  (qr67Witness_2_9.getD d.val 0 : Nat)
private theorem qr67Witness_2_9_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_9At d) 0 ∧ qr67Z (qr67Witness_2_9At d) 2 ∧
    qr67Z (qr67Witness_2_9At d) 9 ∧ qr67Z (qr67Witness_2_9At d) d := by
  decide

private def qr67Witness_2_10 : Array Nat := #[13,13,13,30,48,13,13,48,13,52,13,13,30,44,13,53,44,13,30,13,48,48,13,13,44,30,44,13,13,13,13,30,13,44,13,13,13,13,13,13,30,44,13,48,30,30,13,30,13,13,13,30,13,13,30,30,30,48,44,30,13,44,13,30,48,30,30]
private def qr67Witness_2_10At (d : F67) : F67 :=
  (qr67Witness_2_10.getD d.val 0 : Nat)
private theorem qr67Witness_2_10_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_10At d) 0 ∧ qr67Z (qr67Witness_2_10At d) 2 ∧
    qr67Z (qr67Witness_2_10At d) 10 ∧ qr67Z (qr67Witness_2_10At d) d := by
  decide

private def qr67Witness_2_11 : Array Nat := #[5,13,5,5,7,7,5,45,7,5,13,5,43,7,5,5,7,7,45,5,5,5,5,7,5,43,5,5,5,5,5,5,7,7,5,13,7,13,5,13,5,5,5,7,5,5,7,7,13,13,13,45,5,13,5,45,7,43,43,5,5,5,7,7,5,5,7]
private def qr67Witness_2_11At (d : F67) : F67 :=
  (qr67Witness_2_11.getD d.val 0 : Nat)
private theorem qr67Witness_2_11_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_11At d) 0 ∧ qr67Z (qr67Witness_2_11At d) 2 ∧
    qr67Z (qr67Witness_2_11At d) 11 ∧ qr67Z (qr67Witness_2_11At d) d := by
  decide

private def qr67Witness_2_12 : Array Nat := #[20,32,20,30,32,32,44,20,20,20,30,43,20,20,32,20,43,20,20,30,32,20,30,30,20,30,20,30,30,20,20,30,43,32,20,20,20,20,32,20,30,20,20,20,20,20,20,30,32,20,44,30,30,20,30,20,20,20,32,20,20,32,43,30,43,30,30]
private def qr67Witness_2_12At (d : F67) : F67 :=
  (qr67Witness_2_12.getD d.val 0 : Nat)
private theorem qr67Witness_2_12_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_12At d) 0 ∧ qr67Z (qr67Witness_2_12At d) 2 ∧
    qr67Z (qr67Witness_2_12At d) 12 ∧ qr67Z (qr67Witness_2_12At d) d := by
  decide

private def qr67Witness_2_13 : Array Nat := #[7,43,7,44,7,7,44,20,7,20,44,7,20,7,44,20,7,7,20,63,63,7,7,7,7,43,7,45,7,7,7,7,7,7,20,20,7,20,43,20,7,20,7,7,7,20,7,7,44,20,44,45,43,20,7,20,7,20,43,20,20,7,7,7,43,43,7]
private def qr67Witness_2_13At (d : F67) : F67 :=
  (qr67Witness_2_13.getD d.val 0 : Nat)
private theorem qr67Witness_2_13_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_13At d) 0 ∧ qr67Z (qr67Witness_2_13At d) 2 ∧
    qr67Z (qr67Witness_2_13At d) 13 ∧ qr67Z (qr67Witness_2_13At d) d := by
  decide

private def qr67Witness_2_14 : Array Nat := #[5,13,5,5,32,13,5,34,13,5,13,5,32,44,5,5,34,13,45,5,5,5,5,13,5,32,5,5,5,5,5,5,13,32,5,13,13,13,5,13,5,5,5,34,5,5,13,32,13,13,13,32,5,13,5,32,32,32,32,5,5,5,13,34,5,5,44]
private def qr67Witness_2_14At (d : F67) : F67 :=
  (qr67Witness_2_14.getD d.val 0 : Nat)
private theorem qr67Witness_2_14_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_14At d) 0 ∧ qr67Z (qr67Witness_2_14At d) 2 ∧
    qr67Z (qr67Witness_2_14At d) 14 ∧ qr67Z (qr67Witness_2_14At d) d := by
  decide

private def qr67Witness_2_15 : Array Nat := #[5,43,5,5,45,43,5,20,20,5,53,5,20,20,5,5,43,20,20,5,5,5,5,43,5,43,5,5,5,5,5,5,43,45,5,20,20,20,5,20,5,5,5,20,5,5,20,43,53,20,46,45,5,20,5,20,20,20,43,5,5,5,43,46,5,5,43]
private def qr67Witness_2_15At (d : F67) : F67 :=
  (qr67Witness_2_15.getD d.val 0 : Nat)
private theorem qr67Witness_2_15_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_15At d) 0 ∧ qr67Z (qr67Witness_2_15At d) 2 ∧
    qr67Z (qr67Witness_2_15At d) 15 ∧ qr67Z (qr67Witness_2_15At d) d := by
  decide

private def qr67Witness_2_16 : Array Nat := #[7,43,7,34,7,7,34,34,7,43,44,7,43,7,34,43,7,7,46,46,48,7,7,7,7,43,7,34,7,7,7,7,7,7,46,34,7,44,34,44,7,43,7,7,7,44,7,7,34,34,34,34,43,34,7,34,7,34,34,34,34,7,7,7,43,43,7]
private def qr67Witness_2_16At (d : F67) : F67 :=
  (qr67Witness_2_16.getD d.val 0 : Nat)
private theorem qr67Witness_2_16_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_16At d) 0 ∧ qr67Z (qr67Witness_2_16At d) 2 ∧
    qr67Z (qr67Witness_2_16At d) 16 ∧ qr67Z (qr67Witness_2_16At d) d := by
  decide

private def qr67Witness_2_17 : Array Nat := #[7,13,7,30,7,7,13,20,7,20,13,7,20,7,13,20,7,7,20,13,48,7,7,7,7,30,7,13,7,7,7,7,7,7,13,13,7,13,13,13,7,20,7,7,7,20,7,7,13,13,13,30,13,13,7,20,7,20,44,20,13,7,7,7,45,30,7]
private def qr67Witness_2_17At (d : F67) : F67 :=
  (qr67Witness_2_17.getD d.val 0 : Nat)
private theorem qr67Witness_2_17_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_17At d) 0 ∧ qr67Z (qr67Witness_2_17At d) 2 ∧
    qr67Z (qr67Witness_2_17At d) 17 ∧ qr67Z (qr67Witness_2_17At d) d := by
  decide

private def qr67Witness_2_18 : Array Nat := #[20,45,20,30,45,46,48,20,20,20,30,45,20,20,45,20,46,20,20,30,48,20,30,30,20,30,20,30,30,20,20,30,45,45,20,20,20,20,45,20,30,20,20,20,20,20,20,30,50,20,46,30,30,20,30,20,20,20,48,20,20,45,45,30,45,30,30]
private def qr67Witness_2_18At (d : F67) : F67 :=
  (qr67Witness_2_18.getD d.val 0 : Nat)
private theorem qr67Witness_2_18_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_18At d) 0 ∧ qr67Z (qr67Witness_2_18At d) 2 ∧
    qr67Z (qr67Witness_2_18At d) 18 ∧ qr67Z (qr67Witness_2_18At d) d := by
  decide

private def qr67Witness_2_19 : Array Nat := #[5,13,5,5,32,13,5,50,13,5,13,5,30,63,5,5,46,13,30,5,5,5,5,13,5,30,5,5,5,5,5,5,13,32,5,13,13,13,5,13,5,5,5,46,5,5,13,30,13,13,13,30,5,13,5,30,30,32,32,5,5,5,13,30,5,5,30]
private def qr67Witness_2_19At (d : F67) : F67 :=
  (qr67Witness_2_19.getD d.val 0 : Nat)
private theorem qr67Witness_2_19_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_19At d) 0 ∧ qr67Z (qr67Witness_2_19At d) 2 ∧
    qr67Z (qr67Witness_2_19At d) 19 ∧ qr67Z (qr67Witness_2_19At d) d := by
  decide

private def qr67Witness_2_20 : Array Nat := #[5,32,5,5,32,32,5,48,50,5,48,5,32,63,5,5,48,48,48,5,5,5,5,50,5,32,5,5,5,5,5,5,50,32,5,48,32,48,5,50,5,5,5,48,5,5,32,32,32,32,52,32,5,32,5,32,32,32,32,5,5,5,48,48,5,5,50]
private def qr67Witness_2_20At (d : F67) : F67 :=
  (qr67Witness_2_20.getD d.val 0 : Nat)
private theorem qr67Witness_2_20_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_20At d) 0 ∧ qr67Z (qr67Witness_2_20At d) 2 ∧
    qr67Z (qr67Witness_2_20At d) 20 ∧ qr67Z (qr67Witness_2_20At d) d := by
  decide

private def qr67Witness_2_21 : Array Nat := #[5,32,5,5,7,7,5,20,7,5,48,5,20,7,5,5,7,7,20,5,5,5,5,7,5,32,5,5,5,5,5,5,7,7,5,20,7,20,5,20,5,5,5,7,5,5,7,7,32,20,34,32,5,20,5,20,7,20,32,5,5,5,7,7,5,5,7]
private def qr67Witness_2_21At (d : F67) : F67 :=
  (qr67Witness_2_21.getD d.val 0 : Nat)
private theorem qr67Witness_2_21_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_21At d) 0 ∧ qr67Z (qr67Witness_2_21At d) 2 ∧
    qr67Z (qr67Witness_2_21At d) 21 ∧ qr67Z (qr67Witness_2_21At d) d := by
  decide

private def qr67Witness_2_22 : Array Nat := #[5,13,5,5,7,7,5,34,7,5,13,5,30,7,5,5,7,7,30,5,5,5,5,7,5,30,5,5,5,5,5,5,7,7,5,13,7,13,5,13,5,5,5,7,5,5,7,7,13,13,13,30,5,13,5,30,7,34,34,5,5,5,7,7,5,5,7]
private def qr67Witness_2_22At (d : F67) : F67 :=
  (qr67Witness_2_22.getD d.val 0 : Nat)
private theorem qr67Witness_2_22_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_22At d) 0 ∧ qr67Z (qr67Witness_2_22At d) 2 ∧
    qr67Z (qr67Witness_2_22At d) 22 ∧ qr67Z (qr67Witness_2_22At d) d := by
  decide

private def qr67Witness_2_23 : Array Nat := #[7,13,7,30,7,7,13,34,7,43,13,7,30,7,13,43,7,7,30,13,50,7,7,7,7,30,7,13,7,7,7,7,7,7,13,13,7,13,13,13,7,43,7,7,7,30,7,7,13,13,13,30,13,13,7,30,7,34,34,30,13,7,7,7,43,30,7]
private def qr67Witness_2_23At (d : F67) : F67 :=
  (qr67Witness_2_23.getD d.val 0 : Nat)
private theorem qr67Witness_2_23_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_23At d) 0 ∧ qr67Z (qr67Witness_2_23At d) 2 ∧
    qr67Z (qr67Witness_2_23At d) 23 ∧ qr67Z (qr67Witness_2_23At d) d := by
  decide

private def qr67Witness_2_24 : Array Nat := #[5,32,5,5,7,7,5,20,7,5,44,5,20,7,5,5,7,7,20,5,5,5,5,7,5,32,5,5,5,5,5,5,7,7,5,20,7,20,5,20,5,5,5,7,5,5,7,7,32,20,44,32,5,20,5,20,7,20,32,5,5,5,7,7,5,5,7]
private def qr67Witness_2_24At (d : F67) : F67 :=
  (qr67Witness_2_24.getD d.val 0 : Nat)
private theorem qr67Witness_2_24_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_24At d) 0 ∧ qr67Z (qr67Witness_2_24At d) 2 ∧
    qr67Z (qr67Witness_2_24At d) 24 ∧ qr67Z (qr67Witness_2_24At d) d := by
  decide

private def qr67Witness_2_25 : Array Nat := #[30,32,30,30,32,32,52,45,52,43,30,43,30,43,32,43,43,30,30,30,32,32,30,30,32,30,53,30,30,32,32,30,43,32,30,43,30,45,32,30,30,32,32,45,30,30,30,30,32,30,52,30,30,30,30,30,30,32,32,30,43,32,43,30,43,30,30]
private def qr67Witness_2_25At (d : F67) : F67 :=
  (qr67Witness_2_25.getD d.val 0 : Nat)
private theorem qr67Witness_2_25_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_25At d) 0 ∧ qr67Z (qr67Witness_2_25At d) 2 ∧
    qr67Z (qr67Witness_2_25At d) 25 ∧ qr67Z (qr67Witness_2_25At d) d := by
  decide

private def qr67Witness_2_26 : Array Nat := #[5,44,5,5,7,7,5,20,7,5,44,5,20,7,5,5,7,7,20,5,5,5,5,7,5,53,5,5,5,5,5,5,7,7,5,20,7,20,5,20,5,5,5,7,5,5,7,7,34,20,34,34,5,20,5,20,7,20,34,5,5,5,7,7,5,5,7]
private def qr67Witness_2_26At (d : F67) : F67 :=
  (qr67Witness_2_26.getD d.val 0 : Nat)
private theorem qr67Witness_2_26_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_26At d) 0 ∧ qr67Z (qr67Witness_2_26At d) 2 ∧
    qr67Z (qr67Witness_2_26At d) 26 ∧ qr67Z (qr67Witness_2_26At d) d := by
  decide

private def qr67Witness_2_27 : Array Nat := #[5,13,5,5,32,13,5,34,13,5,13,5,30,45,5,5,34,13,30,5,5,5,5,13,5,30,5,5,5,5,5,5,13,32,5,13,13,13,5,13,5,5,5,34,5,5,13,30,13,13,13,30,5,13,5,30,30,32,32,5,5,5,13,30,5,5,30]
private def qr67Witness_2_27At (d : F67) : F67 :=
  (qr67Witness_2_27.getD d.val 0 : Nat)
private theorem qr67Witness_2_27_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_27At d) 0 ∧ qr67Z (qr67Witness_2_27At d) 2 ∧
    qr67Z (qr67Witness_2_27At d) 27 ∧ qr67Z (qr67Witness_2_27At d) d := by
  decide

private def qr67Witness_2_28 : Array Nat := #[5,13,5,5,7,7,5,48,7,5,13,5,30,7,5,5,7,7,30,5,5,5,5,7,5,30,5,5,5,5,5,5,7,7,5,13,7,13,5,13,5,5,5,7,5,5,7,7,13,13,13,30,5,13,5,30,7,48,48,5,5,5,7,7,5,5,7]
private def qr67Witness_2_28At (d : F67) : F67 :=
  (qr67Witness_2_28.getD d.val 0 : Nat)
private theorem qr67Witness_2_28_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_28At d) 0 ∧ qr67Z (qr67Witness_2_28At d) 2 ∧
    qr67Z (qr67Witness_2_28At d) 28 ∧ qr67Z (qr67Witness_2_28At d) d := by
  decide

private def qr67Witness_2_29 : Array Nat := #[5,13,5,5,7,7,5,20,7,5,13,5,20,7,5,5,7,7,20,5,5,5,5,7,5,32,5,5,5,5,5,5,7,7,5,13,7,13,5,13,5,5,5,7,5,5,7,7,13,13,13,32,5,13,5,20,7,20,32,5,5,5,7,7,5,5,7]
private def qr67Witness_2_29At (d : F67) : F67 :=
  (qr67Witness_2_29.getD d.val 0 : Nat)
private theorem qr67Witness_2_29_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_29At d) 0 ∧ qr67Z (qr67Witness_2_29At d) 2 ∧
    qr67Z (qr67Witness_2_29At d) 29 ∧ qr67Z (qr67Witness_2_29At d) d := by
  decide

private def qr67Witness_2_30 : Array Nat := #[5,13,5,5,7,7,5,20,7,5,13,5,20,7,5,5,7,7,20,5,5,5,5,7,5,32,5,5,5,5,5,5,7,7,5,13,7,13,5,13,5,5,5,7,5,5,7,7,13,13,13,32,5,13,5,20,7,20,32,5,5,5,7,7,5,5,7]
private def qr67Witness_2_30At (d : F67) : F67 :=
  (qr67Witness_2_30.getD d.val 0 : Nat)
private theorem qr67Witness_2_30_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_30At d) 0 ∧ qr67Z (qr67Witness_2_30At d) 2 ∧
    qr67Z (qr67Witness_2_30At d) 30 ∧ qr67Z (qr67Witness_2_30At d) d := by
  decide

private def qr67Witness_2_31 : Array Nat := #[5,43,5,5,7,7,5,34,7,5,30,5,30,7,5,5,7,7,30,5,5,5,5,7,5,30,5,5,5,5,5,5,7,7,5,34,7,44,5,30,5,5,5,7,5,5,7,7,34,30,34,30,5,30,5,30,7,34,34,5,5,5,7,7,5,5,7]
private def qr67Witness_2_31At (d : F67) : F67 :=
  (qr67Witness_2_31.getD d.val 0 : Nat)
private theorem qr67Witness_2_31_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_31At d) 0 ∧ qr67Z (qr67Witness_2_31At d) 2 ∧
    qr67Z (qr67Witness_2_31At d) 31 ∧ qr67Z (qr67Witness_2_31At d) d := by
  decide

private def qr67Witness_2_32 : Array Nat := #[7,13,7,34,7,7,13,34,7,43,13,7,43,7,13,43,7,7,45,13,50,7,7,7,7,43,7,13,7,7,7,7,7,7,13,13,7,13,13,13,7,43,7,7,7,44,7,7,13,13,13,34,13,13,7,34,7,34,34,34,13,7,7,7,43,43,7]
private def qr67Witness_2_32At (d : F67) : F67 :=
  (qr67Witness_2_32.getD d.val 0 : Nat)
private theorem qr67Witness_2_32_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_32At d) 0 ∧ qr67Z (qr67Witness_2_32At d) 2 ∧
    qr67Z (qr67Witness_2_32At d) 32 ∧ qr67Z (qr67Witness_2_32At d) d := by
  decide

private def qr67Witness_2_33 : Array Nat := #[7,32,7,44,7,7,44,45,7,53,44,7,32,7,32,45,7,7,45,32,32,7,7,7,7,32,7,32,7,7,7,7,7,7,45,46,7,44,32,44,7,32,7,7,7,44,7,7,32,32,44,32,46,32,7,32,7,32,32,44,44,7,7,7,45,32,7]
private def qr67Witness_2_33At (d : F67) : F67 :=
  (qr67Witness_2_33.getD d.val 0 : Nat)
private theorem qr67Witness_2_33_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_33At d) 0 ∧ qr67Z (qr67Witness_2_33At d) 2 ∧
    qr67Z (qr67Witness_2_33At d) 33 ∧ qr67Z (qr67Witness_2_33At d) d := by
  decide

private def qr67Witness_2_34 : Array Nat := #[5,13,5,5,45,13,5,20,13,5,13,5,20,20,5,5,46,13,20,5,5,5,5,13,5,30,5,5,5,5,5,5,13,45,5,13,13,13,5,13,5,5,5,20,5,5,13,30,13,13,13,30,5,13,5,20,20,20,52,5,5,5,13,30,5,5,30]
private def qr67Witness_2_34At (d : F67) : F67 :=
  (qr67Witness_2_34.getD d.val 0 : Nat)
private theorem qr67Witness_2_34_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_34At d) 0 ∧ qr67Z (qr67Witness_2_34At d) 2 ∧
    qr67Z (qr67Witness_2_34At d) 34 ∧ qr67Z (qr67Witness_2_34At d) d := by
  decide

private def qr67Witness_2_35 : Array Nat := #[13,13,13,34,34,13,13,20,13,20,13,13,20,20,13,20,34,13,20,13,48,20,13,13,20,43,20,13,13,13,13,34,13,46,13,13,13,13,13,13,34,20,13,20,20,20,13,43,13,13,13,34,13,13,48,20,20,20,34,20,13,46,13,34,43,43,43]
private def qr67Witness_2_35At (d : F67) : F67 :=
  (qr67Witness_2_35.getD d.val 0 : Nat)
private theorem qr67Witness_2_35_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_35At d) 0 ∧ qr67Z (qr67Witness_2_35At d) 2 ∧
    qr67Z (qr67Witness_2_35At d) 35 ∧ qr67Z (qr67Witness_2_35At d) d := by
  decide

private def qr67Witness_2_36 : Array Nat := #[7,13,7,30,7,7,13,20,7,20,13,7,20,7,13,20,7,7,20,13,32,7,7,7,7,30,7,13,7,7,7,7,7,7,13,13,7,13,13,13,7,20,7,7,7,20,7,7,13,13,13,30,13,13,7,20,7,20,32,20,13,7,7,7,43,30,7]
private def qr67Witness_2_36At (d : F67) : F67 :=
  (qr67Witness_2_36.getD d.val 0 : Nat)
private theorem qr67Witness_2_36_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_36At d) 0 ∧ qr67Z (qr67Witness_2_36At d) 2 ∧
    qr67Z (qr67Witness_2_36At d) 36 ∧ qr67Z (qr67Witness_2_36At d) d := by
  decide

private def qr67Witness_2_37 : Array Nat := #[13,13,13,44,45,13,13,20,13,20,13,13,20,20,13,20,44,13,20,13,48,20,13,13,20,45,20,13,13,13,13,44,13,44,13,13,13,13,13,13,45,20,13,20,20,20,13,50,13,13,13,45,13,13,44,20,20,20,44,20,13,44,13,44,45,44,44]
private def qr67Witness_2_37At (d : F67) : F67 :=
  (qr67Witness_2_37.getD d.val 0 : Nat)
private theorem qr67Witness_2_37_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_37At d) 0 ∧ qr67Z (qr67Witness_2_37At d) 2 ∧
    qr67Z (qr67Witness_2_37At d) 37 ∧ qr67Z (qr67Witness_2_37At d) d := by
  decide

private def qr67Witness_2_38 : Array Nat := #[5,13,5,5,32,13,5,34,13,5,13,5,32,43,5,5,34,13,45,5,5,5,5,13,5,32,5,5,5,5,5,5,13,32,5,13,13,13,5,13,5,5,5,34,5,5,13,32,13,13,13,32,5,13,5,32,32,32,32,5,5,5,13,34,5,5,43]
private def qr67Witness_2_38At (d : F67) : F67 :=
  (qr67Witness_2_38.getD d.val 0 : Nat)
private theorem qr67Witness_2_38_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_38At d) 0 ∧ qr67Z (qr67Witness_2_38At d) 2 ∧
    qr67Z (qr67Witness_2_38At d) 38 ∧ qr67Z (qr67Witness_2_38At d) d := by
  decide

private def qr67Witness_2_39 : Array Nat := #[13,13,13,30,46,13,13,20,13,20,13,13,20,20,13,20,44,13,20,13,50,20,13,13,20,30,20,13,13,13,13,30,13,44,13,13,13,13,13,13,30,20,13,20,20,20,13,30,13,13,13,30,13,13,30,20,20,20,44,20,13,44,13,30,50,30,30]
private def qr67Witness_2_39At (d : F67) : F67 :=
  (qr67Witness_2_39.getD d.val 0 : Nat)
private theorem qr67Witness_2_39_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_39At d) 0 ∧ qr67Z (qr67Witness_2_39At d) 2 ∧
    qr67Z (qr67Witness_2_39At d) 39 ∧ qr67Z (qr67Witness_2_39At d) d := by
  decide

private def qr67Witness_2_40 : Array Nat := #[5,43,5,5,7,7,5,34,7,5,30,5,30,7,5,5,7,7,30,5,5,5,5,7,5,30,5,5,5,5,5,5,7,7,5,34,7,45,5,30,5,5,5,7,5,5,7,7,34,30,34,30,5,30,5,30,7,34,34,5,5,5,7,7,5,5,7]
private def qr67Witness_2_40At (d : F67) : F67 :=
  (qr67Witness_2_40.getD d.val 0 : Nat)
private theorem qr67Witness_2_40_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_40At d) 0 ∧ qr67Z (qr67Witness_2_40At d) 2 ∧
    qr67Z (qr67Witness_2_40At d) 40 ∧ qr67Z (qr67Witness_2_40At d) d := by
  decide

private def qr67Witness_2_41 : Array Nat := #[5,32,5,5,32,32,5,20,20,5,44,5,20,20,5,5,43,20,20,5,5,5,5,43,5,32,5,5,5,5,5,5,43,32,5,20,20,20,5,20,5,5,5,20,5,5,20,32,32,20,44,32,5,20,5,20,20,20,32,5,5,5,43,44,5,5,43]
private def qr67Witness_2_41At (d : F67) : F67 :=
  (qr67Witness_2_41.getD d.val 0 : Nat)
private theorem qr67Witness_2_41_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_41At d) 0 ∧ qr67Z (qr67Witness_2_41At d) 2 ∧
    qr67Z (qr67Witness_2_41At d) 41 ∧ qr67Z (qr67Witness_2_41At d) d := by
  decide

private def qr67Witness_2_42 : Array Nat := #[5,13,5,5,7,7,5,20,7,5,13,5,20,7,5,5,7,7,20,5,5,5,5,7,5,32,5,5,5,5,5,5,7,7,5,13,7,13,5,13,5,5,5,7,5,5,7,7,13,13,13,32,5,13,5,20,7,20,32,5,5,5,7,7,5,5,7]
private def qr67Witness_2_42At (d : F67) : F67 :=
  (qr67Witness_2_42.getD d.val 0 : Nat)
private theorem qr67Witness_2_42_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_42At d) 0 ∧ qr67Z (qr67Witness_2_42At d) 2 ∧
    qr67Z (qr67Witness_2_42At d) 42 ∧ qr67Z (qr67Witness_2_42At d) d := by
  decide

private def qr67Witness_2_43 : Array Nat := #[7,45,7,34,7,7,34,20,7,20,48,7,20,7,34,20,7,7,20,46,48,7,7,7,7,45,7,34,7,7,7,7,7,7,20,20,7,20,34,20,7,20,7,7,7,20,7,7,34,20,34,34,46,20,7,20,7,20,34,20,20,7,7,7,45,46,7]
private def qr67Witness_2_43At (d : F67) : F67 :=
  (qr67Witness_2_43.getD d.val 0 : Nat)
private theorem qr67Witness_2_43_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_43At d) 0 ∧ qr67Z (qr67Witness_2_43At d) 2 ∧
    qr67Z (qr67Witness_2_43At d) 43 ∧ qr67Z (qr67Witness_2_43At d) d := by
  decide

private def qr67Witness_2_44 : Array Nat := #[5,43,5,5,7,7,5,20,7,5,30,5,20,7,5,5,7,7,20,5,5,5,5,7,5,30,5,5,5,5,5,5,7,7,5,20,7,20,5,20,5,5,5,7,5,5,7,7,34,20,34,30,5,20,5,20,7,20,34,5,5,5,7,7,5,5,7]
private def qr67Witness_2_44At (d : F67) : F67 :=
  (qr67Witness_2_44.getD d.val 0 : Nat)
private theorem qr67Witness_2_44_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_44At d) 0 ∧ qr67Z (qr67Witness_2_44At d) 2 ∧
    qr67Z (qr67Witness_2_44At d) 44 ∧ qr67Z (qr67Witness_2_44At d) d := by
  decide

private def qr67Witness_2_45 : Array Nat := #[5,44,5,5,48,48,5,20,20,5,30,5,20,20,5,5,44,20,20,5,5,5,5,30,5,30,5,5,5,5,5,5,44,44,5,20,20,20,5,20,5,5,5,20,5,5,20,30,44,20,44,30,5,20,5,20,20,20,44,5,5,5,48,30,5,5,30]
private def qr67Witness_2_45At (d : F67) : F67 :=
  (qr67Witness_2_45.getD d.val 0 : Nat)
private theorem qr67Witness_2_45_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_45At d) 0 ∧ qr67Z (qr67Witness_2_45At d) 2 ∧
    qr67Z (qr67Witness_2_45At d) 45 ∧ qr67Z (qr67Witness_2_45At d) d := by
  decide

private def qr67Witness_2_46 : Array Nat := #[7,13,7,30,7,7,13,20,7,20,13,7,20,7,13,20,7,7,20,13,32,7,7,7,7,30,7,13,7,7,7,7,7,7,13,13,7,13,13,13,7,20,7,7,7,20,7,7,13,13,13,30,13,13,7,20,7,20,32,20,13,7,7,7,45,30,7]
private def qr67Witness_2_46At (d : F67) : F67 :=
  (qr67Witness_2_46.getD d.val 0 : Nat)
private theorem qr67Witness_2_46_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_46At d) 0 ∧ qr67Z (qr67Witness_2_46At d) 2 ∧
    qr67Z (qr67Witness_2_46At d) 46 ∧ qr67Z (qr67Witness_2_46At d) d := by
  decide

private def qr67Witness_2_47 : Array Nat := #[7,32,7,30,7,7,50,50,7,43,30,7,30,7,32,43,7,7,30,30,32,7,7,7,7,30,7,30,7,7,7,7,7,7,30,43,7,50,32,30,7,32,7,7,7,30,7,7,32,30,46,30,30,30,7,30,7,32,32,30,43,7,7,7,43,30,7]
private def qr67Witness_2_47At (d : F67) : F67 :=
  (qr67Witness_2_47.getD d.val 0 : Nat)
private theorem qr67Witness_2_47_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_47At d) 0 ∧ qr67Z (qr67Witness_2_47At d) 2 ∧
    qr67Z (qr67Witness_2_47At d) 47 ∧ qr67Z (qr67Witness_2_47At d) d := by
  decide

private def qr67Witness_2_48 : Array Nat := #[13,13,13,34,32,13,13,34,13,50,13,13,32,44,13,53,34,13,50,13,32,32,13,13,32,32,34,13,13,13,13,34,13,32,13,13,13,13,13,13,34,32,13,34,34,44,13,32,13,13,13,32,13,13,32,32,32,32,32,34,13,32,13,34,50,32,44]
private def qr67Witness_2_48At (d : F67) : F67 :=
  (qr67Witness_2_48.getD d.val 0 : Nat)
private theorem qr67Witness_2_48_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_48At d) 0 ∧ qr67Z (qr67Witness_2_48At d) 2 ∧
    qr67Z (qr67Witness_2_48At d) 48 ∧ qr67Z (qr67Witness_2_48At d) d := by
  decide

private def qr67Witness_2_49 : Array Nat := #[13,13,13,30,32,13,13,20,13,20,13,13,20,20,13,20,34,13,20,13,32,20,13,13,20,30,20,13,13,13,13,30,13,32,13,13,13,13,13,13,30,20,13,20,20,20,13,30,13,13,13,30,13,13,30,20,20,20,32,20,13,32,13,30,43,30,30]
private def qr67Witness_2_49At (d : F67) : F67 :=
  (qr67Witness_2_49.getD d.val 0 : Nat)
private theorem qr67Witness_2_49_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_49At d) 0 ∧ qr67Z (qr67Witness_2_49At d) 2 ∧
    qr67Z (qr67Witness_2_49At d) 49 ∧ qr67Z (qr67Witness_2_49At d) d := by
  decide

private def qr67Witness_2_50 : Array Nat := #[13,13,13,34,34,13,13,34,13,52,13,13,44,44,13,46,34,13,46,13,52,34,13,13,44,52,34,13,13,13,13,34,13,44,13,13,13,13,13,13,34,44,13,34,34,44,13,46,13,13,13,34,13,13,44,34,34,34,34,34,13,44,13,34,63,44,44]
private def qr67Witness_2_50At (d : F67) : F67 :=
  (qr67Witness_2_50.getD d.val 0 : Nat)
private theorem qr67Witness_2_50_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_50At d) 0 ∧ qr67Z (qr67Witness_2_50At d) 2 ∧
    qr67Z (qr67Witness_2_50At d) 50 ∧ qr67Z (qr67Witness_2_50At d) d := by
  decide

private def qr67Witness_2_51 : Array Nat := #[30,32,30,30,32,32,34,34,50,50,30,45,30,45,32,45,34,30,30,30,32,32,30,30,32,30,34,30,30,32,32,30,34,32,30,34,30,45,32,30,30,32,32,34,30,30,30,30,32,30,34,30,30,30,30,30,30,32,32,30,34,32,45,30,45,30,30]
private def qr67Witness_2_51At (d : F67) : F67 :=
  (qr67Witness_2_51.getD d.val 0 : Nat)
private theorem qr67Witness_2_51_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_51At d) 0 ∧ qr67Z (qr67Witness_2_51At d) 2 ∧
    qr67Z (qr67Witness_2_51At d) 51 ∧ qr67Z (qr67Witness_2_51At d) d := by
  decide

private def qr67Witness_2_52 : Array Nat := #[5,13,5,5,46,13,5,48,13,5,13,5,30,43,5,5,43,13,30,5,5,5,5,13,5,30,5,5,5,5,5,5,13,46,5,13,13,13,5,13,5,5,5,46,5,5,13,30,13,13,13,30,5,13,5,30,30,43,43,5,5,5,13,30,5,5,30]
private def qr67Witness_2_52At (d : F67) : F67 :=
  (qr67Witness_2_52.getD d.val 0 : Nat)
private theorem qr67Witness_2_52_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_52At d) 0 ∧ qr67Z (qr67Witness_2_52At d) 2 ∧
    qr67Z (qr67Witness_2_52At d) 52 ∧ qr67Z (qr67Witness_2_52At d) d := by
  decide

private def qr67Witness_2_53 : Array Nat := #[13,13,13,30,32,13,13,20,13,20,13,13,20,20,13,20,34,13,20,13,32,20,13,13,20,30,20,13,13,13,13,30,13,32,13,13,13,13,13,13,30,20,13,20,20,20,13,30,13,13,13,30,13,13,30,20,20,20,32,20,13,32,13,30,43,30,30]
private def qr67Witness_2_53At (d : F67) : F67 :=
  (qr67Witness_2_53.getD d.val 0 : Nat)
private theorem qr67Witness_2_53_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_53At d) 0 ∧ qr67Z (qr67Witness_2_53At d) 2 ∧
    qr67Z (qr67Witness_2_53At d) 53 ∧ qr67Z (qr67Witness_2_53At d) d := by
  decide

private def qr67Witness_2_54 : Array Nat := #[5,32,5,5,7,7,5,45,7,5,30,5,30,7,5,5,7,7,30,5,5,5,5,7,5,30,5,5,5,5,5,5,7,7,5,48,7,44,5,30,5,5,5,7,5,5,7,7,32,30,44,30,5,30,5,30,7,32,32,5,5,5,7,7,5,5,7]
private def qr67Witness_2_54At (d : F67) : F67 :=
  (qr67Witness_2_54.getD d.val 0 : Nat)
private theorem qr67Witness_2_54_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_54At d) 0 ∧ qr67Z (qr67Witness_2_54At d) 2 ∧
    qr67Z (qr67Witness_2_54At d) 54 ∧ qr67Z (qr67Witness_2_54At d) d := by
  decide

private def qr67Witness_2_55 : Array Nat := #[20,32,20,30,32,32,34,20,20,20,30,45,20,20,32,20,34,20,20,30,32,20,30,30,20,30,20,30,30,20,20,30,34,32,20,20,20,20,32,20,30,20,20,20,20,20,20,30,32,20,34,30,30,20,30,20,20,20,32,20,20,32,45,30,45,30,30]
private def qr67Witness_2_55At (d : F67) : F67 :=
  (qr67Witness_2_55.getD d.val 0 : Nat)
private theorem qr67Witness_2_55_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_55At d) 0 ∧ qr67Z (qr67Witness_2_55At d) 2 ∧
    qr67Z (qr67Witness_2_55At d) 55 ∧ qr67Z (qr67Witness_2_55At d) d := by
  decide

private def qr67Witness_2_56 : Array Nat := #[7,32,7,30,7,7,34,20,7,20,30,7,20,7,32,20,7,7,20,30,32,7,7,7,7,30,7,30,7,7,7,7,7,7,20,20,7,20,32,20,7,20,7,7,7,20,7,7,32,20,34,30,30,20,7,20,7,20,32,20,20,7,7,7,50,30,7]
private def qr67Witness_2_56At (d : F67) : F67 :=
  (qr67Witness_2_56.getD d.val 0 : Nat)
private theorem qr67Witness_2_56_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_56At d) 0 ∧ qr67Z (qr67Witness_2_56At d) 2 ∧
    qr67Z (qr67Witness_2_56At d) 56 ∧ qr67Z (qr67Witness_2_56At d) d := by
  decide

private def qr67Witness_2_57 : Array Nat := #[20,32,20,34,32,32,34,20,20,20,48,43,20,20,32,20,34,20,20,32,32,20,34,34,20,32,20,32,48,20,20,34,34,32,20,20,20,20,32,20,34,20,20,20,20,20,20,32,32,20,34,32,43,20,32,20,20,20,32,20,20,32,43,34,43,32,43]
private def qr67Witness_2_57At (d : F67) : F67 :=
  (qr67Witness_2_57.getD d.val 0 : Nat)
private theorem qr67Witness_2_57_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_57At d) 0 ∧ qr67Z (qr67Witness_2_57At d) 2 ∧
    qr67Z (qr67Witness_2_57At d) 57 ∧ qr67Z (qr67Witness_2_57At d) d := by
  decide

private def qr67Witness_2_58 : Array Nat := #[32,32,32,34,32,32,34,34,52,43,44,43,32,43,32,43,34,44,48,32,32,32,34,34,32,32,34,32,48,32,32,34,34,32,52,34,32,44,32,44,34,32,32,34,34,44,32,32,32,32,34,32,43,32,32,32,32,32,32,34,34,32,43,34,43,32,43]
private def qr67Witness_2_58At (d : F67) : F67 :=
  (qr67Witness_2_58.getD d.val 0 : Nat)
private theorem qr67Witness_2_58_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_58At d) 0 ∧ qr67Z (qr67Witness_2_58At d) 2 ∧
    qr67Z (qr67Witness_2_58At d) 58 ∧ qr67Z (qr67Witness_2_58At d) d := by
  decide

private def qr67Witness_2_59 : Array Nat := #[5,43,5,5,34,43,5,20,20,5,30,5,20,20,5,5,34,20,20,5,5,5,5,30,5,30,5,5,5,5,5,5,34,44,5,20,20,20,5,20,5,5,5,20,5,5,20,30,34,20,34,30,5,20,5,20,20,20,34,5,5,5,43,30,5,5,30]
private def qr67Witness_2_59At (d : F67) : F67 :=
  (qr67Witness_2_59.getD d.val 0 : Nat)
private theorem qr67Witness_2_59_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_59At d) 0 ∧ qr67Z (qr67Witness_2_59At d) 2 ∧
    qr67Z (qr67Witness_2_59At d) 59 ∧ qr67Z (qr67Witness_2_59At d) d := by
  decide

private def qr67Witness_2_60 : Array Nat := #[5,13,5,5,34,13,5,20,13,5,13,5,20,20,5,5,34,13,20,5,5,5,5,13,5,43,5,5,5,5,5,5,13,44,5,13,13,13,5,13,5,5,5,20,5,5,13,43,13,13,13,34,5,13,5,20,20,20,34,5,5,5,13,34,5,5,43]
private def qr67Witness_2_60At (d : F67) : F67 :=
  (qr67Witness_2_60.getD d.val 0 : Nat)
private theorem qr67Witness_2_60_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_60At d) 0 ∧ qr67Z (qr67Witness_2_60At d) 2 ∧
    qr67Z (qr67Witness_2_60At d) 60 ∧ qr67Z (qr67Witness_2_60At d) d := by
  decide

private def qr67Witness_2_61 : Array Nat := #[5,32,5,5,7,7,5,45,7,5,44,5,32,7,5,5,7,7,45,5,5,5,5,7,5,32,5,5,5,5,5,5,7,7,5,46,7,44,5,44,5,5,5,7,5,5,7,7,32,32,44,32,5,32,5,32,7,32,32,5,5,5,7,7,5,5,7]
private def qr67Witness_2_61At (d : F67) : F67 :=
  (qr67Witness_2_61.getD d.val 0 : Nat)
private theorem qr67Witness_2_61_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_61At d) 0 ∧ qr67Z (qr67Witness_2_61At d) 2 ∧
    qr67Z (qr67Witness_2_61At d) 61 ∧ qr67Z (qr67Witness_2_61At d) d := by
  decide

private def qr67Witness_2_62 : Array Nat := #[7,13,7,45,7,7,13,45,7,43,13,7,43,7,13,43,7,7,45,13,48,7,7,7,7,43,7,13,7,7,7,7,7,7,13,13,7,13,13,13,7,43,7,7,7,48,7,7,13,13,13,45,13,13,7,45,7,43,43,43,13,7,7,7,43,43,7]
private def qr67Witness_2_62At (d : F67) : F67 :=
  (qr67Witness_2_62.getD d.val 0 : Nat)
private theorem qr67Witness_2_62_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_62At d) 0 ∧ qr67Z (qr67Witness_2_62At d) 2 ∧
    qr67Z (qr67Witness_2_62At d) 62 ∧ qr67Z (qr67Witness_2_62At d) d := by
  decide

private def qr67Witness_2_63 : Array Nat := #[7,44,7,30,7,7,34,34,7,53,30,7,30,7,34,46,7,7,30,30,48,7,7,7,7,30,7,30,7,7,7,7,7,7,30,34,7,44,34,30,7,44,7,7,7,30,7,7,34,30,34,30,30,30,7,30,7,34,34,30,34,7,7,7,48,30,7]
private def qr67Witness_2_63At (d : F67) : F67 :=
  (qr67Witness_2_63.getD d.val 0 : Nat)
private theorem qr67Witness_2_63_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_63At d) 0 ∧ qr67Z (qr67Witness_2_63At d) 2 ∧
    qr67Z (qr67Witness_2_63At d) 63 ∧ qr67Z (qr67Witness_2_63At d) d := by
  decide

private def qr67Witness_2_64 : Array Nat := #[5,43,5,5,45,43,5,45,50,5,48,5,43,43,5,5,43,45,45,5,5,5,5,43,5,43,5,5,5,5,5,5,43,45,5,43,43,45,5,50,5,5,5,45,5,5,45,43,50,43,63,45,5,43,5,45,50,43,43,5,5,5,43,48,5,5,43]
private def qr67Witness_2_64At (d : F67) : F67 :=
  (qr67Witness_2_64.getD d.val 0 : Nat)
private theorem qr67Witness_2_64_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_64At d) 0 ∧ qr67Z (qr67Witness_2_64At d) 2 ∧
    qr67Z (qr67Witness_2_64At d) 64 ∧ qr67Z (qr67Witness_2_64At d) d := by
  decide

private def qr67Witness_2_65 : Array Nat := #[5,32,5,5,32,32,5,48,46,5,30,5,30,43,5,5,43,30,30,5,5,5,5,30,5,30,5,5,5,5,5,5,43,32,5,43,30,44,5,30,5,5,5,46,5,5,30,30,32,30,44,30,5,30,5,30,30,32,32,5,5,5,43,30,5,5,30]
private def qr67Witness_2_65At (d : F67) : F67 :=
  (qr67Witness_2_65.getD d.val 0 : Nat)
private theorem qr67Witness_2_65_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_65At d) 0 ∧ qr67Z (qr67Witness_2_65At d) 2 ∧
    qr67Z (qr67Witness_2_65At d) 65 ∧ qr67Z (qr67Witness_2_65At d) d := by
  decide

private def qr67Witness_2_66 : Array Nat := #[7,43,7,30,7,7,44,45,7,43,30,7,30,7,44,43,7,7,30,30,50,7,7,7,7,30,7,30,7,7,7,7,7,7,30,43,7,44,43,30,7,43,7,7,7,30,7,7,44,30,44,30,30,30,7,30,7,43,43,30,43,7,7,7,43,30,7]
private def qr67Witness_2_66At (d : F67) : F67 :=
  (qr67Witness_2_66.getD d.val 0 : Nat)
private theorem qr67Witness_2_66_correct : ∀ d : F67,
    qr67Z (qr67Witness_2_66At d) 0 ∧ qr67Z (qr67Witness_2_66At d) 2 ∧
    qr67Z (qr67Witness_2_66At d) 66 ∧ qr67Z (qr67Witness_2_66At d) d := by
  decide

theorem qr67_cert_2 :
    ∀ c d : F67, ∃ v : F67, qr67Z v 0 ∧ qr67Z v 2 ∧ qr67Z v c ∧ qr67Z v d := by
  intro c
  fin_cases c
  · exact fun d => ⟨qr67Witness_2_0At d, qr67Witness_2_0_correct d⟩
  · exact fun d => ⟨qr67Witness_2_1At d, qr67Witness_2_1_correct d⟩
  · exact fun d => ⟨qr67Witness_2_2At d, qr67Witness_2_2_correct d⟩
  · exact fun d => ⟨qr67Witness_2_3At d, qr67Witness_2_3_correct d⟩
  · exact fun d => ⟨qr67Witness_2_4At d, qr67Witness_2_4_correct d⟩
  · exact fun d => ⟨qr67Witness_2_5At d, qr67Witness_2_5_correct d⟩
  · exact fun d => ⟨qr67Witness_2_6At d, qr67Witness_2_6_correct d⟩
  · exact fun d => ⟨qr67Witness_2_7At d, qr67Witness_2_7_correct d⟩
  · exact fun d => ⟨qr67Witness_2_8At d, qr67Witness_2_8_correct d⟩
  · exact fun d => ⟨qr67Witness_2_9At d, qr67Witness_2_9_correct d⟩
  · exact fun d => ⟨qr67Witness_2_10At d, qr67Witness_2_10_correct d⟩
  · exact fun d => ⟨qr67Witness_2_11At d, qr67Witness_2_11_correct d⟩
  · exact fun d => ⟨qr67Witness_2_12At d, qr67Witness_2_12_correct d⟩
  · exact fun d => ⟨qr67Witness_2_13At d, qr67Witness_2_13_correct d⟩
  · exact fun d => ⟨qr67Witness_2_14At d, qr67Witness_2_14_correct d⟩
  · exact fun d => ⟨qr67Witness_2_15At d, qr67Witness_2_15_correct d⟩
  · exact fun d => ⟨qr67Witness_2_16At d, qr67Witness_2_16_correct d⟩
  · exact fun d => ⟨qr67Witness_2_17At d, qr67Witness_2_17_correct d⟩
  · exact fun d => ⟨qr67Witness_2_18At d, qr67Witness_2_18_correct d⟩
  · exact fun d => ⟨qr67Witness_2_19At d, qr67Witness_2_19_correct d⟩
  · exact fun d => ⟨qr67Witness_2_20At d, qr67Witness_2_20_correct d⟩
  · exact fun d => ⟨qr67Witness_2_21At d, qr67Witness_2_21_correct d⟩
  · exact fun d => ⟨qr67Witness_2_22At d, qr67Witness_2_22_correct d⟩
  · exact fun d => ⟨qr67Witness_2_23At d, qr67Witness_2_23_correct d⟩
  · exact fun d => ⟨qr67Witness_2_24At d, qr67Witness_2_24_correct d⟩
  · exact fun d => ⟨qr67Witness_2_25At d, qr67Witness_2_25_correct d⟩
  · exact fun d => ⟨qr67Witness_2_26At d, qr67Witness_2_26_correct d⟩
  · exact fun d => ⟨qr67Witness_2_27At d, qr67Witness_2_27_correct d⟩
  · exact fun d => ⟨qr67Witness_2_28At d, qr67Witness_2_28_correct d⟩
  · exact fun d => ⟨qr67Witness_2_29At d, qr67Witness_2_29_correct d⟩
  · exact fun d => ⟨qr67Witness_2_30At d, qr67Witness_2_30_correct d⟩
  · exact fun d => ⟨qr67Witness_2_31At d, qr67Witness_2_31_correct d⟩
  · exact fun d => ⟨qr67Witness_2_32At d, qr67Witness_2_32_correct d⟩
  · exact fun d => ⟨qr67Witness_2_33At d, qr67Witness_2_33_correct d⟩
  · exact fun d => ⟨qr67Witness_2_34At d, qr67Witness_2_34_correct d⟩
  · exact fun d => ⟨qr67Witness_2_35At d, qr67Witness_2_35_correct d⟩
  · exact fun d => ⟨qr67Witness_2_36At d, qr67Witness_2_36_correct d⟩
  · exact fun d => ⟨qr67Witness_2_37At d, qr67Witness_2_37_correct d⟩
  · exact fun d => ⟨qr67Witness_2_38At d, qr67Witness_2_38_correct d⟩
  · exact fun d => ⟨qr67Witness_2_39At d, qr67Witness_2_39_correct d⟩
  · exact fun d => ⟨qr67Witness_2_40At d, qr67Witness_2_40_correct d⟩
  · exact fun d => ⟨qr67Witness_2_41At d, qr67Witness_2_41_correct d⟩
  · exact fun d => ⟨qr67Witness_2_42At d, qr67Witness_2_42_correct d⟩
  · exact fun d => ⟨qr67Witness_2_43At d, qr67Witness_2_43_correct d⟩
  · exact fun d => ⟨qr67Witness_2_44At d, qr67Witness_2_44_correct d⟩
  · exact fun d => ⟨qr67Witness_2_45At d, qr67Witness_2_45_correct d⟩
  · exact fun d => ⟨qr67Witness_2_46At d, qr67Witness_2_46_correct d⟩
  · exact fun d => ⟨qr67Witness_2_47At d, qr67Witness_2_47_correct d⟩
  · exact fun d => ⟨qr67Witness_2_48At d, qr67Witness_2_48_correct d⟩
  · exact fun d => ⟨qr67Witness_2_49At d, qr67Witness_2_49_correct d⟩
  · exact fun d => ⟨qr67Witness_2_50At d, qr67Witness_2_50_correct d⟩
  · exact fun d => ⟨qr67Witness_2_51At d, qr67Witness_2_51_correct d⟩
  · exact fun d => ⟨qr67Witness_2_52At d, qr67Witness_2_52_correct d⟩
  · exact fun d => ⟨qr67Witness_2_53At d, qr67Witness_2_53_correct d⟩
  · exact fun d => ⟨qr67Witness_2_54At d, qr67Witness_2_54_correct d⟩
  · exact fun d => ⟨qr67Witness_2_55At d, qr67Witness_2_55_correct d⟩
  · exact fun d => ⟨qr67Witness_2_56At d, qr67Witness_2_56_correct d⟩
  · exact fun d => ⟨qr67Witness_2_57At d, qr67Witness_2_57_correct d⟩
  · exact fun d => ⟨qr67Witness_2_58At d, qr67Witness_2_58_correct d⟩
  · exact fun d => ⟨qr67Witness_2_59At d, qr67Witness_2_59_correct d⟩
  · exact fun d => ⟨qr67Witness_2_60At d, qr67Witness_2_60_correct d⟩
  · exact fun d => ⟨qr67Witness_2_61At d, qr67Witness_2_61_correct d⟩
  · exact fun d => ⟨qr67Witness_2_62At d, qr67Witness_2_62_correct d⟩
  · exact fun d => ⟨qr67Witness_2_63At d, qr67Witness_2_63_correct d⟩
  · exact fun d => ⟨qr67Witness_2_64At d, qr67Witness_2_64_correct d⟩
  · exact fun d => ⟨qr67Witness_2_65At d, qr67Witness_2_65_correct d⟩
  · exact fun d => ⟨qr67Witness_2_66At d, qr67Witness_2_66_correct d⟩
