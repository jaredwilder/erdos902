import Lake
open Lake DSL

package erdos902 where

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "master-2026-05-31"

@[default_target]
lean_lib Erdos902All where
  roots := #[`Erdos902All]
