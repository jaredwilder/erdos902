import Erdos902QR67Base

private def qr67Witness_0_0 : Array Nat := #[2,3,5,2,3,7,2,3,2,3,12,2,2,3,5,5,2,2,2,2,3,2,3,2,2,2,2,2,2,3,5,2,3,7,5,2,3,2,2,2,3,2,2,3,5,5,7,7,8,2,3,2,3,13,5,8,2,2,2,3,5,2,2,3,2,3,2]
private def qr67Witness_0_0At (d : F67) : F67 :=
  (qr67Witness_0_0.getD d.val 0 : Nat)
private theorem qr67Witness_0_0_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_0At d) 0 ∧ qr67Z (qr67Witness_0_0At d) 0 ∧
    qr67Z (qr67Witness_0_0At d) 0 ∧ qr67Z (qr67Witness_0_0At d) d := by
  decide

private def qr67Witness_0_1 : Array Nat := #[3,3,13,8,3,8,8,3,13,3,12,13,3,3,8,28,12,3,3,3,3,12,3,8,3,3,3,3,3,3,8,8,3,8,8,12,3,8,3,3,3,8,3,3,8,8,13,8,8,12,3,12,3,13,28,8,31,3,3,3,13,12,3,3,8,3,12]
private def qr67Witness_0_1At (d : F67) : F67 :=
  (qr67Witness_0_1.getD d.val 0 : Nat)
private theorem qr67Witness_0_1_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_1At d) 0 ∧ qr67Z (qr67Witness_0_1At d) 0 ∧
    qr67Z (qr67Witness_0_1At d) 1 ∧ qr67Z (qr67Witness_0_1At d) d := by
  decide

private def qr67Witness_0_2 : Array Nat := #[5,13,5,5,7,7,5,20,7,5,13,5,20,7,5,5,7,7,20,5,5,5,5,7,5,30,5,5,5,5,5,5,7,7,5,13,7,13,5,13,5,5,5,7,5,5,7,7,13,13,13,30,5,13,5,20,7,20,32,5,5,5,7,7,5,5,7]
private def qr67Witness_0_2At (d : F67) : F67 :=
  (qr67Witness_0_2.getD d.val 0 : Nat)
private theorem qr67Witness_0_2_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_2At d) 0 ∧ qr67Z (qr67Witness_0_2At d) 0 ∧
    qr67Z (qr67Witness_0_2At d) 2 ∧ qr67Z (qr67Witness_0_2At d) d := by
  decide

private def qr67Witness_0_3 : Array Nat := #[2,8,5,2,11,8,2,34,2,5,30,2,2,31,5,5,2,2,2,2,5,2,5,2,2,2,2,2,2,5,5,2,8,8,5,2,11,2,2,2,5,2,2,8,5,5,11,8,8,2,11,2,5,30,5,8,2,2,2,5,5,2,2,8,2,5,2]
private def qr67Witness_0_3At (d : F67) : F67 :=
  (qr67Witness_0_3.getD d.val 0 : Nat)
private theorem qr67Witness_0_3_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_3At d) 0 ∧ qr67Z (qr67Witness_0_3At d) 0 ∧
    qr67Z (qr67Witness_0_3At d) 3 ∧ qr67Z (qr67Witness_0_3At d) d := by
  decide

private def qr67Witness_0_4 : Array Nat := #[3,3,7,11,3,7,11,3,7,3,12,7,3,3,32,11,7,3,3,3,3,7,3,7,3,3,3,3,3,3,7,7,3,7,11,11,3,11,3,3,3,12,3,3,7,12,7,7,11,12,3,11,3,31,7,31,7,3,3,3,11,7,3,3,31,3,7]
private def qr67Witness_0_4At (d : F67) : F67 :=
  (qr67Witness_0_4.getD d.val 0 : Nat)
private theorem qr67Witness_0_4_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_4At d) 0 ∧ qr67Z (qr67Witness_0_4At d) 0 ∧
    qr67Z (qr67Witness_0_4At d) 4 ∧ qr67Z (qr67Witness_0_4At d) d := by
  decide

private def qr67Witness_0_5 : Array Nat := #[7,8,7,8,7,7,8,12,7,8,12,7,8,7,8,18,7,7,8,13,32,7,7,7,7,8,7,8,7,7,7,7,7,7,8,12,7,8,12,13,7,8,7,7,7,8,7,7,8,12,13,12,12,13,7,8,7,8,18,12,13,7,7,7,8,18,7]
private def qr67Witness_0_5At (d : F67) : F67 :=
  (qr67Witness_0_5.getD d.val 0 : Nat)
private theorem qr67Witness_0_5_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_5At d) 0 ∧ qr67Z (qr67Witness_0_5At d) 0 ∧
    qr67Z (qr67Witness_0_5At d) 5 ∧ qr67Z (qr67Witness_0_5At d) d := by
  decide

private def qr67Witness_0_6 : Array Nat := #[2,8,5,2,11,8,2,18,2,5,13,2,2,18,5,5,2,2,2,2,5,2,5,2,2,2,2,2,2,5,5,2,8,8,5,2,11,2,2,2,5,2,2,8,5,5,11,8,8,2,11,2,5,13,5,8,2,2,2,5,5,2,2,8,2,5,2]
private def qr67Witness_0_6At (d : F67) : F67 :=
  (qr67Witness_0_6.getD d.val 0 : Nat)
private theorem qr67Witness_0_6_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_6At d) 0 ∧ qr67Z (qr67Witness_0_6At d) 0 ∧
    qr67Z (qr67Witness_0_6At d) 6 ∧ qr67Z (qr67Witness_0_6At d) d := by
  decide

private def qr67Witness_0_7 : Array Nat := #[3,3,20,34,3,12,18,3,20,3,12,18,3,3,27,18,12,3,3,3,3,12,3,34,3,3,3,3,3,3,20,12,3,12,12,12,3,12,3,3,3,12,3,3,18,12,20,12,12,12,3,12,3,18,18,18,20,3,3,3,20,12,3,3,27,3,12]
private def qr67Witness_0_7At (d : F67) : F67 :=
  (qr67Witness_0_7.getD d.val 0 : Nat)
private theorem qr67Witness_0_7_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_7At d) 0 ∧ qr67Z (qr67Witness_0_7At d) 0 ∧
    qr67Z (qr67Witness_0_7At d) 7 ∧ qr67Z (qr67Witness_0_7At d) d := by
  decide

private def qr67Witness_0_8 : Array Nat := #[2,13,7,2,7,7,2,20,2,11,13,2,2,7,13,11,2,2,2,2,11,2,7,2,2,2,2,2,2,7,7,2,7,7,11,2,7,2,2,2,7,2,2,7,7,20,7,7,11,2,11,2,13,13,7,20,2,2,2,20,11,2,2,7,2,11,2]
private def qr67Witness_0_8At (d : F67) : F67 :=
  (qr67Witness_0_8.getD d.val 0 : Nat)
private theorem qr67Witness_0_8_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_8At d) 0 ∧ qr67Z (qr67Witness_0_8At d) 0 ∧
    qr67Z (qr67Witness_0_8At d) 8 ∧ qr67Z (qr67Witness_0_8At d) d := by
  decide

private def qr67Witness_0_9 : Array Nat := #[3,3,5,5,3,8,5,3,11,3,12,5,3,3,5,5,12,3,3,3,3,5,3,8,3,3,3,3,3,3,5,5,3,8,5,11,3,8,3,3,3,5,3,3,5,5,11,8,8,12,3,11,3,20,5,8,20,3,3,3,5,5,3,3,5,3,11]
private def qr67Witness_0_9At (d : F67) : F67 :=
  (qr67Witness_0_9.getD d.val 0 : Nat)
private theorem qr67Witness_0_9_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_9At d) 0 ∧ qr67Z (qr67Witness_0_9At d) 0 ∧
    qr67Z (qr67Witness_0_9At d) 9 ∧ qr67Z (qr67Witness_0_9At d) d := by
  decide

private def qr67Witness_0_10 : Array Nat := #[12,12,13,30,12,12,13,12,13,12,12,13,30,12,13,18,12,13,12,13,28,12,12,13,18,28,12,12,12,12,13,12,13,12,12,12,12,12,12,13,18,12,13,18,18,12,13,12,12,12,13,12,12,13,18,18,30,18,18,12,13,12,13,28,28,18,12]
private def qr67Witness_0_10At (d : F67) : F67 :=
  (qr67Witness_0_10.getD d.val 0 : Nat)
private theorem qr67Witness_0_10_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_10At d) 0 ∧ qr67Z (qr67Witness_0_10At d) 0 ∧
    qr67Z (qr67Witness_0_10At d) 10 ∧ qr67Z (qr67Witness_0_10At d) d := by
  decide

private def qr67Witness_0_11 : Array Nat := #[2,13,5,2,7,7,2,18,2,5,13,2,2,7,5,5,2,2,2,2,5,2,5,2,2,2,2,2,2,5,5,2,7,7,5,2,7,2,2,2,5,2,2,7,5,5,7,7,13,2,13,2,5,13,5,18,2,2,2,5,5,2,2,7,2,5,2]
private def qr67Witness_0_11At (d : F67) : F67 :=
  (qr67Witness_0_11.getD d.val 0 : Nat)
private theorem qr67Witness_0_11_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_11At d) 0 ∧ qr67Z (qr67Witness_0_11At d) 0 ∧
    qr67Z (qr67Witness_0_11At d) 11 ∧ qr67Z (qr67Witness_0_11At d) d := by
  decide

private def qr67Witness_0_12 : Array Nat := #[2,3,20,2,3,8,2,3,2,3,30,2,2,3,8,11,2,2,2,2,3,2,3,2,2,2,2,2,2,3,8,2,3,8,8,2,3,2,2,2,3,2,2,3,8,8,11,8,8,2,3,2,3,20,30,8,2,2,2,3,11,2,2,3,2,3,2]
private def qr67Witness_0_12At (d : F67) : F67 :=
  (qr67Witness_0_12.getD d.val 0 : Nat)
private theorem qr67Witness_0_12_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_12At d) 0 ∧ qr67Z (qr67Witness_0_12At d) 0 ∧
    qr67Z (qr67Witness_0_12At d) 12 ∧ qr67Z (qr67Witness_0_12At d) d := by
  decide

private def qr67Witness_0_13 : Array Nat := #[3,3,7,31,3,7,18,3,7,3,12,7,3,3,41,18,7,3,3,3,3,7,3,7,3,3,3,3,3,3,7,7,3,7,12,12,3,12,3,3,3,12,3,3,7,12,7,7,12,12,3,12,3,18,7,18,7,3,3,3,20,7,3,3,31,3,7]
private def qr67Witness_0_13At (d : F67) : F67 :=
  (qr67Witness_0_13.getD d.val 0 : Nat)
private theorem qr67Witness_0_13_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_13At d) 0 ∧ qr67Z (qr67Witness_0_13At d) 0 ∧
    qr67Z (qr67Witness_0_13At d) 13 ∧ qr67Z (qr67Witness_0_13At d) d := by
  decide

private def qr67Witness_0_14 : Array Nat := #[5,8,5,5,32,8,5,27,13,5,13,5,8,41,5,5,27,8,8,5,5,5,5,8,5,8,5,5,5,5,5,5,8,8,5,13,13,8,5,13,5,5,5,8,5,5,13,8,8,13,13,27,5,13,5,8,27,8,32,5,5,5,8,8,5,5,27]
private def qr67Witness_0_14At (d : F67) : F67 :=
  (qr67Witness_0_14.getD d.val 0 : Nat)
private theorem qr67Witness_0_14_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_14At d) 0 ∧ qr67Z (qr67Witness_0_14At d) 0 ∧
    qr67Z (qr67Witness_0_14At d) 14 ∧ qr67Z (qr67Witness_0_14At d) d := by
  decide

private def qr67Witness_0_15 : Array Nat := #[5,28,5,5,11,18,5,18,11,5,18,5,11,18,5,5,18,11,20,5,5,5,5,28,5,11,5,5,5,5,5,5,11,11,5,11,11,11,5,18,5,5,5,18,5,5,11,11,11,20,11,11,5,18,5,18,20,18,11,5,5,5,27,27,5,5,11]
private def qr67Witness_0_15At (d : F67) : F67 :=
  (qr67Witness_0_15.getD d.val 0 : Nat)
private theorem qr67Witness_0_15_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_15At d) 0 ∧ qr67Z (qr67Witness_0_15At d) 0 ∧
    qr67Z (qr67Witness_0_15At d) 15 ∧ qr67Z (qr67Witness_0_15At d) d := by
  decide

private def qr67Witness_0_16 : Array Nat := #[2,12,7,2,7,7,2,12,2,12,12,2,2,7,27,18,2,2,2,2,27,2,7,2,2,2,2,2,2,7,7,2,7,7,12,2,7,2,2,2,7,2,2,7,7,12,7,7,12,2,27,2,12,18,7,18,2,2,2,12,27,2,2,7,2,18,2]
private def qr67Witness_0_16At (d : F67) : F67 :=
  (qr67Witness_0_16.getD d.val 0 : Nat)
private theorem qr67Witness_0_16_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_16At d) 0 ∧ qr67Z (qr67Witness_0_16At d) 0 ∧
    qr67Z (qr67Witness_0_16At d) 16 ∧ qr67Z (qr67Witness_0_16At d) d := by
  decide

private def qr67Witness_0_17 : Array Nat := #[2,3,7,2,3,7,2,3,2,3,13,2,2,3,8,11,2,2,2,2,3,2,3,2,2,2,2,2,2,3,7,2,3,7,8,2,3,2,2,2,3,2,2,3,7,8,7,7,8,2,3,2,3,13,7,8,2,2,2,3,11,2,2,3,2,3,2]
private def qr67Witness_0_17At (d : F67) : F67 :=
  (qr67Witness_0_17.getD d.val 0 : Nat)
private theorem qr67Witness_0_17_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_17At d) 0 ∧ qr67Z (qr67Witness_0_17At d) 0 ∧
    qr67Z (qr67Witness_0_17At d) 17 ∧ qr67Z (qr67Witness_0_17At d) d := by
  decide

private def qr67Witness_0_18 : Array Nat := #[2,3,20,2,3,8,2,3,2,3,12,2,2,3,8,20,2,2,2,2,3,2,3,2,2,2,2,2,2,3,8,2,3,8,8,2,3,2,2,2,3,2,2,3,8,8,20,8,8,2,3,2,3,20,30,8,2,2,2,3,20,2,2,3,2,3,2]
private def qr67Witness_0_18At (d : F67) : F67 :=
  (qr67Witness_0_18.getD d.val 0 : Nat)
private theorem qr67Witness_0_18_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_18At d) 0 ∧ qr67Z (qr67Witness_0_18At d) 0 ∧
    qr67Z (qr67Witness_0_18At d) 18 ∧ qr67Z (qr67Witness_0_18At d) d := by
  decide

private def qr67Witness_0_19 : Array Nat := #[2,3,5,2,3,13,2,3,2,3,13,2,2,3,5,5,2,2,2,2,3,2,3,2,2,2,2,2,2,3,5,2,3,18,5,2,3,2,2,2,3,2,2,3,5,5,13,18,13,2,3,2,3,13,5,18,2,2,2,3,5,2,2,3,2,3,2]
private def qr67Witness_0_19At (d : F67) : F67 :=
  (qr67Witness_0_19.getD d.val 0 : Nat)
private theorem qr67Witness_0_19_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_19At d) 0 ∧ qr67Z (qr67Witness_0_19At d) 0 ∧
    qr67Z (qr67Witness_0_19At d) 19 ∧ qr67Z (qr67Witness_0_19At d) d := by
  decide

private def qr67Witness_0_20 : Array Nat := #[3,3,5,5,3,32,5,3,11,3,28,5,3,3,5,5,27,3,3,3,3,5,3,28,3,3,3,3,3,3,5,5,3,11,5,11,3,11,3,3,3,5,3,3,5,5,11,11,11,27,3,11,3,27,5,31,27,3,3,3,5,5,3,3,5,3,11]
private def qr67Witness_0_20At (d : F67) : F67 :=
  (qr67Witness_0_20.getD d.val 0 : Nat)
private theorem qr67Witness_0_20_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_20At d) 0 ∧ qr67Z (qr67Witness_0_20At d) 0 ∧
    qr67Z (qr67Witness_0_20At d) 20 ∧ qr67Z (qr67Witness_0_20At d) d := by
  decide

private def qr67Witness_0_21 : Array Nat := #[2,12,5,2,7,7,2,12,2,5,12,2,2,7,5,5,2,2,2,2,5,2,5,2,2,2,2,2,2,5,5,2,7,7,5,2,7,2,2,2,5,2,2,7,5,5,7,7,11,2,11,2,5,20,5,20,2,2,2,5,5,2,2,7,2,5,2]
private def qr67Witness_0_21At (d : F67) : F67 :=
  (qr67Witness_0_21.getD d.val 0 : Nat)
private theorem qr67Witness_0_21_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_21At d) 0 ∧ qr67Z (qr67Witness_0_21At d) 0 ∧
    qr67Z (qr67Witness_0_21At d) 21 ∧ qr67Z (qr67Witness_0_21At d) d := by
  decide

private def qr67Witness_0_22 : Array Nat := #[3,3,5,5,3,7,5,3,7,3,12,5,3,3,5,5,7,3,3,3,3,5,3,7,3,3,3,3,3,3,5,5,3,7,5,12,3,8,3,3,3,5,3,3,5,5,7,7,8,12,3,12,3,13,5,8,7,3,3,3,5,5,3,3,5,3,7]
private def qr67Witness_0_22At (d : F67) : F67 :=
  (qr67Witness_0_22.getD d.val 0 : Nat)
private theorem qr67Witness_0_22_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_22At d) 0 ∧ qr67Z (qr67Witness_0_22At d) 0 ∧
    qr67Z (qr67Witness_0_22At d) 22 ∧ qr67Z (qr67Witness_0_22At d) d := by
  decide

private def qr67Witness_0_23 : Array Nat := #[2,8,7,2,7,7,2,34,2,8,13,2,2,7,8,28,2,2,2,2,28,2,7,2,2,2,2,2,2,7,7,2,7,7,8,2,7,2,2,2,7,2,2,7,7,8,7,7,8,2,13,2,13,13,7,8,2,2,2,30,13,2,2,7,2,28,2]
private def qr67Witness_0_23At (d : F67) : F67 :=
  (qr67Witness_0_23.getD d.val 0 : Nat)
private theorem qr67Witness_0_23_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_23At d) 0 ∧ qr67Z (qr67Witness_0_23At d) 0 ∧
    qr67Z (qr67Witness_0_23At d) 23 ∧ qr67Z (qr67Witness_0_23At d) d := by
  decide

private def qr67Witness_0_24 : Array Nat := #[2,3,5,2,3,7,2,3,2,3,18,2,2,3,5,5,2,2,2,2,3,2,3,2,2,2,2,2,2,3,5,2,3,7,5,2,3,2,2,2,3,2,2,3,5,5,7,7,8,2,3,2,3,18,5,8,2,2,2,3,5,2,2,3,2,3,2]
private def qr67Witness_0_24At (d : F67) : F67 :=
  (qr67Witness_0_24.getD d.val 0 : Nat)
private theorem qr67Witness_0_24_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_24At d) 0 ∧ qr67Z (qr67Witness_0_24At d) 0 ∧
    qr67Z (qr67Witness_0_24At d) 24 ∧ qr67Z (qr67Witness_0_24At d) d := by
  decide

private def qr67Witness_0_25 : Array Nat := #[2,3,30,2,3,8,2,3,2,3,28,2,2,3,8,11,2,2,2,2,3,2,3,2,2,2,2,2,2,3,8,2,3,8,8,2,3,2,2,2,3,2,2,3,8,8,11,8,8,2,3,2,3,27,28,8,2,2,2,3,11,2,2,3,2,3,2]
private def qr67Witness_0_25At (d : F67) : F67 :=
  (qr67Witness_0_25.getD d.val 0 : Nat)
private theorem qr67Witness_0_25_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_25At d) 0 ∧ qr67Z (qr67Witness_0_25At d) 0 ∧
    qr67Z (qr67Witness_0_25At d) 25 ∧ qr67Z (qr67Witness_0_25At d) d := by
  decide

private def qr67Witness_0_26 : Array Nat := #[2,3,5,2,3,7,2,3,2,3,12,2,2,3,5,5,2,2,2,2,3,2,3,2,2,2,2,2,2,3,5,2,3,7,5,2,3,2,2,2,3,2,2,3,5,5,7,7,11,2,3,2,3,20,5,20,2,2,2,3,5,2,2,3,2,3,2]
private def qr67Witness_0_26At (d : F67) : F67 :=
  (qr67Witness_0_26.getD d.val 0 : Nat)
private theorem qr67Witness_0_26_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_26At d) 0 ∧ qr67Z (qr67Witness_0_26At d) 0 ∧
    qr67Z (qr67Witness_0_26At d) 26 ∧ qr67Z (qr67Witness_0_26At d) d := by
  decide

private def qr67Witness_0_27 : Array Nat := #[2,3,5,2,3,8,2,3,2,3,12,2,2,3,5,5,2,2,2,2,3,2,3,2,2,2,2,2,2,3,5,2,3,8,5,2,3,2,2,2,3,2,2,3,5,5,11,8,8,2,3,2,3,13,5,8,2,2,2,3,5,2,2,3,2,3,2]
private def qr67Witness_0_27At (d : F67) : F67 :=
  (qr67Witness_0_27.getD d.val 0 : Nat)
private theorem qr67Witness_0_27_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_27At d) 0 ∧ qr67Z (qr67Witness_0_27At d) 0 ∧
    qr67Z (qr67Witness_0_27At d) 27 ∧ qr67Z (qr67Witness_0_27At d) d := by
  decide

private def qr67Witness_0_28 : Array Nat := #[2,3,5,2,3,7,2,3,2,3,12,2,2,3,5,5,2,2,2,2,3,2,3,2,2,2,2,2,2,3,5,2,3,7,5,2,3,2,2,2,3,2,2,3,5,5,7,7,11,2,3,2,3,13,5,18,2,2,2,3,5,2,2,3,2,3,2]
private def qr67Witness_0_28At (d : F67) : F67 :=
  (qr67Witness_0_28.getD d.val 0 : Nat)
private theorem qr67Witness_0_28_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_28At d) 0 ∧ qr67Z (qr67Witness_0_28At d) 0 ∧
    qr67Z (qr67Witness_0_28At d) 28 ∧ qr67Z (qr67Witness_0_28At d) d := by
  decide

private def qr67Witness_0_29 : Array Nat := #[3,3,5,5,3,7,5,3,7,3,12,5,3,3,5,5,7,3,3,3,3,5,3,7,3,3,3,3,3,3,5,5,3,7,5,12,3,8,3,3,3,5,3,3,5,5,7,7,8,12,3,12,3,13,5,8,7,3,3,3,5,5,3,3,5,3,7]
private def qr67Witness_0_29At (d : F67) : F67 :=
  (qr67Witness_0_29.getD d.val 0 : Nat)
private theorem qr67Witness_0_29_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_29At d) 0 ∧ qr67Z (qr67Witness_0_29At d) 0 ∧
    qr67Z (qr67Witness_0_29At d) 29 ∧ qr67Z (qr67Witness_0_29At d) d := by
  decide

private def qr67Witness_0_30 : Array Nat := #[5,8,5,5,7,7,5,20,7,5,13,5,8,7,5,5,7,7,8,5,5,5,5,7,5,8,5,5,5,5,5,5,7,7,5,11,7,8,5,13,5,5,5,7,5,5,7,7,8,13,11,11,5,13,5,8,7,8,11,5,5,5,7,7,5,5,7]
private def qr67Witness_0_30At (d : F67) : F67 :=
  (qr67Witness_0_30.getD d.val 0 : Nat)
private theorem qr67Witness_0_30_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_30At d) 0 ∧ qr67Z (qr67Witness_0_30At d) 0 ∧
    qr67Z (qr67Witness_0_30At d) 30 ∧ qr67Z (qr67Witness_0_30At d) d := by
  decide

private def qr67Witness_0_31 : Array Nat := #[2,8,5,2,7,7,2,12,2,5,12,2,2,7,5,5,2,2,2,2,5,2,5,2,2,2,2,2,2,5,5,2,7,7,5,2,7,2,2,2,5,2,2,7,5,5,7,7,8,2,27,2,5,27,5,8,2,2,2,5,5,2,2,7,2,5,2]
private def qr67Witness_0_31At (d : F67) : F67 :=
  (qr67Witness_0_31.getD d.val 0 : Nat)
private theorem qr67Witness_0_31_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_31At d) 0 ∧ qr67Z (qr67Witness_0_31At d) 0 ∧
    qr67Z (qr67Witness_0_31At d) 31 ∧ qr67Z (qr67Witness_0_31At d) d := by
  decide

private def qr67Witness_0_32 : Array Nat := #[3,3,7,8,3,7,8,3,7,3,13,7,3,3,8,11,7,3,3,3,3,7,3,7,3,3,3,3,3,3,7,7,3,7,8,11,3,8,3,3,3,8,3,3,7,8,7,7,8,13,3,11,3,13,7,8,7,3,3,3,11,7,3,3,8,3,7]
private def qr67Witness_0_32At (d : F67) : F67 :=
  (qr67Witness_0_32.getD d.val 0 : Nat)
private theorem qr67Witness_0_32_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_32At d) 0 ∧ qr67Z (qr67Witness_0_32At d) 0 ∧
    qr67Z (qr67Witness_0_32At d) 32 ∧ qr67Z (qr67Witness_0_32At d) d := by
  decide

private def qr67Witness_0_33 : Array Nat := #[7,8,7,8,7,7,8,12,7,8,12,7,8,7,8,11,7,7,8,18,11,7,7,7,7,8,7,8,7,7,7,7,7,7,8,11,7,8,12,18,7,8,7,7,7,8,7,7,8,12,11,11,12,18,7,8,7,8,11,12,11,7,7,7,8,11,7]
private def qr67Witness_0_33At (d : F67) : F67 :=
  (qr67Witness_0_33.getD d.val 0 : Nat)
private theorem qr67Witness_0_33_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_33At d) 0 ∧ qr67Z (qr67Witness_0_33At d) 0 ∧
    qr67Z (qr67Witness_0_33At d) 33 ∧ qr67Z (qr67Witness_0_33At d) d := by
  decide

private def qr67Witness_0_34 : Array Nat := #[5,8,5,5,11,8,5,12,11,5,12,5,8,12,5,5,12,8,8,5,5,5,5,8,5,8,5,5,5,5,5,5,8,8,5,11,11,8,5,13,5,5,5,8,5,5,11,8,8,12,11,11,5,13,5,8,20,8,11,5,5,5,8,8,5,5,11]
private def qr67Witness_0_34At (d : F67) : F67 :=
  (qr67Witness_0_34.getD d.val 0 : Nat)
private theorem qr67Witness_0_34_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_34At d) 0 ∧ qr67Z (qr67Witness_0_34At d) 0 ∧
    qr67Z (qr67Witness_0_34At d) 34 ∧ qr67Z (qr67Witness_0_34At d) d := by
  decide

private def qr67Witness_0_35 : Array Nat := #[2,12,13,2,11,12,2,12,2,11,12,2,2,12,13,11,2,2,2,2,11,2,12,2,2,2,2,2,2,12,11,2,11,11,11,2,11,2,2,2,11,2,2,18,11,12,11,11,11,2,11,2,12,13,18,18,2,2,2,12,11,2,2,34,2,11,2]
private def qr67Witness_0_35At (d : F67) : F67 :=
  (qr67Witness_0_35.getD d.val 0 : Nat)
private theorem qr67Witness_0_35_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_35At d) 0 ∧ qr67Z (qr67Witness_0_35At d) 0 ∧
    qr67Z (qr67Witness_0_35At d) 35 ∧ qr67Z (qr67Witness_0_35At d) d := by
  decide

private def qr67Witness_0_36 : Array Nat := #[3,3,7,11,3,7,11,3,7,3,12,7,3,3,13,11,7,3,3,3,3,7,3,7,3,3,3,3,3,3,7,7,3,7,11,11,3,11,3,3,3,12,3,3,7,12,7,7,11,12,3,11,3,13,7,20,7,3,3,3,11,7,3,3,27,3,7]
private def qr67Witness_0_36At (d : F67) : F67 :=
  (qr67Witness_0_36.getD d.val 0 : Nat)
private theorem qr67Witness_0_36_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_36At d) 0 ∧ qr67Z (qr67Witness_0_36At d) 0 ∧
    qr67Z (qr67Witness_0_36At d) 36 ∧ qr67Z (qr67Witness_0_36At d) d := by
  decide

private def qr67Witness_0_37 : Array Nat := #[2,8,13,2,11,8,2,12,2,8,12,2,2,12,8,11,2,2,2,2,11,2,8,2,2,2,2,2,2,8,8,2,8,8,8,2,11,2,2,2,11,2,2,8,8,8,11,8,8,2,11,2,12,13,18,8,2,2,2,12,11,2,2,8,2,11,2]
private def qr67Witness_0_37At (d : F67) : F67 :=
  (qr67Witness_0_37.getD d.val 0 : Nat)
private theorem qr67Witness_0_37_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_37At d) 0 ∧ qr67Z (qr67Witness_0_37At d) 0 ∧
    qr67Z (qr67Witness_0_37At d) 37 ∧ qr67Z (qr67Witness_0_37At d) d := by
  decide

private def qr67Witness_0_38 : Array Nat := #[2,3,5,2,3,12,2,3,2,3,12,2,2,3,5,5,2,2,2,2,3,2,3,2,2,2,2,2,2,3,5,2,3,12,5,2,3,2,2,2,3,2,2,3,5,5,13,12,12,2,3,2,3,13,5,32,2,2,2,3,5,2,2,3,2,3,2]
private def qr67Witness_0_38At (d : F67) : F67 :=
  (qr67Witness_0_38.getD d.val 0 : Nat)
private theorem qr67Witness_0_38_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_38At d) 0 ∧ qr67Z (qr67Witness_0_38At d) 0 ∧
    qr67Z (qr67Witness_0_38At d) 38 ∧ qr67Z (qr67Witness_0_38At d) d := by
  decide

private def qr67Witness_0_39 : Array Nat := #[2,3,13,2,3,13,2,3,2,3,13,2,2,3,13,18,2,2,2,2,3,2,3,2,2,2,2,2,2,3,13,2,3,18,13,2,3,2,2,2,3,2,2,3,18,20,13,18,13,2,3,2,3,13,18,18,2,2,2,3,13,2,2,3,2,3,2]
private def qr67Witness_0_39At (d : F67) : F67 :=
  (qr67Witness_0_39.getD d.val 0 : Nat)
private theorem qr67Witness_0_39_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_39At d) 0 ∧ qr67Z (qr67Witness_0_39At d) 0 ∧
    qr67Z (qr67Witness_0_39At d) 39 ∧ qr67Z (qr67Witness_0_39At d) d := by
  decide

private def qr67Witness_0_40 : Array Nat := #[3,3,5,5,3,7,5,3,7,3,18,5,3,3,5,5,7,3,3,3,3,5,3,7,3,3,3,3,3,3,5,5,3,7,5,11,3,11,3,3,3,5,3,3,5,5,7,7,11,30,3,11,3,18,5,18,7,3,3,3,5,5,3,3,5,3,7]
private def qr67Witness_0_40At (d : F67) : F67 :=
  (qr67Witness_0_40.getD d.val 0 : Nat)
private theorem qr67Witness_0_40_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_40At d) 0 ∧ qr67Z (qr67Witness_0_40At d) 0 ∧
    qr67Z (qr67Witness_0_40At d) 40 ∧ qr67Z (qr67Witness_0_40At d) d := by
  decide

private def qr67Witness_0_41 : Array Nat := #[2,8,5,2,12,8,2,12,2,5,12,2,2,12,5,5,2,2,2,2,5,2,5,2,2,2,2,2,2,5,5,2,8,8,5,2,12,2,2,2,5,2,2,8,5,5,20,8,8,2,27,2,5,18,5,8,2,2,2,5,5,2,2,8,2,5,2]
private def qr67Witness_0_41At (d : F67) : F67 :=
  (qr67Witness_0_41.getD d.val 0 : Nat)
private theorem qr67Witness_0_41_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_41At d) 0 ∧ qr67Z (qr67Witness_0_41At d) 0 ∧
    qr67Z (qr67Witness_0_41At d) 41 ∧ qr67Z (qr67Witness_0_41At d) d := by
  decide

private def qr67Witness_0_42 : Array Nat := #[2,3,5,2,3,7,2,3,2,3,13,2,2,3,5,5,2,2,2,2,3,2,3,2,2,2,2,2,2,3,5,2,3,7,5,2,3,2,2,2,3,2,2,3,5,5,7,7,13,2,3,2,3,13,5,18,2,2,2,3,5,2,2,3,2,3,2]
private def qr67Witness_0_42At (d : F67) : F67 :=
  (qr67Witness_0_42.getD d.val 0 : Nat)
private theorem qr67Witness_0_42_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_42At d) 0 ∧ qr67Z (qr67Witness_0_42At d) 0 ∧
    qr67Z (qr67Witness_0_42At d) 42 ∧ qr67Z (qr67Witness_0_42At d) d := by
  decide

private def qr67Witness_0_43 : Array Nat := #[3,3,7,8,3,7,8,3,7,3,18,7,3,3,8,18,7,3,3,3,3,7,3,7,3,3,3,3,3,3,7,7,3,7,8,18,3,8,3,3,3,8,3,3,7,8,7,7,8,20,3,18,3,18,7,8,7,3,3,3,20,7,3,3,8,3,7]
private def qr67Witness_0_43At (d : F67) : F67 :=
  (qr67Witness_0_43.getD d.val 0 : Nat)
private theorem qr67Witness_0_43_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_43At d) 0 ∧ qr67Z (qr67Witness_0_43At d) 0 ∧
    qr67Z (qr67Witness_0_43At d) 43 ∧ qr67Z (qr67Witness_0_43At d) d := by
  decide

private def qr67Witness_0_44 : Array Nat := #[5,8,5,5,7,7,5,18,7,5,18,5,8,7,5,5,7,7,8,5,5,5,5,7,5,8,5,5,5,5,5,5,7,7,5,11,7,8,5,18,5,5,5,7,5,5,7,7,8,20,11,11,5,18,5,8,7,8,11,5,5,5,7,7,5,5,7]
private def qr67Witness_0_44At (d : F67) : F67 :=
  (qr67Witness_0_44.getD d.val 0 : Nat)
private theorem qr67Witness_0_44_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_44At d) 0 ∧ qr67Z (qr67Witness_0_44At d) 0 ∧
    qr67Z (qr67Witness_0_44At d) 44 ∧ qr67Z (qr67Witness_0_44At d) d := by
  decide

private def qr67Witness_0_45 : Array Nat := #[5,8,5,5,12,8,5,12,20,5,12,5,8,12,5,5,12,8,8,5,5,5,5,8,5,8,5,5,5,5,5,5,8,8,5,12,12,8,5,20,5,5,5,8,5,5,20,8,8,12,28,12,5,20,5,8,20,8,41,5,5,5,8,8,5,5,12]
private def qr67Witness_0_45At (d : F67) : F67 :=
  (qr67Witness_0_45.getD d.val 0 : Nat)
private theorem qr67Witness_0_45_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_45At d) 0 ∧ qr67Z (qr67Witness_0_45At d) 0 ∧
    qr67Z (qr67Witness_0_45At d) 45 ∧ qr67Z (qr67Witness_0_45At d) d := by
  decide

private def qr67Witness_0_46 : Array Nat := #[7,13,7,11,7,7,11,20,7,11,13,7,11,7,13,11,7,7,20,13,11,7,7,7,7,11,7,11,7,7,7,7,7,7,11,11,7,11,13,13,7,20,7,7,7,20,7,7,11,13,11,11,13,13,7,20,7,20,11,20,11,7,7,7,27,11,7]
private def qr67Witness_0_46At (d : F67) : F67 :=
  (qr67Witness_0_46.getD d.val 0 : Nat)
private theorem qr67Witness_0_46_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_46At d) 0 ∧ qr67Z (qr67Witness_0_46At d) 0 ∧
    qr67Z (qr67Witness_0_46At d) 46 ∧ qr67Z (qr67Witness_0_46At d) d := by
  decide

private def qr67Witness_0_47 : Array Nat := #[7,8,7,8,7,7,8,12,7,8,12,7,8,7,8,11,7,7,8,18,11,7,7,7,7,8,7,8,7,7,7,7,7,7,8,11,7,8,12,18,7,8,7,7,7,8,7,7,8,12,11,11,12,18,7,8,7,8,11,12,11,7,7,7,8,11,7]
private def qr67Witness_0_47At (d : F67) : F67 :=
  (qr67Witness_0_47.getD d.val 0 : Nat)
private theorem qr67Witness_0_47_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_47At d) 0 ∧ qr67Z (qr67Witness_0_47At d) 0 ∧
    qr67Z (qr67Witness_0_47At d) 47 ∧ qr67Z (qr67Witness_0_47At d) d := by
  decide

private def qr67Witness_0_48 : Array Nat := #[8,8,13,8,11,8,8,12,11,8,12,13,8,12,8,11,12,8,8,13,11,11,8,8,8,8,11,8,11,8,8,8,8,8,8,11,11,8,12,13,11,8,13,8,8,8,11,8,8,12,11,11,12,13,31,8,27,8,11,12,11,12,8,8,8,11,11]
private def qr67Witness_0_48At (d : F67) : F67 :=
  (qr67Witness_0_48.getD d.val 0 : Nat)
private theorem qr67Witness_0_48_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_48At d) 0 ∧ qr67Z (qr67Witness_0_48At d) 0 ∧
    qr67Z (qr67Witness_0_48At d) 48 ∧ qr67Z (qr67Witness_0_48At d) d := by
  decide

private def qr67Witness_0_49 : Array Nat := #[2,12,13,2,12,12,2,12,2,12,12,2,2,12,13,20,2,2,2,2,27,2,12,2,2,2,2,2,2,12,13,2,13,12,12,2,12,2,2,2,30,2,2,20,20,12,13,12,12,2,13,2,12,13,28,20,2,2,2,12,13,2,2,27,2,28,2]
private def qr67Witness_0_49At (d : F67) : F67 :=
  (qr67Witness_0_49.getD d.val 0 : Nat)
private theorem qr67Witness_0_49_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_49At d) 0 ∧ qr67Z (qr67Witness_0_49At d) 0 ∧
    qr67Z (qr67Witness_0_49At d) 49 ∧ qr67Z (qr67Witness_0_49At d) d := by
  decide

private def qr67Witness_0_50 : Array Nat := #[3,3,13,11,3,13,11,3,11,3,13,13,3,3,13,11,27,3,3,3,3,11,3,13,3,3,3,3,3,3,11,27,3,11,11,11,3,11,3,3,3,27,3,3,11,28,11,11,11,13,3,11,3,13,28,31,27,3,3,3,11,28,3,3,27,3,11]
private def qr67Witness_0_50At (d : F67) : F67 :=
  (qr67Witness_0_50.getD d.val 0 : Nat)
private theorem qr67Witness_0_50_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_50At d) 0 ∧ qr67Z (qr67Witness_0_50At d) 0 ∧
    qr67Z (qr67Witness_0_50At d) 50 ∧ qr67Z (qr67Witness_0_50At d) d := by
  decide

private def qr67Witness_0_51 : Array Nat := #[2,12,30,2,11,12,2,12,2,11,12,2,2,12,27,11,2,2,2,2,11,2,12,2,2,2,2,2,2,12,11,2,11,11,11,2,11,2,2,2,11,2,2,18,11,12,11,11,11,2,11,2,12,18,18,18,2,2,2,12,11,2,2,27,2,11,2]
private def qr67Witness_0_51At (d : F67) : F67 :=
  (qr67Witness_0_51.getD d.val 0 : Nat)
private theorem qr67Witness_0_51_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_51At d) 0 ∧ qr67Z (qr67Witness_0_51At d) 0 ∧
    qr67Z (qr67Witness_0_51At d) 51 ∧ qr67Z (qr67Witness_0_51At d) d := by
  decide

private def qr67Witness_0_52 : Array Nat := #[3,3,5,5,3,12,5,3,13,3,12,5,3,3,5,5,12,3,3,3,3,5,3,13,3,3,3,3,3,3,5,5,3,12,5,12,3,12,3,3,3,5,3,3,5,5,13,12,12,12,3,12,3,13,5,30,27,3,3,3,5,5,3,3,5,3,12]
private def qr67Witness_0_52At (d : F67) : F67 :=
  (qr67Witness_0_52.getD d.val 0 : Nat)
private theorem qr67Witness_0_52_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_52At d) 0 ∧ qr67Z (qr67Witness_0_52At d) 0 ∧
    qr67Z (qr67Witness_0_52At d) 52 ∧ qr67Z (qr67Witness_0_52At d) d := by
  decide

private def qr67Witness_0_53 : Array Nat := #[13,13,13,30,31,13,13,18,13,20,13,13,20,18,13,18,18,13,20,13,27,20,13,13,18,27,20,13,13,13,13,27,13,18,13,13,13,13,13,13,18,18,13,18,18,20,13,18,13,13,13,18,13,13,18,18,20,18,18,20,13,28,13,27,27,18,27]
private def qr67Witness_0_53At (d : F67) : F67 :=
  (qr67Witness_0_53.getD d.val 0 : Nat)
private theorem qr67Witness_0_53_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_53At d) 0 ∧ qr67Z (qr67Witness_0_53At d) 0 ∧
    qr67Z (qr67Witness_0_53At d) 53 ∧ qr67Z (qr67Witness_0_53At d) d := by
  decide

private def qr67Witness_0_54 : Array Nat := #[5,28,5,5,7,7,5,18,7,5,18,5,30,7,5,5,7,7,30,5,5,5,5,7,5,28,5,5,5,5,5,5,7,7,5,18,7,18,5,18,5,5,5,7,5,5,7,7,31,28,28,18,5,18,5,18,7,18,18,5,5,5,7,7,5,5,7]
private def qr67Witness_0_54At (d : F67) : F67 :=
  (qr67Witness_0_54.getD d.val 0 : Nat)
private theorem qr67Witness_0_54_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_54At d) 0 ∧ qr67Z (qr67Witness_0_54At d) 0 ∧
    qr67Z (qr67Witness_0_54At d) 54 ∧ qr67Z (qr67Witness_0_54At d) d := by
  decide

private def qr67Witness_0_55 : Array Nat := #[8,8,20,8,31,8,8,18,20,8,18,18,8,18,8,18,18,8,8,18,31,20,8,8,8,8,20,8,18,8,8,8,8,8,8,18,20,8,32,18,18,8,18,8,8,8,20,8,8,20,31,18,30,18,18,8,20,8,18,20,20,32,8,8,8,18,30]
private def qr67Witness_0_55At (d : F67) : F67 :=
  (qr67Witness_0_55.getD d.val 0 : Nat)
private theorem qr67Witness_0_55_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_55At d) 0 ∧ qr67Z (qr67Witness_0_55At d) 0 ∧
    qr67Z (qr67Witness_0_55At d) 55 ∧ qr67Z (qr67Witness_0_55At d) d := by
  decide

private def qr67Witness_0_56 : Array Nat := #[2,31,7,2,7,7,2,20,2,20,30,2,2,7,27,20,2,2,2,2,27,2,7,2,2,2,2,2,2,7,7,2,7,7,20,2,7,2,2,2,7,2,2,7,7,20,7,7,27,2,27,2,27,20,7,20,2,2,2,20,20,2,2,7,2,30,2]
private def qr67Witness_0_56At (d : F67) : F67 :=
  (qr67Witness_0_56.getD d.val 0 : Nat)
private theorem qr67Witness_0_56_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_56At d) 0 ∧ qr67Z (qr67Witness_0_56At d) 0 ∧
    qr67Z (qr67Witness_0_56At d) 56 ∧ qr67Z (qr67Witness_0_56At d) d := by
  decide

private def qr67Witness_0_57 : Array Nat := #[2,3,20,2,3,8,2,3,2,3,18,2,2,3,8,18,2,2,2,2,3,2,3,2,2,2,2,2,2,3,8,2,3,8,8,2,3,2,2,2,3,2,2,3,8,8,20,8,8,2,3,2,3,18,18,8,2,2,2,3,20,2,2,3,2,3,2]
private def qr67Witness_0_57At (d : F67) : F67 :=
  (qr67Witness_0_57.getD d.val 0 : Nat)
private theorem qr67Witness_0_57_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_57At d) 0 ∧ qr67Z (qr67Witness_0_57At d) 0 ∧
    qr67Z (qr67Witness_0_57At d) 57 ∧ qr67Z (qr67Witness_0_57At d) d := by
  decide

private def qr67Witness_0_58 : Array Nat := #[2,3,32,2,3,18,2,3,2,3,18,2,2,3,32,11,2,2,2,2,3,2,3,2,2,2,2,2,2,3,11,2,3,11,11,2,3,2,2,2,3,2,2,3,11,41,11,11,11,2,3,2,3,18,18,18,2,2,2,3,11,2,2,3,2,3,2]
private def qr67Witness_0_58At (d : F67) : F67 :=
  (qr67Witness_0_58.getD d.val 0 : Nat)
private theorem qr67Witness_0_58_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_58At d) 0 ∧ qr67Z (qr67Witness_0_58At d) 0 ∧
    qr67Z (qr67Witness_0_58At d) 58 ∧ qr67Z (qr67Witness_0_58At d) d := by
  decide

private def qr67Witness_0_59 : Array Nat := #[3,3,5,5,3,12,5,3,20,3,12,5,3,3,5,5,12,3,3,3,3,5,3,30,3,3,3,3,3,3,5,5,3,12,5,12,3,12,3,3,3,5,3,3,5,5,20,12,12,12,3,12,3,20,5,20,20,3,3,3,5,5,3,3,5,3,12]
private def qr67Witness_0_59At (d : F67) : F67 :=
  (qr67Witness_0_59.getD d.val 0 : Nat)
private theorem qr67Witness_0_59_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_59At d) 0 ∧ qr67Z (qr67Witness_0_59At d) 0 ∧
    qr67Z (qr67Witness_0_59At d) 59 ∧ qr67Z (qr67Witness_0_59At d) d := by
  decide

private def qr67Witness_0_60 : Array Nat := #[5,13,5,5,11,13,5,20,11,5,13,5,11,20,5,5,27,11,20,5,5,5,5,13,5,11,5,5,5,5,5,5,11,11,5,11,11,11,5,13,5,5,5,20,5,5,11,11,11,13,11,11,5,13,5,20,20,20,11,5,5,5,13,27,5,5,11]
private def qr67Witness_0_60At (d : F67) : F67 :=
  (qr67Witness_0_60.getD d.val 0 : Nat)
private theorem qr67Witness_0_60_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_60At d) 0 ∧ qr67Z (qr67Witness_0_60At d) 0 ∧
    qr67Z (qr67Witness_0_60At d) 60 ∧ qr67Z (qr67Witness_0_60At d) d := by
  decide

private def qr67Witness_0_61 : Array Nat := #[2,12,5,2,7,7,2,12,2,5,12,2,2,7,5,5,2,2,2,2,5,2,5,2,2,2,2,2,2,5,5,2,7,7,5,2,7,2,2,2,5,2,2,7,5,5,7,7,12,2,28,2,5,28,5,32,2,2,2,5,5,2,2,7,2,5,2]
private def qr67Witness_0_61At (d : F67) : F67 :=
  (qr67Witness_0_61.getD d.val 0 : Nat)
private theorem qr67Witness_0_61_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_61At d) 0 ∧ qr67Z (qr67Witness_0_61At d) 0 ∧
    qr67Z (qr67Witness_0_61At d) 61 ∧ qr67Z (qr67Witness_0_61At d) d := by
  decide

private def qr67Witness_0_62 : Array Nat := #[2,3,7,2,3,7,2,3,2,3,13,2,2,3,8,27,2,2,2,2,3,2,3,2,2,2,2,2,2,3,7,2,3,7,8,2,3,2,2,2,3,2,2,3,7,8,7,7,8,2,3,2,3,13,7,8,2,2,2,3,13,2,2,3,2,3,2]
private def qr67Witness_0_62At (d : F67) : F67 :=
  (qr67Witness_0_62.getD d.val 0 : Nat)
private theorem qr67Witness_0_62_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_62At d) 0 ∧ qr67Z (qr67Witness_0_62At d) 0 ∧
    qr67Z (qr67Witness_0_62At d) 62 ∧ qr67Z (qr67Witness_0_62At d) d := by
  decide

private def qr67Witness_0_63 : Array Nat := #[3,3,7,8,3,7,8,3,7,3,28,7,3,3,8,27,7,3,3,3,3,7,3,7,3,3,3,3,3,3,7,7,3,7,8,34,3,8,3,3,3,8,3,3,7,8,7,7,8,27,3,27,3,27,7,8,7,3,3,3,27,7,3,3,8,3,7]
private def qr67Witness_0_63At (d : F67) : F67 :=
  (qr67Witness_0_63.getD d.val 0 : Nat)
private theorem qr67Witness_0_63_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_63At d) 0 ∧ qr67Z (qr67Witness_0_63At d) 0 ∧
    qr67Z (qr67Witness_0_63At d) 63 ∧ qr67Z (qr67Witness_0_63At d) d := by
  decide

private def qr67Witness_0_64 : Array Nat := #[2,8,5,2,31,8,2,27,2,5,28,2,2,31,5,5,2,2,2,2,5,2,5,2,2,2,2,2,2,5,5,2,8,8,5,2,27,2,2,2,5,2,2,8,5,5,27,8,8,2,27,2,5,27,5,8,2,2,2,5,5,2,2,8,2,5,2]
private def qr67Witness_0_64At (d : F67) : F67 :=
  (qr67Witness_0_64.getD d.val 0 : Nat)
private theorem qr67Witness_0_64_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_64At d) 0 ∧ qr67Z (qr67Witness_0_64At d) 0 ∧
    qr67Z (qr67Witness_0_64At d) 64 ∧ qr67Z (qr67Witness_0_64At d) d := by
  decide

private def qr67Witness_0_65 : Array Nat := #[3,3,5,5,3,18,5,3,11,3,18,5,3,3,5,5,18,3,3,3,3,5,3,28,3,3,3,3,3,3,5,5,3,11,5,11,3,11,3,3,3,5,3,3,5,5,11,11,11,28,3,11,3,18,5,18,30,3,3,3,5,5,3,3,5,3,11]
private def qr67Witness_0_65At (d : F67) : F67 :=
  (qr67Witness_0_65.getD d.val 0 : Nat)
private theorem qr67Witness_0_65_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_65At d) 0 ∧ qr67Z (qr67Witness_0_65At d) 0 ∧
    qr67Z (qr67Witness_0_65At d) 65 ∧ qr67Z (qr67Witness_0_65At d) d := by
  decide

private def qr67Witness_0_66 : Array Nat := #[2,12,7,2,7,7,2,12,2,11,12,2,2,7,27,11,2,2,2,2,11,2,7,2,2,2,2,2,2,7,7,2,7,7,11,2,7,2,2,2,7,2,2,7,7,12,7,7,11,2,11,2,12,27,7,30,2,2,2,12,11,2,2,7,2,11,2]
private def qr67Witness_0_66At (d : F67) : F67 :=
  (qr67Witness_0_66.getD d.val 0 : Nat)
private theorem qr67Witness_0_66_correct : ∀ d : F67,
    qr67Z (qr67Witness_0_66At d) 0 ∧ qr67Z (qr67Witness_0_66At d) 0 ∧
    qr67Z (qr67Witness_0_66At d) 66 ∧ qr67Z (qr67Witness_0_66At d) d := by
  decide

theorem qr67_cert_0 :
    ∀ c d : F67, ∃ v : F67, qr67Z v 0 ∧ qr67Z v 0 ∧ qr67Z v c ∧ qr67Z v d := by
  intro c
  fin_cases c
  · exact fun d => ⟨qr67Witness_0_0At d, qr67Witness_0_0_correct d⟩
  · exact fun d => ⟨qr67Witness_0_1At d, qr67Witness_0_1_correct d⟩
  · exact fun d => ⟨qr67Witness_0_2At d, qr67Witness_0_2_correct d⟩
  · exact fun d => ⟨qr67Witness_0_3At d, qr67Witness_0_3_correct d⟩
  · exact fun d => ⟨qr67Witness_0_4At d, qr67Witness_0_4_correct d⟩
  · exact fun d => ⟨qr67Witness_0_5At d, qr67Witness_0_5_correct d⟩
  · exact fun d => ⟨qr67Witness_0_6At d, qr67Witness_0_6_correct d⟩
  · exact fun d => ⟨qr67Witness_0_7At d, qr67Witness_0_7_correct d⟩
  · exact fun d => ⟨qr67Witness_0_8At d, qr67Witness_0_8_correct d⟩
  · exact fun d => ⟨qr67Witness_0_9At d, qr67Witness_0_9_correct d⟩
  · exact fun d => ⟨qr67Witness_0_10At d, qr67Witness_0_10_correct d⟩
  · exact fun d => ⟨qr67Witness_0_11At d, qr67Witness_0_11_correct d⟩
  · exact fun d => ⟨qr67Witness_0_12At d, qr67Witness_0_12_correct d⟩
  · exact fun d => ⟨qr67Witness_0_13At d, qr67Witness_0_13_correct d⟩
  · exact fun d => ⟨qr67Witness_0_14At d, qr67Witness_0_14_correct d⟩
  · exact fun d => ⟨qr67Witness_0_15At d, qr67Witness_0_15_correct d⟩
  · exact fun d => ⟨qr67Witness_0_16At d, qr67Witness_0_16_correct d⟩
  · exact fun d => ⟨qr67Witness_0_17At d, qr67Witness_0_17_correct d⟩
  · exact fun d => ⟨qr67Witness_0_18At d, qr67Witness_0_18_correct d⟩
  · exact fun d => ⟨qr67Witness_0_19At d, qr67Witness_0_19_correct d⟩
  · exact fun d => ⟨qr67Witness_0_20At d, qr67Witness_0_20_correct d⟩
  · exact fun d => ⟨qr67Witness_0_21At d, qr67Witness_0_21_correct d⟩
  · exact fun d => ⟨qr67Witness_0_22At d, qr67Witness_0_22_correct d⟩
  · exact fun d => ⟨qr67Witness_0_23At d, qr67Witness_0_23_correct d⟩
  · exact fun d => ⟨qr67Witness_0_24At d, qr67Witness_0_24_correct d⟩
  · exact fun d => ⟨qr67Witness_0_25At d, qr67Witness_0_25_correct d⟩
  · exact fun d => ⟨qr67Witness_0_26At d, qr67Witness_0_26_correct d⟩
  · exact fun d => ⟨qr67Witness_0_27At d, qr67Witness_0_27_correct d⟩
  · exact fun d => ⟨qr67Witness_0_28At d, qr67Witness_0_28_correct d⟩
  · exact fun d => ⟨qr67Witness_0_29At d, qr67Witness_0_29_correct d⟩
  · exact fun d => ⟨qr67Witness_0_30At d, qr67Witness_0_30_correct d⟩
  · exact fun d => ⟨qr67Witness_0_31At d, qr67Witness_0_31_correct d⟩
  · exact fun d => ⟨qr67Witness_0_32At d, qr67Witness_0_32_correct d⟩
  · exact fun d => ⟨qr67Witness_0_33At d, qr67Witness_0_33_correct d⟩
  · exact fun d => ⟨qr67Witness_0_34At d, qr67Witness_0_34_correct d⟩
  · exact fun d => ⟨qr67Witness_0_35At d, qr67Witness_0_35_correct d⟩
  · exact fun d => ⟨qr67Witness_0_36At d, qr67Witness_0_36_correct d⟩
  · exact fun d => ⟨qr67Witness_0_37At d, qr67Witness_0_37_correct d⟩
  · exact fun d => ⟨qr67Witness_0_38At d, qr67Witness_0_38_correct d⟩
  · exact fun d => ⟨qr67Witness_0_39At d, qr67Witness_0_39_correct d⟩
  · exact fun d => ⟨qr67Witness_0_40At d, qr67Witness_0_40_correct d⟩
  · exact fun d => ⟨qr67Witness_0_41At d, qr67Witness_0_41_correct d⟩
  · exact fun d => ⟨qr67Witness_0_42At d, qr67Witness_0_42_correct d⟩
  · exact fun d => ⟨qr67Witness_0_43At d, qr67Witness_0_43_correct d⟩
  · exact fun d => ⟨qr67Witness_0_44At d, qr67Witness_0_44_correct d⟩
  · exact fun d => ⟨qr67Witness_0_45At d, qr67Witness_0_45_correct d⟩
  · exact fun d => ⟨qr67Witness_0_46At d, qr67Witness_0_46_correct d⟩
  · exact fun d => ⟨qr67Witness_0_47At d, qr67Witness_0_47_correct d⟩
  · exact fun d => ⟨qr67Witness_0_48At d, qr67Witness_0_48_correct d⟩
  · exact fun d => ⟨qr67Witness_0_49At d, qr67Witness_0_49_correct d⟩
  · exact fun d => ⟨qr67Witness_0_50At d, qr67Witness_0_50_correct d⟩
  · exact fun d => ⟨qr67Witness_0_51At d, qr67Witness_0_51_correct d⟩
  · exact fun d => ⟨qr67Witness_0_52At d, qr67Witness_0_52_correct d⟩
  · exact fun d => ⟨qr67Witness_0_53At d, qr67Witness_0_53_correct d⟩
  · exact fun d => ⟨qr67Witness_0_54At d, qr67Witness_0_54_correct d⟩
  · exact fun d => ⟨qr67Witness_0_55At d, qr67Witness_0_55_correct d⟩
  · exact fun d => ⟨qr67Witness_0_56At d, qr67Witness_0_56_correct d⟩
  · exact fun d => ⟨qr67Witness_0_57At d, qr67Witness_0_57_correct d⟩
  · exact fun d => ⟨qr67Witness_0_58At d, qr67Witness_0_58_correct d⟩
  · exact fun d => ⟨qr67Witness_0_59At d, qr67Witness_0_59_correct d⟩
  · exact fun d => ⟨qr67Witness_0_60At d, qr67Witness_0_60_correct d⟩
  · exact fun d => ⟨qr67Witness_0_61At d, qr67Witness_0_61_correct d⟩
  · exact fun d => ⟨qr67Witness_0_62At d, qr67Witness_0_62_correct d⟩
  · exact fun d => ⟨qr67Witness_0_63At d, qr67Witness_0_63_correct d⟩
  · exact fun d => ⟨qr67Witness_0_64At d, qr67Witness_0_64_correct d⟩
  · exact fun d => ⟨qr67Witness_0_65At d, qr67Witness_0_65_correct d⟩
  · exact fun d => ⟨qr67Witness_0_66At d, qr67Witness_0_66_correct d⟩
