type positive = Coq_xI of positive | Coq_xO of positive | Coq_xH
val pp_positive : Format.formatter -> positive -> Ppx_deriving_runtime.unit
val show_positive : positive -> Ppx_deriving_runtime.string
type coq_N = N0 | Npos of positive
val pp_coq_N : Format.formatter -> coq_N -> Ppx_deriving_runtime.unit
val show_coq_N : coq_N -> Ppx_deriving_runtime.string
type coq_Z = Z0 | Zpos of positive | Zneg of positive
val pp_coq_Z : Format.formatter -> coq_Z -> Ppx_deriving_runtime.unit
val show_coq_Z : coq_Z -> Ppx_deriving_runtime.string
