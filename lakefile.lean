import Lake
open Lake DSL

package erdos902 where

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "master-2026-05-31"

@[default_target]
lean_lib Erdos902All where
  roots := #[
    `Erdos902All, `Erdos902Arith, `Erdos902Barrier, `Erdos902Bonferroni,
    `Erdos902ClosedForm, `Erdos902Codeg, `Erdos902Conc, `Erdos902Control,
    `Erdos902Counting, `Erdos902Coupling, `Erdos902Cover, `Erdos902Double,
    `Erdos902DropAudit, `Erdos902DRT23, `Erdos902DRT23Design, `Erdos902DominatorCube,
    `Erdos902DRT23Rigidity,
    `Erdos902Existence, `Erdos902F4Step, `Erdos902InNeighbourhood,
    `Erdos902Interaction, `Erdos902Kings, `Erdos902Layer11R35, `Erdos902Layer11R36, `Erdos902Mass, `Erdos902Moment, `Erdos902OddBound,
    `Erdos902Order, `Erdos902Overlap, `Erdos902PrivateCoverBarrier, `Erdos902QR23,
    `Erdos902Capacity, `Erdos902QR67, `Erdos902QR67Base,
    `Erdos902QR67Case0, `Erdos902QR67Case1, `Erdos902QR67Case2, `Erdos902Reach,
    `Erdos902Reid,
    `Erdos902Rigid, `Erdos902Source, `Erdos902Spread, `Erdos902Switch,
    `Erdos902Szekeres, `Erdos902Threshold]
