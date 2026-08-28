import Erdos902DRT23

set_option maxHeartbeats 0
set_option maxRecDepth 100000

namespace Erdos902DRT23

private theorem vertex_36_00 : vertexCheck im36 0 = true := by decide
private theorem vertex_36_01 : vertexCheck im36 1 = true := by decide
private theorem vertex_36_02 : vertexCheck im36 2 = true := by decide
private theorem vertex_36_03 : vertexCheck im36 3 = true := by decide
private theorem vertex_36_04 : vertexCheck im36 4 = true := by decide
private theorem vertex_36_05 : vertexCheck im36 5 = true := by decide
private theorem vertex_36_06 : vertexCheck im36 6 = true := by decide
private theorem vertex_36_07 : vertexCheck im36 7 = true := by decide
private theorem vertex_36_08 : vertexCheck im36 8 = true := by decide
private theorem vertex_36_09 : vertexCheck im36 9 = true := by decide
private theorem vertex_36_10 : vertexCheck im36 10 = true := by decide
private theorem vertex_36_11 : vertexCheck im36 11 = true := by decide
private theorem vertex_36_12 : vertexCheck im36 12 = true := by decide
private theorem vertex_36_13 : vertexCheck im36 13 = true := by decide
private theorem vertex_36_14 : vertexCheck im36 14 = true := by decide
private theorem vertex_36_15 : vertexCheck im36 15 = true := by decide
private theorem vertex_36_16 : vertexCheck im36 16 = true := by decide
private theorem vertex_36_17 : vertexCheck im36 17 = true := by decide
private theorem vertex_36_18 : vertexCheck im36 18 = true := by decide
private theorem vertex_36_19 : vertexCheck im36 19 = true := by decide
private theorem vertex_36_20 : vertexCheck im36 20 = true := by decide
private theorem vertex_36_21 : vertexCheck im36 21 = true := by decide
private theorem vertex_36_22 : vertexCheck im36 22 = true := by decide

private theorem pair_36_00 : pairCheck im36 0 = true := by decide
private theorem pair_36_01 : pairCheck im36 1 = true := by decide
private theorem pair_36_02 : pairCheck im36 2 = true := by decide
private theorem pair_36_03 : pairCheck im36 3 = true := by decide
private theorem pair_36_04 : pairCheck im36 4 = true := by decide
private theorem pair_36_05 : pairCheck im36 5 = true := by decide
private theorem pair_36_06 : pairCheck im36 6 = true := by decide
private theorem pair_36_07 : pairCheck im36 7 = true := by decide
private theorem pair_36_08 : pairCheck im36 8 = true := by decide
private theorem pair_36_09 : pairCheck im36 9 = true := by decide
private theorem pair_36_10 : pairCheck im36 10 = true := by decide
private theorem pair_36_11 : pairCheck im36 11 = true := by decide
private theorem pair_36_12 : pairCheck im36 12 = true := by decide
private theorem pair_36_13 : pairCheck im36 13 = true := by decide
private theorem pair_36_14 : pairCheck im36 14 = true := by decide
private theorem pair_36_15 : pairCheck im36 15 = true := by decide
private theorem pair_36_16 : pairCheck im36 16 = true := by decide
private theorem pair_36_17 : pairCheck im36 17 = true := by decide
private theorem pair_36_18 : pairCheck im36 18 = true := by decide
private theorem pair_36_19 : pairCheck im36 19 = true := by decide
private theorem pair_36_20 : pairCheck im36 20 = true := by decide
private theorem pair_36_21 : pairCheck im36 21 = true := by decide
private theorem pair_36_22 : pairCheck im36 22 = true := by decide

/-- The bad 4-sets of row 36 form a `2-(23,4,60)` design: every vertex occurs in 440
blocks and every pair occurs in 60 blocks. -/
theorem bad4_design_36 : bad4DesignCheck im36 = true := by
  simp only [bad4DesignCheck, vertex_36_00, vertex_36_01, vertex_36_02, vertex_36_03, vertex_36_04, vertex_36_05, vertex_36_06, vertex_36_07, vertex_36_08, vertex_36_09, vertex_36_10, vertex_36_11, vertex_36_12, vertex_36_13, vertex_36_14, vertex_36_15, vertex_36_16, vertex_36_17, vertex_36_18, vertex_36_19, vertex_36_20, vertex_36_21, vertex_36_22, pair_36_00, pair_36_01, pair_36_02, pair_36_03, pair_36_04, pair_36_05, pair_36_06, pair_36_07, pair_36_08, pair_36_09, pair_36_10, pair_36_11, pair_36_12, pair_36_13, pair_36_14, pair_36_15, pair_36_16, pair_36_17, pair_36_18, pair_36_19, pair_36_20, pair_36_21, pair_36_22, Bool.and_self]

end Erdos902DRT23

#print axioms Erdos902DRT23.bad4_design_36
