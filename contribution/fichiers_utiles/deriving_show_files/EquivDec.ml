
type 'a coq_EqDec = 'a -> 'a -> bool
  [@@deriving show]

(** val equiv_dec : 'a1 coq_EqDec -> 'a1 -> 'a1 -> bool **)

let equiv_dec eqDec =
  eqDec
