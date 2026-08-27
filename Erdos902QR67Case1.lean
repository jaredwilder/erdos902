import Erdos902QR67Base

private def qr67Witness_1_0 : Array Nat := #[3,3,13,8,3,8,8,3,13,3,12,13,3,3,8,28,12,3,3,3,3,12,3,8,3,3,3,3,3,3,8,8,3,8,8,12,3,8,3,3,3,8,3,3,8,8,13,8,8,12,3,12,3,13,28,8,31,3,3,3,13,12,3,3,8,3,12]
private def qr67Witness_1_0At (d : F67) : F67 :=
  (qr67Witness_1_0.getD d.val 0 : Nat)
private theorem qr67Witness_1_0_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_0At d) 0 ∧ qr67Z (qr67Witness_1_0At d) 1 ∧
    qr67Z (qr67Witness_1_0At d) 0 ∧ qr67Z (qr67Witness_1_0At d) d := by
  decide

private def qr67Witness_1_1 : Array Nat := #[3,3,13,8,3,8,8,3,13,3,12,13,3,3,8,28,12,3,3,3,3,12,3,8,3,3,3,3,3,3,8,8,3,8,8,12,3,8,3,3,3,8,3,3,8,8,13,8,8,12,3,12,3,13,28,8,31,3,3,3,13,12,3,3,8,3,12]
private def qr67Witness_1_1At (d : F67) : F67 :=
  (qr67Witness_1_1.getD d.val 0 : Nat)
private theorem qr67Witness_1_1_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_1At d) 0 ∧ qr67Z (qr67Witness_1_1At d) 1 ∧
    qr67Z (qr67Witness_1_1At d) 1 ∧ qr67Z (qr67Witness_1_1At d) d := by
  decide

private def qr67Witness_1_2 : Array Nat := #[13,13,13,44,32,13,13,45,13,43,13,13,32,43,13,43,43,13,45,13,32,32,13,13,32,32,44,13,13,13,13,43,13,32,13,13,13,13,13,13,43,32,13,45,43,44,13,32,13,13,13,32,13,13,32,32,32,32,32,43,13,32,13,44,43,32,43]
private def qr67Witness_1_2At (d : F67) : F67 :=
  (qr67Witness_1_2.getD d.val 0 : Nat)
private theorem qr67Witness_1_2_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_2At d) 0 ∧ qr67Z (qr67Witness_1_2At d) 1 ∧
    qr67Z (qr67Witness_1_2At d) 2 ∧ qr67Z (qr67Witness_1_2At d) d := by
  decide

private def qr67Witness_1_3 : Array Nat := #[8,8,44,8,31,8,8,45,46,8,44,31,8,31,8,45,44,8,8,31,31,51,8,8,8,8,31,8,31,8,8,8,8,8,8,31,44,8,45,44,31,8,44,8,8,8,31,8,8,45,31,45,31,31,31,8,31,8,44,44,31,44,8,8,8,44,31]
private def qr67Witness_1_3At (d : F67) : F67 :=
  (qr67Witness_1_3.getD d.val 0 : Nat)
private theorem qr67Witness_1_3_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_3At d) 0 ∧ qr67Z (qr67Witness_1_3At d) 1 ∧
    qr67Z (qr67Witness_1_3At d) 3 ∧ qr67Z (qr67Witness_1_3At d) d := by
  decide

private def qr67Witness_1_4 : Array Nat := #[3,3,32,31,3,12,52,3,42,3,12,31,3,3,32,42,12,3,3,3,3,12,3,31,3,3,3,3,3,3,32,12,3,12,12,12,3,12,3,3,3,12,3,3,46,12,31,12,12,12,3,12,3,31,31,31,31,3,3,3,31,12,3,3,31,3,12]
private def qr67Witness_1_4At (d : F67) : F67 :=
  (qr67Witness_1_4.getD d.val 0 : Nat)
private theorem qr67Witness_1_4_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_4At d) 0 ∧ qr67Z (qr67Witness_1_4At d) 1 ∧
    qr67Z (qr67Witness_1_4At d) 4 ∧ qr67Z (qr67Witness_1_4At d) d := by
  decide

private def qr67Witness_1_5 : Array Nat := #[8,8,13,8,12,8,8,12,13,8,12,13,8,12,8,43,12,8,8,13,32,12,8,8,8,8,12,8,12,8,8,8,8,8,8,12,12,8,12,13,43,8,13,8,8,8,13,8,8,12,13,12,12,13,32,8,32,8,32,12,13,12,8,8,8,32,12]
private def qr67Witness_1_5At (d : F67) : F67 :=
  (qr67Witness_1_5.getD d.val 0 : Nat)
private theorem qr67Witness_1_5_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_5At d) 0 ∧ qr67Z (qr67Witness_1_5At d) 1 ∧
    qr67Z (qr67Witness_1_5At d) 5 ∧ qr67Z (qr67Witness_1_5At d) d := by
  decide

private def qr67Witness_1_6 : Array Nat := #[8,8,13,8,52,8,8,51,13,8,13,13,8,44,8,58,44,8,8,13,51,51,8,8,8,8,44,8,13,8,8,8,8,8,8,13,13,8,13,13,51,8,13,8,8,8,13,8,8,13,13,58,13,13,44,8,52,8,44,44,13,44,8,8,8,44,44]
private def qr67Witness_1_6At (d : F67) : F67 :=
  (qr67Witness_1_6.getD d.val 0 : Nat)
private theorem qr67Witness_1_6_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_6At d) 0 ∧ qr67Z (qr67Witness_1_6At d) 1 ∧
    qr67Z (qr67Witness_1_6At d) 6 ∧ qr67Z (qr67Witness_1_6At d) d := by
  decide

private def qr67Witness_1_7 : Array Nat := #[3,3,45,45,3,12,51,3,51,3,12,45,3,3,45,45,12,3,3,3,3,12,3,51,3,3,3,3,3,3,58,12,3,12,12,12,3,12,3,3,3,12,3,3,51,12,45,12,12,12,3,12,3,52,45,45,52,3,3,3,45,12,3,3,45,3,12]
private def qr67Witness_1_7At (d : F67) : F67 :=
  (qr67Witness_1_7.getD d.val 0 : Nat)
private theorem qr67Witness_1_7_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_7At d) 0 ∧ qr67Z (qr67Witness_1_7At d) 1 ∧
    qr67Z (qr67Witness_1_7At d) 7 ∧ qr67Z (qr67Witness_1_7At d) d := by
  decide

private def qr67Witness_1_8 : Array Nat := #[13,13,13,46,42,13,13,51,13,51,13,13,42,51,13,28,28,13,46,13,28,28,13,13,42,28,28,13,13,13,13,42,13,46,13,13,13,13,13,13,42,46,13,28,28,28,13,28,13,13,13,28,13,13,28,46,42,28,42,42,13,28,13,28,28,28,42]
private def qr67Witness_1_8At (d : F67) : F67 :=
  (qr67Witness_1_8.getD d.val 0 : Nat)
private theorem qr67Witness_1_8_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_8At d) 0 ∧ qr67Z (qr67Witness_1_8At d) 1 ∧
    qr67Z (qr67Witness_1_8At d) 8 ∧ qr67Z (qr67Witness_1_8At d) d := by
  decide

private def qr67Witness_1_9 : Array Nat := #[3,3,43,8,3,8,8,3,51,3,12,43,3,3,8,43,12,3,3,3,3,12,3,8,3,3,3,3,3,3,8,8,3,8,8,12,3,8,3,3,3,8,3,3,8,8,51,8,8,12,3,12,3,43,53,8,52,3,3,3,43,12,3,3,8,3,12]
private def qr67Witness_1_9At (d : F67) : F67 :=
  (qr67Witness_1_9.getD d.val 0 : Nat)
private theorem qr67Witness_1_9_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_9At d) 0 ∧ qr67Z (qr67Witness_1_9At d) 1 ∧
    qr67Z (qr67Witness_1_9At d) 9 ∧ qr67Z (qr67Witness_1_9At d) d := by
  decide

private def qr67Witness_1_10 : Array Nat := #[12,12,13,44,12,12,13,12,13,12,12,13,42,12,13,28,12,13,12,13,28,12,12,13,42,28,12,12,12,12,13,12,13,12,12,12,12,12,12,13,42,12,13,28,28,12,13,12,12,12,13,12,12,13,28,51,42,28,42,12,13,12,13,28,28,28,12]
private def qr67Witness_1_10At (d : F67) : F67 :=
  (qr67Witness_1_10.getD d.val 0 : Nat)
private theorem qr67Witness_1_10_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_10At d) 0 ∧ qr67Z (qr67Witness_1_10At d) 1 ∧
    qr67Z (qr67Witness_1_10At d) 10 ∧ qr67Z (qr67Witness_1_10At d) d := by
  decide

private def qr67Witness_1_11 : Array Nat := #[13,13,13,31,31,13,13,45,13,43,13,13,42,31,13,42,43,13,31,13,31,52,13,13,31,43,31,13,13,13,13,42,13,45,13,13,13,13,13,13,31,31,13,42,43,31,13,31,13,13,13,42,13,13,31,31,31,31,42,42,13,42,13,42,31,42,31]
private def qr67Witness_1_11At (d : F67) : F67 :=
  (qr67Witness_1_11.getD d.val 0 : Nat)
private theorem qr67Witness_1_11_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_11At d) 0 ∧ qr67Z (qr67Witness_1_11At d) 1 ∧
    qr67Z (qr67Witness_1_11At d) 11 ∧ qr67Z (qr67Witness_1_11At d) d := by
  decide

private def qr67Witness_1_12 : Array Nat := #[3,3,32,8,3,8,8,3,42,3,42,42,3,3,8,42,43,3,3,3,3,32,3,8,3,3,3,3,3,3,8,8,3,8,8,42,3,8,3,3,3,8,3,3,8,8,32,8,8,32,3,32,3,32,32,8,32,3,3,3,43,32,3,3,8,3,42]
private def qr67Witness_1_12At (d : F67) : F67 :=
  (qr67Witness_1_12.getD d.val 0 : Nat)
private theorem qr67Witness_1_12_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_12At d) 0 ∧ qr67Z (qr67Witness_1_12At d) 1 ∧
    qr67Z (qr67Witness_1_12At d) 12 ∧ qr67Z (qr67Witness_1_12At d) d := by
  decide

private def qr67Witness_1_13 : Array Nat := #[3,3,43,31,3,12,44,3,51,3,12,31,3,3,44,43,12,3,3,3,3,12,3,31,3,3,3,3,3,3,43,12,3,12,12,12,3,12,3,3,3,12,3,3,43,12,31,12,12,12,3,12,3,31,31,31,31,3,3,3,31,12,3,3,31,3,12]
private def qr67Witness_1_13At (d : F67) : F67 :=
  (qr67Witness_1_13.getD d.val 0 : Nat)
private theorem qr67Witness_1_13_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_13At d) 0 ∧ qr67Z (qr67Witness_1_13At d) 1 ∧
    qr67Z (qr67Witness_1_13At d) 13 ∧ qr67Z (qr67Witness_1_13At d) d := by
  decide

private def qr67Witness_1_14 : Array Nat := #[8,8,13,8,32,8,8,45,13,8,13,13,8,44,8,42,44,8,8,13,32,32,8,8,8,8,44,8,13,8,8,8,8,8,8,13,13,8,13,13,42,8,13,8,8,8,13,8,8,13,13,32,13,13,32,8,32,8,32,42,13,32,8,8,8,32,42]
private def qr67Witness_1_14At (d : F67) : F67 :=
  (qr67Witness_1_14.getD d.val 0 : Nat)
private theorem qr67Witness_1_14_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_14At d) 0 ∧ qr67Z (qr67Witness_1_14At d) 1 ∧
    qr67Z (qr67Witness_1_14At d) 14 ∧ qr67Z (qr67Witness_1_14At d) d := by
  decide

private def qr67Witness_1_15 : Array Nat := #[28,28,43,45,42,43,58,45,28,43,28,42,42,43,42,28,28,28,45,46,28,28,42,28,42,28,28,45,46,28,42,42,28,45,28,42,43,28,28,42,42,43,28,28,28,28,42,28,42,28,28,28,28,28,28,45,42,28,42,42,43,28,43,28,28,28,42]
private def qr67Witness_1_15At (d : F67) : F67 :=
  (qr67Witness_1_15.getD d.val 0 : Nat)
private theorem qr67Witness_1_15_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_15At d) 0 ∧ qr67Z (qr67Witness_1_15At d) 1 ∧
    qr67Z (qr67Witness_1_15At d) 15 ∧ qr67Z (qr67Witness_1_15At d) d := by
  decide

private def qr67Witness_1_16 : Array Nat := #[12,12,43,44,12,12,44,12,28,12,12,43,43,12,44,28,12,28,12,46,28,12,12,28,44,28,12,12,12,12,43,12,28,12,12,12,12,12,12,44,43,12,28,28,28,12,58,12,12,12,28,12,12,28,28,46,46,28,43,12,43,12,43,28,28,28,12]
private def qr67Witness_1_16At (d : F67) : F67 :=
  (qr67Witness_1_16.getD d.val 0 : Nat)
private theorem qr67Witness_1_16_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_16At d) 0 ∧ qr67Z (qr67Witness_1_16At d) 1 ∧
    qr67Z (qr67Witness_1_16At d) 16 ∧ qr67Z (qr67Witness_1_16At d) d := by
  decide

private def qr67Witness_1_17 : Array Nat := #[3,3,13,8,3,8,8,3,13,3,13,13,3,3,8,28,28,3,3,3,3,28,3,8,3,3,3,3,3,3,8,8,3,8,8,13,3,8,3,3,3,8,3,3,8,8,13,8,8,13,3,28,3,13,28,8,58,3,3,3,13,28,3,3,8,3,44]
private def qr67Witness_1_17At (d : F67) : F67 :=
  (qr67Witness_1_17.getD d.val 0 : Nat)
private theorem qr67Witness_1_17_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_17At d) 0 ∧ qr67Z (qr67Witness_1_17At d) 1 ∧
    qr67Z (qr67Witness_1_17At d) 17 ∧ qr67Z (qr67Witness_1_17At d) d := by
  decide

private def qr67Witness_1_18 : Array Nat := #[3,3,45,8,3,8,8,3,46,3,12,31,3,3,8,45,12,3,3,3,3,12,3,8,3,3,3,3,3,3,8,8,3,8,8,12,3,8,3,3,3,8,3,3,8,8,31,8,8,12,3,12,3,31,31,8,31,3,3,3,31,12,3,3,8,3,12]
private def qr67Witness_1_18At (d : F67) : F67 :=
  (qr67Witness_1_18.getD d.val 0 : Nat)
private theorem qr67Witness_1_18_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_18At d) 0 ∧ qr67Z (qr67Witness_1_18At d) 1 ∧
    qr67Z (qr67Witness_1_18At d) 18 ∧ qr67Z (qr67Witness_1_18At d) d := by
  decide

private def qr67Witness_1_19 : Array Nat := #[3,3,13,31,3,13,13,3,13,3,13,13,3,3,13,46,46,3,3,3,3,32,3,13,3,3,3,3,3,3,13,51,3,32,13,13,3,13,3,3,3,31,3,3,46,31,13,31,13,13,3,32,3,13,31,31,31,3,3,3,13,32,3,3,31,3,31]
private def qr67Witness_1_19At (d : F67) : F67 :=
  (qr67Witness_1_19.getD d.val 0 : Nat)
private theorem qr67Witness_1_19_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_19At d) 0 ∧ qr67Z (qr67Witness_1_19At d) 1 ∧
    qr67Z (qr67Witness_1_19At d) 19 ∧ qr67Z (qr67Witness_1_19At d) d := by
  decide

private def qr67Witness_1_20 : Array Nat := #[3,3,32,31,3,32,51,3,28,3,28,31,3,3,32,28,28,3,3,3,3,28,3,28,3,3,3,3,3,3,32,51,3,32,28,31,3,28,3,3,3,31,3,3,28,28,31,28,31,28,3,28,3,28,28,31,31,3,3,3,31,28,3,3,28,3,31]
private def qr67Witness_1_20At (d : F67) : F67 :=
  (qr67Witness_1_20.getD d.val 0 : Nat)
private theorem qr67Witness_1_20_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_20At d) 0 ∧ qr67Z (qr67Witness_1_20At d) 1 ∧
    qr67Z (qr67Witness_1_20At d) 20 ∧ qr67Z (qr67Witness_1_20At d) d := by
  decide

private def qr67Witness_1_21 : Array Nat := #[12,12,32,51,12,12,51,12,28,12,12,52,32,12,32,28,12,28,12,32,28,12,12,28,32,28,12,12,12,12,32,12,28,12,12,12,12,12,12,51,51,12,28,28,28,12,32,12,12,12,28,12,12,28,28,32,32,28,32,12,51,12,52,28,28,28,12]
private def qr67Witness_1_21At (d : F67) : F67 :=
  (qr67Witness_1_21.getD d.val 0 : Nat)
private theorem qr67Witness_1_21_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_21At d) 0 ∧ qr67Z (qr67Witness_1_21At d) 1 ∧
    qr67Z (qr67Witness_1_21At d) 21 ∧ qr67Z (qr67Witness_1_21At d) d := by
  decide

private def qr67Witness_1_22 : Array Nat := #[3,3,13,8,3,8,8,3,13,3,12,13,3,3,8,42,12,3,3,3,3,12,3,8,3,3,3,3,3,3,8,8,3,8,8,12,3,8,3,3,3,8,3,3,8,8,13,8,8,12,3,12,3,13,53,8,42,3,3,3,13,12,3,3,8,3,12]
private def qr67Witness_1_22At (d : F67) : F67 :=
  (qr67Witness_1_22.getD d.val 0 : Nat)
private theorem qr67Witness_1_22_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_22At d) 0 ∧ qr67Z (qr67Witness_1_22At d) 1 ∧
    qr67Z (qr67Witness_1_22At d) 22 ∧ qr67Z (qr67Witness_1_22At d) d := by
  decide

private def qr67Witness_1_23 : Array Nat := #[8,8,13,8,31,8,8,51,13,8,13,13,8,31,8,28,28,8,8,13,28,28,8,8,8,8,28,8,13,8,8,8,8,8,8,13,13,8,13,13,31,8,13,8,8,8,13,8,8,13,13,28,13,13,28,8,31,8,43,43,13,28,8,8,8,28,31]
private def qr67Witness_1_23At (d : F67) : F67 :=
  (qr67Witness_1_23.getD d.val 0 : Nat)
private theorem qr67Witness_1_23_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_23At d) 0 ∧ qr67Z (qr67Witness_1_23At d) 1 ∧
    qr67Z (qr67Witness_1_23At d) 23 ∧ qr67Z (qr67Witness_1_23At d) d := by
  decide

private def qr67Witness_1_24 : Array Nat := #[3,3,32,8,3,8,8,3,42,3,42,31,3,3,8,42,44,3,3,3,3,32,3,8,3,3,3,3,3,3,8,8,3,8,8,31,3,8,3,3,3,8,3,3,8,8,31,8,8,32,3,32,3,31,31,8,31,3,3,3,31,32,3,3,8,3,31]
private def qr67Witness_1_24At (d : F67) : F67 :=
  (qr67Witness_1_24.getD d.val 0 : Nat)
private theorem qr67Witness_1_24_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_24At d) 0 ∧ qr67Z (qr67Witness_1_24At d) 1 ∧
    qr67Z (qr67Witness_1_24At d) 24 ∧ qr67Z (qr67Witness_1_24At d) d := by
  decide

private def qr67Witness_1_25 : Array Nat := #[3,3,32,8,3,8,8,3,28,3,28,43,3,3,8,28,28,3,3,3,3,28,3,8,3,3,3,3,3,3,8,8,3,8,8,43,3,8,3,3,3,8,3,3,8,8,32,8,8,28,3,28,3,28,28,8,32,3,3,3,43,28,3,3,8,3,43]
private def qr67Witness_1_25At (d : F67) : F67 :=
  (qr67Witness_1_25.getD d.val 0 : Nat)
private theorem qr67Witness_1_25_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_25At d) 0 ∧ qr67Z (qr67Witness_1_25At d) 1 ∧
    qr67Z (qr67Witness_1_25At d) 25 ∧ qr67Z (qr67Witness_1_25At d) d := by
  decide

private def qr67Witness_1_26 : Array Nat := #[3,3,44,31,3,12,44,3,28,3,12,31,3,3,44,28,12,3,3,3,3,12,3,28,3,3,3,3,3,3,58,12,3,12,12,12,3,12,3,3,3,12,3,3,28,12,31,12,12,12,3,12,3,28,28,31,31,3,3,3,31,12,3,3,28,3,12]
private def qr67Witness_1_26At (d : F67) : F67 :=
  (qr67Witness_1_26.getD d.val 0 : Nat)
private theorem qr67Witness_1_26_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_26At d) 0 ∧ qr67Z (qr67Witness_1_26At d) 1 ∧
    qr67Z (qr67Witness_1_26At d) 26 ∧ qr67Z (qr67Witness_1_26At d) d := by
  decide

private def qr67Witness_1_27 : Array Nat := #[3,3,13,8,3,8,8,3,13,3,12,13,3,3,8,45,12,3,3,3,3,12,3,8,3,3,3,3,3,3,8,8,3,8,8,12,3,8,3,3,3,8,3,3,8,8,13,8,8,12,3,12,3,13,32,8,32,3,3,3,13,12,3,3,8,3,12]
private def qr67Witness_1_27At (d : F67) : F67 :=
  (qr67Witness_1_27.getD d.val 0 : Nat)
private theorem qr67Witness_1_27_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_27At d) 0 ∧ qr67Z (qr67Witness_1_27At d) 1 ∧
    qr67Z (qr67Witness_1_27At d) 27 ∧ qr67Z (qr67Witness_1_27At d) d := by
  decide

private def qr67Witness_1_28 : Array Nat := #[3,3,13,31,3,12,13,3,13,3,12,13,3,3,13,46,12,3,3,3,3,12,3,13,3,3,3,3,3,3,13,12,3,12,12,12,3,12,3,3,3,12,3,3,46,12,13,12,12,12,3,12,3,13,31,31,31,3,3,3,13,12,3,3,31,3,12]
private def qr67Witness_1_28At (d : F67) : F67 :=
  (qr67Witness_1_28.getD d.val 0 : Nat)
private theorem qr67Witness_1_28_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_28At d) 0 ∧ qr67Z (qr67Witness_1_28At d) 1 ∧
    qr67Z (qr67Witness_1_28At d) 28 ∧ qr67Z (qr67Witness_1_28At d) d := by
  decide

private def qr67Witness_1_29 : Array Nat := #[3,3,13,8,3,8,8,3,13,3,12,13,3,3,8,28,12,3,3,3,3,12,3,8,3,3,3,3,3,3,8,8,3,8,8,12,3,8,3,3,3,8,3,3,8,8,13,8,8,12,3,12,3,13,28,8,31,3,3,3,13,12,3,3,8,3,12]
private def qr67Witness_1_29At (d : F67) : F67 :=
  (qr67Witness_1_29.getD d.val 0 : Nat)
private theorem qr67Witness_1_29_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_29At d) 0 ∧ qr67Z (qr67Witness_1_29At d) 1 ∧
    qr67Z (qr67Witness_1_29At d) 29 ∧ qr67Z (qr67Witness_1_29At d) d := by
  decide

private def qr67Witness_1_30 : Array Nat := #[8,8,13,8,32,8,8,58,13,8,13,13,8,43,8,42,43,8,8,13,32,32,8,8,8,8,58,8,13,8,8,8,8,8,8,13,13,8,13,13,42,8,13,8,8,8,13,8,8,13,13,32,13,13,32,8,32,8,32,42,13,32,8,8,8,32,42]
private def qr67Witness_1_30At (d : F67) : F67 :=
  (qr67Witness_1_30.getD d.val 0 : Nat)
private theorem qr67Witness_1_30_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_30At d) 0 ∧ qr67Z (qr67Witness_1_30At d) 1 ∧
    qr67Z (qr67Witness_1_30At d) 30 ∧ qr67Z (qr67Witness_1_30At d) d := by
  decide

private def qr67Witness_1_31 : Array Nat := #[8,8,43,8,12,8,8,12,42,8,12,42,8,12,8,42,12,8,8,51,51,12,8,8,8,8,12,8,12,8,8,8,8,8,8,12,12,8,12,42,42,8,44,8,8,8,42,8,8,12,44,12,12,43,44,8,42,8,42,12,43,12,8,8,8,42,12]
private def qr67Witness_1_31At (d : F67) : F67 :=
  (qr67Witness_1_31.getD d.val 0 : Nat)
private theorem qr67Witness_1_31_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_31At d) 0 ∧ qr67Z (qr67Witness_1_31At d) 1 ∧
    qr67Z (qr67Witness_1_31At d) 31 ∧ qr67Z (qr67Witness_1_31At d) d := by
  decide

private def qr67Witness_1_32 : Array Nat := #[3,3,13,8,3,8,8,3,13,3,13,13,3,3,8,28,28,3,3,3,3,28,3,8,3,3,3,3,3,3,8,8,3,8,8,13,3,8,3,3,3,8,3,3,8,8,13,8,8,13,3,28,3,13,28,8,31,3,3,3,13,28,3,3,8,3,31]
private def qr67Witness_1_32At (d : F67) : F67 :=
  (qr67Witness_1_32.getD d.val 0 : Nat)
private theorem qr67Witness_1_32_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_32At d) 0 ∧ qr67Z (qr67Witness_1_32At d) 1 ∧
    qr67Z (qr67Witness_1_32At d) 32 ∧ qr67Z (qr67Witness_1_32At d) d := by
  decide

private def qr67Witness_1_33 : Array Nat := #[8,8,32,8,12,8,8,12,46,8,12,45,8,12,8,45,12,8,8,32,32,12,8,8,8,8,12,8,12,8,8,8,8,8,8,12,12,8,12,44,45,8,32,8,8,8,32,8,8,12,44,12,12,32,32,8,32,8,32,12,44,12,8,8,8,32,12]
private def qr67Witness_1_33At (d : F67) : F67 :=
  (qr67Witness_1_33.getD d.val 0 : Nat)
private theorem qr67Witness_1_33_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_33At d) 0 ∧ qr67Z (qr67Witness_1_33At d) 1 ∧
    qr67Z (qr67Witness_1_33At d) 33 ∧ qr67Z (qr67Witness_1_33At d) d := by
  decide

private def qr67Witness_1_34 : Array Nat := #[8,8,13,8,12,8,8,12,13,8,12,13,8,12,8,28,12,8,8,13,28,12,8,8,8,8,12,8,12,8,8,8,8,8,8,12,12,8,12,13,42,8,13,8,8,8,13,8,8,12,13,12,12,13,28,8,42,8,42,12,13,12,8,8,8,28,12]
private def qr67Witness_1_34At (d : F67) : F67 :=
  (qr67Witness_1_34.getD d.val 0 : Nat)
private theorem qr67Witness_1_34_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_34At d) 0 ∧ qr67Z (qr67Witness_1_34At d) 1 ∧
    qr67Z (qr67Witness_1_34At d) 34 ∧ qr67Z (qr67Witness_1_34At d) d := by
  decide

private def qr67Witness_1_35 : Array Nat := #[12,12,13,31,12,12,13,12,13,12,12,13,42,12,13,42,12,13,12,13,31,12,12,13,31,43,12,12,12,12,13,12,13,12,12,12,12,12,12,13,31,12,13,42,43,12,13,12,12,12,13,12,12,13,31,31,31,31,42,12,13,12,13,42,31,42,12]
private def qr67Witness_1_35At (d : F67) : F67 :=
  (qr67Witness_1_35.getD d.val 0 : Nat)
private theorem qr67Witness_1_35_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_35At d) 0 ∧ qr67Z (qr67Witness_1_35At d) 1 ∧
    qr67Z (qr67Witness_1_35At d) 35 ∧ qr67Z (qr67Witness_1_35At d) d := by
  decide

private def qr67Witness_1_36 : Array Nat := #[3,3,13,44,3,12,13,3,13,3,12,13,3,3,13,43,12,3,3,3,3,12,3,13,3,3,3,3,3,3,13,12,3,12,12,12,3,12,3,3,3,12,3,3,43,12,13,12,12,12,3,12,3,13,32,32,32,3,3,3,13,12,3,3,43,3,12]
private def qr67Witness_1_36At (d : F67) : F67 :=
  (qr67Witness_1_36.getD d.val 0 : Nat)
private theorem qr67Witness_1_36_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_36At d) 0 ∧ qr67Z (qr67Witness_1_36At d) 1 ∧
    qr67Z (qr67Witness_1_36At d) 36 ∧ qr67Z (qr67Witness_1_36At d) d := by
  decide

private def qr67Witness_1_37 : Array Nat := #[8,8,13,8,12,8,8,12,13,8,12,13,8,12,8,28,12,8,8,13,28,12,8,8,8,8,12,8,12,8,8,8,8,8,8,12,12,8,12,13,31,8,13,8,8,8,13,8,8,12,13,12,12,13,28,8,31,8,42,12,13,12,8,8,8,28,12]
private def qr67Witness_1_37At (d : F67) : F67 :=
  (qr67Witness_1_37.getD d.val 0 : Nat)
private theorem qr67Witness_1_37_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_37At d) 0 ∧ qr67Z (qr67Witness_1_37At d) 1 ∧
    qr67Z (qr67Witness_1_37At d) 37 ∧ qr67Z (qr67Witness_1_37At d) d := by
  decide

private def qr67Witness_1_38 : Array Nat := #[3,3,13,45,3,12,13,3,13,3,12,13,3,3,13,28,12,3,3,3,3,12,3,13,3,3,3,3,3,3,13,12,3,12,12,12,3,12,3,3,3,12,3,3,28,12,13,12,12,12,3,12,3,13,28,32,32,3,3,3,13,12,3,3,28,3,12]
private def qr67Witness_1_38At (d : F67) : F67 :=
  (qr67Witness_1_38.getD d.val 0 : Nat)
private theorem qr67Witness_1_38_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_38At d) 0 ∧ qr67Z (qr67Witness_1_38At d) 1 ∧
    qr67Z (qr67Witness_1_38At d) 38 ∧ qr67Z (qr67Witness_1_38At d) d := by
  decide

private def qr67Witness_1_39 : Array Nat := #[3,3,13,44,3,13,13,3,13,3,13,13,3,3,13,42,44,3,3,3,3,51,3,13,3,3,3,3,3,3,13,42,3,44,13,13,3,13,3,3,3,44,3,3,46,44,13,46,13,13,3,42,3,13,44,46,42,3,3,3,13,42,3,3,42,3,42]
private def qr67Witness_1_39At (d : F67) : F67 :=
  (qr67Witness_1_39.getD d.val 0 : Nat)
private theorem qr67Witness_1_39_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_39At d) 0 ∧ qr67Z (qr67Witness_1_39At d) 1 ∧
    qr67Z (qr67Witness_1_39At d) 39 ∧ qr67Z (qr67Witness_1_39At d) d := by
  decide

private def qr67Witness_1_40 : Array Nat := #[3,3,43,31,3,43,51,3,42,3,42,31,3,3,42,42,43,3,3,3,3,51,3,31,3,3,3,3,3,3,42,42,3,45,42,31,3,31,3,3,3,31,3,3,43,31,31,31,31,43,3,42,3,31,31,31,31,3,3,3,31,42,3,3,31,3,31]
private def qr67Witness_1_40At (d : F67) : F67 :=
  (qr67Witness_1_40.getD d.val 0 : Nat)
private theorem qr67Witness_1_40_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_40At d) 0 ∧ qr67Z (qr67Witness_1_40At d) 1 ∧
    qr67Z (qr67Witness_1_40At d) 40 ∧ qr67Z (qr67Witness_1_40At d) d := by
  decide

private def qr67Witness_1_41 : Array Nat := #[8,8,32,8,12,8,8,12,46,8,12,31,8,12,8,43,12,8,8,31,31,12,8,8,8,8,12,8,12,8,8,8,8,8,8,12,12,8,12,44,31,8,32,8,8,8,31,8,8,12,31,12,12,31,31,8,31,8,32,12,31,12,8,8,8,32,12]
private def qr67Witness_1_41At (d : F67) : F67 :=
  (qr67Witness_1_41.getD d.val 0 : Nat)
private theorem qr67Witness_1_41_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_41At d) 0 ∧ qr67Z (qr67Witness_1_41At d) 1 ∧
    qr67Z (qr67Witness_1_41At d) 41 ∧ qr67Z (qr67Witness_1_41At d) d := by
  decide

private def qr67Witness_1_42 : Array Nat := #[3,3,13,44,3,13,13,3,13,3,13,13,3,3,13,28,28,3,3,3,3,28,3,13,3,3,3,3,3,3,13,44,3,32,13,13,3,13,3,3,3,32,3,3,28,28,13,28,13,13,3,28,3,13,28,32,32,3,3,3,13,28,3,3,28,3,44]
private def qr67Witness_1_42At (d : F67) : F67 :=
  (qr67Witness_1_42.getD d.val 0 : Nat)
private theorem qr67Witness_1_42_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_42At d) 0 ∧ qr67Z (qr67Witness_1_42At d) 1 ∧
    qr67Z (qr67Witness_1_42At d) 42 ∧ qr67Z (qr67Witness_1_42At d) d := by
  decide

private def qr67Witness_1_43 : Array Nat := #[3,3,45,8,3,8,8,3,28,3,28,42,3,3,8,28,28,3,3,3,3,28,3,8,3,3,3,3,3,3,8,8,3,8,8,42,3,8,3,3,3,8,3,3,8,8,42,8,8,28,3,28,3,28,28,8,42,3,3,3,45,28,3,3,8,3,42]
private def qr67Witness_1_43At (d : F67) : F67 :=
  (qr67Witness_1_43.getD d.val 0 : Nat)
private theorem qr67Witness_1_43_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_43At d) 0 ∧ qr67Z (qr67Witness_1_43At d) 1 ∧
    qr67Z (qr67Witness_1_43At d) 43 ∧ qr67Z (qr67Witness_1_43At d) d := by
  decide

private def qr67Witness_1_44 : Array Nat := #[8,8,43,8,46,8,8,51,28,8,28,43,8,43,8,28,28,8,8,46,28,28,8,8,8,8,28,8,46,8,8,8,8,8,8,43,43,8,28,46,43,8,28,8,8,8,51,8,8,28,28,28,28,28,28,8,46,8,43,43,43,28,8,8,8,28,43]
private def qr67Witness_1_44At (d : F67) : F67 :=
  (qr67Witness_1_44.getD d.val 0 : Nat)
private theorem qr67Witness_1_44_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_44At d) 0 ∧ qr67Z (qr67Witness_1_44At d) 1 ∧
    qr67Z (qr67Witness_1_44At d) 44 ∧ qr67Z (qr67Witness_1_44At d) d := by
  decide

private def qr67Witness_1_45 : Array Nat := #[8,8,44,8,12,8,8,12,28,8,12,31,8,12,8,28,12,8,8,31,28,12,8,8,8,8,12,8,12,8,8,8,8,8,8,12,12,8,12,44,31,8,28,8,8,8,31,8,8,12,28,12,12,28,28,8,31,8,44,12,31,12,8,8,8,28,12]
private def qr67Witness_1_45At (d : F67) : F67 :=
  (qr67Witness_1_45.getD d.val 0 : Nat)
private theorem qr67Witness_1_45_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_45At d) 0 ∧ qr67Z (qr67Witness_1_45At d) 1 ∧
    qr67Z (qr67Witness_1_45At d) 45 ∧ qr67Z (qr67Witness_1_45At d) d := by
  decide

private def qr67Witness_1_46 : Array Nat := #[13,13,13,31,31,13,13,45,13,51,13,13,32,31,13,42,58,13,31,13,31,32,13,13,31,32,31,13,13,13,13,42,13,32,13,13,13,13,13,13,31,31,13,42,51,31,13,31,13,13,13,32,13,13,31,31,31,31,32,42,13,32,13,42,31,32,31]
private def qr67Witness_1_46At (d : F67) : F67 :=
  (qr67Witness_1_46.getD d.val 0 : Nat)
private theorem qr67Witness_1_46_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_46At d) 0 ∧ qr67Z (qr67Witness_1_46At d) 1 ∧
    qr67Z (qr67Witness_1_46At d) 46 ∧ qr67Z (qr67Witness_1_46At d) d := by
  decide

private def qr67Witness_1_47 : Array Nat := #[8,8,32,8,12,8,8,12,28,8,12,31,8,12,8,28,12,8,8,31,28,12,8,8,8,8,12,8,12,8,8,8,8,8,8,12,12,8,12,46,31,8,28,8,8,8,31,8,8,12,28,12,12,28,28,8,31,8,32,12,31,12,8,8,8,28,12]
private def qr67Witness_1_47At (d : F67) : F67 :=
  (qr67Witness_1_47.getD d.val 0 : Nat)
private theorem qr67Witness_1_47_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_47At d) 0 ∧ qr67Z (qr67Witness_1_47At d) 1 ∧
    qr67Z (qr67Witness_1_47At d) 47 ∧ qr67Z (qr67Witness_1_47At d) d := by
  decide

private def qr67Witness_1_48 : Array Nat := #[8,8,13,8,12,8,8,12,13,8,12,13,8,12,8,42,12,8,8,13,31,12,8,8,8,8,12,8,12,8,8,8,8,8,8,12,12,8,12,13,31,8,13,8,8,8,13,8,8,12,13,12,12,13,31,8,31,8,32,12,13,12,8,8,8,32,12]
private def qr67Witness_1_48At (d : F67) : F67 :=
  (qr67Witness_1_48.getD d.val 0 : Nat)
private theorem qr67Witness_1_48_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_48At d) 0 ∧ qr67Z (qr67Witness_1_48At d) 1 ∧
    qr67Z (qr67Witness_1_48At d) 48 ∧ qr67Z (qr67Witness_1_48At d) d := by
  decide

private def qr67Witness_1_49 : Array Nat := #[12,12,13,45,12,12,13,12,13,12,12,13,32,12,13,28,12,13,12,13,28,12,12,13,32,28,12,12,12,12,13,12,13,12,12,12,12,12,12,13,43,12,13,28,28,12,13,12,12,12,13,12,12,13,28,32,32,28,32,12,13,12,13,28,28,28,12]
private def qr67Witness_1_49At (d : F67) : F67 :=
  (qr67Witness_1_49.getD d.val 0 : Nat)
private theorem qr67Witness_1_49_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_49At d) 0 ∧ qr67Z (qr67Witness_1_49At d) 1 ∧
    qr67Z (qr67Witness_1_49At d) 49 ∧ qr67Z (qr67Witness_1_49At d) d := by
  decide

private def qr67Witness_1_50 : Array Nat := #[3,3,13,31,3,13,13,3,13,3,13,13,3,3,13,28,28,3,3,3,3,28,3,13,3,3,3,3,3,3,13,44,3,44,13,13,3,13,3,3,3,31,3,3,28,28,13,28,13,13,3,28,3,13,28,31,31,3,3,3,13,28,3,3,28,3,31]
private def qr67Witness_1_50At (d : F67) : F67 :=
  (qr67Witness_1_50.getD d.val 0 : Nat)
private theorem qr67Witness_1_50_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_50At d) 0 ∧ qr67Z (qr67Witness_1_50At d) 1 ∧
    qr67Z (qr67Witness_1_50At d) 50 ∧ qr67Z (qr67Witness_1_50At d) d := by
  decide

private def qr67Witness_1_51 : Array Nat := #[12,12,32,45,12,12,58,12,28,12,12,42,32,12,32,28,12,28,12,32,28,12,12,28,32,28,12,12,12,12,32,12,28,12,12,12,12,12,12,42,42,12,28,28,28,12,32,12,12,12,28,12,12,28,28,32,32,28,32,12,45,12,45,28,28,28,12]
private def qr67Witness_1_51At (d : F67) : F67 :=
  (qr67Witness_1_51.getD d.val 0 : Nat)
private theorem qr67Witness_1_51_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_51At d) 0 ∧ qr67Z (qr67Witness_1_51At d) 1 ∧
    qr67Z (qr67Witness_1_51At d) 51 ∧ qr67Z (qr67Witness_1_51At d) d := by
  decide

private def qr67Witness_1_52 : Array Nat := #[3,3,13,31,3,12,13,3,13,3,12,13,3,3,13,28,12,3,3,3,3,12,3,13,3,3,3,3,3,3,13,12,3,12,12,12,3,12,3,3,3,12,3,3,28,12,13,12,12,12,3,12,3,13,28,31,31,3,3,3,13,12,3,3,28,3,12]
private def qr67Witness_1_52At (d : F67) : F67 :=
  (qr67Witness_1_52.getD d.val 0 : Nat)
private theorem qr67Witness_1_52_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_52At d) 0 ∧ qr67Z (qr67Witness_1_52At d) 1 ∧
    qr67Z (qr67Witness_1_52At d) 52 ∧ qr67Z (qr67Witness_1_52At d) d := by
  decide

private def qr67Witness_1_53 : Array Nat := #[13,13,13,31,31,13,13,52,13,43,13,13,32,31,13,28,28,13,31,13,28,28,13,13,31,28,28,13,13,13,13,43,13,32,13,13,13,13,13,13,31,31,13,28,28,28,13,28,13,13,13,28,13,13,28,31,31,28,32,43,13,28,13,28,28,28,31]
private def qr67Witness_1_53At (d : F67) : F67 :=
  (qr67Witness_1_53.getD d.val 0 : Nat)
private theorem qr67Witness_1_53_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_53At d) 0 ∧ qr67Z (qr67Witness_1_53At d) 1 ∧
    qr67Z (qr67Witness_1_53At d) 53 ∧ qr67Z (qr67Witness_1_53At d) d := by
  decide

private def qr67Witness_1_54 : Array Nat := #[28,28,32,31,31,32,44,45,28,53,28,31,32,31,32,28,28,28,31,31,28,28,53,28,31,28,28,32,31,28,32,44,28,32,28,31,32,28,28,44,31,31,28,28,28,28,31,28,31,28,28,28,28,28,28,31,31,28,32,44,31,28,45,28,28,28,31]
private def qr67Witness_1_54At (d : F67) : F67 :=
  (qr67Witness_1_54.getD d.val 0 : Nat)
private theorem qr67Witness_1_54_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_54At d) 0 ∧ qr67Z (qr67Witness_1_54At d) 1 ∧
    qr67Z (qr67Witness_1_54At d) 54 ∧ qr67Z (qr67Witness_1_54At d) d := by
  decide

private def qr67Witness_1_55 : Array Nat := #[8,8,32,8,31,8,8,45,46,8,51,31,8,31,8,45,46,8,8,31,31,32,8,8,8,8,31,8,31,8,8,8,8,8,8,31,32,8,32,46,31,8,32,8,8,8,31,8,8,32,31,32,31,31,31,8,31,8,32,45,31,32,8,8,8,32,31]
private def qr67Witness_1_55At (d : F67) : F67 :=
  (qr67Witness_1_55.getD d.val 0 : Nat)
private theorem qr67Witness_1_55_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_55At d) 0 ∧ qr67Z (qr67Witness_1_55At d) 1 ∧
    qr67Z (qr67Witness_1_55At d) 55 ∧ qr67Z (qr67Witness_1_55At d) d := by
  decide

private def qr67Witness_1_56 : Array Nat := #[31,31,32,31,31,32,52,52,42,52,42,31,32,31,32,42,46,58,31,31,31,32,42,31,31,32,31,32,31,31,32,42,31,32,42,31,32,31,32,42,31,31,32,42,46,31,31,31,31,32,31,32,31,31,31,31,31,31,32,42,31,32,46,42,31,32,31]
private def qr67Witness_1_56At (d : F67) : F67 :=
  (qr67Witness_1_56.getD d.val 0 : Nat)
private theorem qr67Witness_1_56_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_56At d) 0 ∧ qr67Z (qr67Witness_1_56At d) 1 ∧
    qr67Z (qr67Witness_1_56At d) 56 ∧ qr67Z (qr67Witness_1_56At d) d := by
  decide

private def qr67Witness_1_57 : Array Nat := #[3,3,32,8,3,8,8,3,28,3,28,31,3,3,8,28,28,3,3,3,3,28,3,8,3,3,3,3,3,3,8,8,3,8,8,31,3,8,3,3,3,8,3,3,8,8,31,8,8,28,3,28,3,28,28,8,31,3,3,3,31,28,3,3,8,3,31]
private def qr67Witness_1_57At (d : F67) : F67 :=
  (qr67Witness_1_57.getD d.val 0 : Nat)
private theorem qr67Witness_1_57_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_57At d) 0 ∧ qr67Z (qr67Witness_1_57At d) 1 ∧
    qr67Z (qr67Witness_1_57At d) 57 ∧ qr67Z (qr67Witness_1_57At d) d := by
  decide

private def qr67Witness_1_58 : Array Nat := #[3,3,32,44,3,32,44,3,42,3,42,42,3,3,32,42,43,3,3,3,3,32,3,43,3,3,3,3,3,3,32,42,3,32,42,42,3,42,3,3,3,32,3,3,43,44,32,32,32,32,3,32,3,32,32,32,32,3,3,3,43,32,3,3,42,3,42]
private def qr67Witness_1_58At (d : F67) : F67 :=
  (qr67Witness_1_58.getD d.val 0 : Nat)
private theorem qr67Witness_1_58_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_58At d) 0 ∧ qr67Z (qr67Witness_1_58At d) 1 ∧
    qr67Z (qr67Witness_1_58At d) 58 ∧ qr67Z (qr67Witness_1_58At d) d := by
  decide

private def qr67Witness_1_59 : Array Nat := #[3,3,43,44,3,12,44,3,42,3,12,42,3,3,42,42,12,3,3,3,3,12,3,43,3,3,3,3,3,3,42,12,3,12,12,12,3,12,3,3,3,12,3,3,43,12,42,12,12,12,3,12,3,43,44,45,42,3,3,3,43,12,3,3,42,3,12]
private def qr67Witness_1_59At (d : F67) : F67 :=
  (qr67Witness_1_59.getD d.val 0 : Nat)
private theorem qr67Witness_1_59_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_59At d) 0 ∧ qr67Z (qr67Witness_1_59At d) 1 ∧
    qr67Z (qr67Witness_1_59At d) 59 ∧ qr67Z (qr67Witness_1_59At d) d := by
  decide

private def qr67Witness_1_60 : Array Nat := #[13,13,13,31,31,13,13,45,13,43,13,13,43,31,13,43,43,13,31,13,31,51,13,13,31,43,31,13,13,13,13,43,13,44,13,13,13,13,13,13,31,31,13,45,43,31,13,31,13,13,13,45,13,13,31,31,31,31,43,43,13,44,13,44,31,43,31]
private def qr67Witness_1_60At (d : F67) : F67 :=
  (qr67Witness_1_60.getD d.val 0 : Nat)
private theorem qr67Witness_1_60_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_60At d) 0 ∧ qr67Z (qr67Witness_1_60At d) 1 ∧
    qr67Z (qr67Witness_1_60At d) 60 ∧ qr67Z (qr67Witness_1_60At d) d := by
  decide

private def qr67Witness_1_61 : Array Nat := #[12,12,32,44,12,12,44,12,28,12,12,42,32,12,32,28,12,28,12,32,28,12,12,28,32,28,12,12,12,12,32,12,28,12,12,12,12,12,12,42,42,12,28,28,28,12,32,12,12,12,28,12,12,28,28,32,32,28,32,12,44,12,45,28,28,28,12]
private def qr67Witness_1_61At (d : F67) : F67 :=
  (qr67Witness_1_61.getD d.val 0 : Nat)
private theorem qr67Witness_1_61_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_61At d) 0 ∧ qr67Z (qr67Witness_1_61At d) 1 ∧
    qr67Z (qr67Witness_1_61At d) 61 ∧ qr67Z (qr67Witness_1_61At d) d := by
  decide

private def qr67Witness_1_62 : Array Nat := #[3,3,13,8,3,8,8,3,13,3,13,13,3,3,8,43,43,3,3,3,3,52,3,8,3,3,3,3,3,3,8,8,3,8,8,13,3,8,3,3,3,8,3,3,8,8,13,8,8,13,3,45,3,13,45,8,46,3,3,3,13,45,3,3,8,3,43]
private def qr67Witness_1_62At (d : F67) : F67 :=
  (qr67Witness_1_62.getD d.val 0 : Nat)
private theorem qr67Witness_1_62_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_62At d) 0 ∧ qr67Z (qr67Witness_1_62At d) 1 ∧
    qr67Z (qr67Witness_1_62At d) 62 ∧ qr67Z (qr67Witness_1_62At d) d := by
  decide

private def qr67Witness_1_63 : Array Nat := #[3,3,44,8,3,8,8,3,28,3,28,42,3,3,8,28,28,3,3,3,3,28,3,8,3,3,3,3,3,3,8,8,3,8,8,42,3,8,3,3,3,8,3,3,8,8,42,8,8,28,3,28,3,28,28,8,42,3,3,3,44,28,3,3,8,3,42]
private def qr67Witness_1_63At (d : F67) : F67 :=
  (qr67Witness_1_63.getD d.val 0 : Nat)
private theorem qr67Witness_1_63_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_63At d) 0 ∧ qr67Z (qr67Witness_1_63At d) 1 ∧
    qr67Z (qr67Witness_1_63At d) 63 ∧ qr67Z (qr67Witness_1_63At d) d := by
  decide

private def qr67Witness_1_64 : Array Nat := #[8,8,43,8,31,8,8,45,28,8,28,31,8,31,8,28,28,8,8,31,28,28,8,8,8,8,28,8,31,8,8,8,8,8,8,31,43,8,28,42,31,8,28,8,8,8,31,8,8,28,28,28,28,28,28,8,31,8,42,42,31,28,8,8,8,28,31]
private def qr67Witness_1_64At (d : F67) : F67 :=
  (qr67Witness_1_64.getD d.val 0 : Nat)
private theorem qr67Witness_1_64_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_64At d) 0 ∧ qr67Z (qr67Witness_1_64At d) 1 ∧
    qr67Z (qr67Witness_1_64At d) 64 ∧ qr67Z (qr67Witness_1_64At d) d := by
  decide

private def qr67Witness_1_65 : Array Nat := #[3,3,32,44,3,32,44,3,28,3,28,42,3,3,32,28,28,3,3,3,3,28,3,28,3,3,3,3,3,3,32,42,3,32,28,42,3,28,3,3,3,32,3,3,28,28,32,28,32,28,3,28,3,28,28,32,32,3,3,3,43,28,3,3,28,3,42]
private def qr67Witness_1_65At (d : F67) : F67 :=
  (qr67Witness_1_65.getD d.val 0 : Nat)
private theorem qr67Witness_1_65_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_65At d) 0 ∧ qr67Z (qr67Witness_1_65At d) 1 ∧
    qr67Z (qr67Witness_1_65At d) 65 ∧ qr67Z (qr67Witness_1_65At d) d := by
  decide

private def qr67Witness_1_66 : Array Nat := #[12,12,43,31,12,12,44,12,42,12,12,31,42,12,42,42,12,44,12,31,31,12,12,31,31,43,12,12,12,12,42,12,31,12,12,12,12,12,12,42,31,12,44,42,43,12,31,12,12,12,31,12,12,31,31,31,31,31,42,12,31,12,43,42,31,42,12]
private def qr67Witness_1_66At (d : F67) : F67 :=
  (qr67Witness_1_66.getD d.val 0 : Nat)
private theorem qr67Witness_1_66_correct : ∀ d : F67,
    qr67Z (qr67Witness_1_66At d) 0 ∧ qr67Z (qr67Witness_1_66At d) 1 ∧
    qr67Z (qr67Witness_1_66At d) 66 ∧ qr67Z (qr67Witness_1_66At d) d := by
  decide

theorem qr67_cert_1 :
    ∀ c d : F67, ∃ v : F67, qr67Z v 0 ∧ qr67Z v 1 ∧ qr67Z v c ∧ qr67Z v d := by
  intro c
  fin_cases c
  · exact fun d => ⟨qr67Witness_1_0At d, qr67Witness_1_0_correct d⟩
  · exact fun d => ⟨qr67Witness_1_1At d, qr67Witness_1_1_correct d⟩
  · exact fun d => ⟨qr67Witness_1_2At d, qr67Witness_1_2_correct d⟩
  · exact fun d => ⟨qr67Witness_1_3At d, qr67Witness_1_3_correct d⟩
  · exact fun d => ⟨qr67Witness_1_4At d, qr67Witness_1_4_correct d⟩
  · exact fun d => ⟨qr67Witness_1_5At d, qr67Witness_1_5_correct d⟩
  · exact fun d => ⟨qr67Witness_1_6At d, qr67Witness_1_6_correct d⟩
  · exact fun d => ⟨qr67Witness_1_7At d, qr67Witness_1_7_correct d⟩
  · exact fun d => ⟨qr67Witness_1_8At d, qr67Witness_1_8_correct d⟩
  · exact fun d => ⟨qr67Witness_1_9At d, qr67Witness_1_9_correct d⟩
  · exact fun d => ⟨qr67Witness_1_10At d, qr67Witness_1_10_correct d⟩
  · exact fun d => ⟨qr67Witness_1_11At d, qr67Witness_1_11_correct d⟩
  · exact fun d => ⟨qr67Witness_1_12At d, qr67Witness_1_12_correct d⟩
  · exact fun d => ⟨qr67Witness_1_13At d, qr67Witness_1_13_correct d⟩
  · exact fun d => ⟨qr67Witness_1_14At d, qr67Witness_1_14_correct d⟩
  · exact fun d => ⟨qr67Witness_1_15At d, qr67Witness_1_15_correct d⟩
  · exact fun d => ⟨qr67Witness_1_16At d, qr67Witness_1_16_correct d⟩
  · exact fun d => ⟨qr67Witness_1_17At d, qr67Witness_1_17_correct d⟩
  · exact fun d => ⟨qr67Witness_1_18At d, qr67Witness_1_18_correct d⟩
  · exact fun d => ⟨qr67Witness_1_19At d, qr67Witness_1_19_correct d⟩
  · exact fun d => ⟨qr67Witness_1_20At d, qr67Witness_1_20_correct d⟩
  · exact fun d => ⟨qr67Witness_1_21At d, qr67Witness_1_21_correct d⟩
  · exact fun d => ⟨qr67Witness_1_22At d, qr67Witness_1_22_correct d⟩
  · exact fun d => ⟨qr67Witness_1_23At d, qr67Witness_1_23_correct d⟩
  · exact fun d => ⟨qr67Witness_1_24At d, qr67Witness_1_24_correct d⟩
  · exact fun d => ⟨qr67Witness_1_25At d, qr67Witness_1_25_correct d⟩
  · exact fun d => ⟨qr67Witness_1_26At d, qr67Witness_1_26_correct d⟩
  · exact fun d => ⟨qr67Witness_1_27At d, qr67Witness_1_27_correct d⟩
  · exact fun d => ⟨qr67Witness_1_28At d, qr67Witness_1_28_correct d⟩
  · exact fun d => ⟨qr67Witness_1_29At d, qr67Witness_1_29_correct d⟩
  · exact fun d => ⟨qr67Witness_1_30At d, qr67Witness_1_30_correct d⟩
  · exact fun d => ⟨qr67Witness_1_31At d, qr67Witness_1_31_correct d⟩
  · exact fun d => ⟨qr67Witness_1_32At d, qr67Witness_1_32_correct d⟩
  · exact fun d => ⟨qr67Witness_1_33At d, qr67Witness_1_33_correct d⟩
  · exact fun d => ⟨qr67Witness_1_34At d, qr67Witness_1_34_correct d⟩
  · exact fun d => ⟨qr67Witness_1_35At d, qr67Witness_1_35_correct d⟩
  · exact fun d => ⟨qr67Witness_1_36At d, qr67Witness_1_36_correct d⟩
  · exact fun d => ⟨qr67Witness_1_37At d, qr67Witness_1_37_correct d⟩
  · exact fun d => ⟨qr67Witness_1_38At d, qr67Witness_1_38_correct d⟩
  · exact fun d => ⟨qr67Witness_1_39At d, qr67Witness_1_39_correct d⟩
  · exact fun d => ⟨qr67Witness_1_40At d, qr67Witness_1_40_correct d⟩
  · exact fun d => ⟨qr67Witness_1_41At d, qr67Witness_1_41_correct d⟩
  · exact fun d => ⟨qr67Witness_1_42At d, qr67Witness_1_42_correct d⟩
  · exact fun d => ⟨qr67Witness_1_43At d, qr67Witness_1_43_correct d⟩
  · exact fun d => ⟨qr67Witness_1_44At d, qr67Witness_1_44_correct d⟩
  · exact fun d => ⟨qr67Witness_1_45At d, qr67Witness_1_45_correct d⟩
  · exact fun d => ⟨qr67Witness_1_46At d, qr67Witness_1_46_correct d⟩
  · exact fun d => ⟨qr67Witness_1_47At d, qr67Witness_1_47_correct d⟩
  · exact fun d => ⟨qr67Witness_1_48At d, qr67Witness_1_48_correct d⟩
  · exact fun d => ⟨qr67Witness_1_49At d, qr67Witness_1_49_correct d⟩
  · exact fun d => ⟨qr67Witness_1_50At d, qr67Witness_1_50_correct d⟩
  · exact fun d => ⟨qr67Witness_1_51At d, qr67Witness_1_51_correct d⟩
  · exact fun d => ⟨qr67Witness_1_52At d, qr67Witness_1_52_correct d⟩
  · exact fun d => ⟨qr67Witness_1_53At d, qr67Witness_1_53_correct d⟩
  · exact fun d => ⟨qr67Witness_1_54At d, qr67Witness_1_54_correct d⟩
  · exact fun d => ⟨qr67Witness_1_55At d, qr67Witness_1_55_correct d⟩
  · exact fun d => ⟨qr67Witness_1_56At d, qr67Witness_1_56_correct d⟩
  · exact fun d => ⟨qr67Witness_1_57At d, qr67Witness_1_57_correct d⟩
  · exact fun d => ⟨qr67Witness_1_58At d, qr67Witness_1_58_correct d⟩
  · exact fun d => ⟨qr67Witness_1_59At d, qr67Witness_1_59_correct d⟩
  · exact fun d => ⟨qr67Witness_1_60At d, qr67Witness_1_60_correct d⟩
  · exact fun d => ⟨qr67Witness_1_61At d, qr67Witness_1_61_correct d⟩
  · exact fun d => ⟨qr67Witness_1_62At d, qr67Witness_1_62_correct d⟩
  · exact fun d => ⟨qr67Witness_1_63At d, qr67Witness_1_63_correct d⟩
  · exact fun d => ⟨qr67Witness_1_64At d, qr67Witness_1_64_correct d⟩
  · exact fun d => ⟨qr67Witness_1_65At d, qr67Witness_1_65_correct d⟩
  · exact fun d => ⟨qr67Witness_1_66At d, qr67Witness_1_66_correct d⟩
