val implb : bool -> bool -> bool
val xorb : bool -> bool -> bool
val negb : bool -> bool
type nat = O | S of nat
val pp_nat : Format.formatter -> nat -> Ppx_deriving_runtime.unit
val show_nat : nat -> Ppx_deriving_runtime.string
type ('a, 'b) sum = Coq_inl of 'a | Coq_inr of 'b
val length : 'a list -> nat
val app : 'a list -> 'a list -> 'a list
type comparison = Eq | Lt | Gt
val coq_CompOpp : comparison -> comparison
type coq_CompareSpecT = CompEqT | CompLtT | CompGtT
val coq_CompareSpec2Type : comparison -> coq_CompareSpecT
type 'a coq_CompSpecT = coq_CompareSpecT
val coq_CompSpec2Type : 'a -> 'b -> comparison -> coq_CompareSpecT
