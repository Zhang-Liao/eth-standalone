import Lake
open Lake DSL

package ethStandalone where
  version := v!"0.1.0"
  leanOptions := #[⟨`autoImplicit, false⟩]
  moreLeanArgs := #["-j1"]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "d13f23b723b8a846827a245b89c10fc7d3f11612"

lean_lib OAI where
  globs := #[.submodules `OAI]

@[default_target]
lean_lib ETH where
  roots := #[`ETH]
