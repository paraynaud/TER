val peq : BinNums.positive -> BinNums.positive -> bool
val plt : BinNums.positive -> BinNums.positive -> bool
val zeq : BinNums.coq_Z -> BinNums.coq_Z -> bool
val zlt : BinNums.coq_Z -> BinNums.coq_Z -> bool
val zle : BinNums.coq_Z -> BinNums.coq_Z -> bool
val coq_Zdivide_dec : BinNums.coq_Z -> BinNums.coq_Z -> bool
val nat_of_Z : BinNums.coq_Z -> Datatypes.nat
val align : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
val option_eq : ('a -> 'b -> bool) -> 'a option -> 'b option -> bool
val option_map : ('a -> 'b) -> 'a option -> 'b option
val sum_left_map :
  ('a -> 'b) -> ('a, 'c) Datatypes.sum -> ('b, 'c) Datatypes.sum
val list_length_z_aux : 'a list -> BinNums.coq_Z -> BinNums.coq_Z
val list_length_z : 'a list -> BinNums.coq_Z
val list_nth_z : 'a list -> BinNums.coq_Z -> 'a option
val list_fold_left : ('a -> 'b -> 'b) -> 'b -> 'a list -> 'b
val list_fold_right : ('a -> 'b -> 'b) -> 'a list -> 'b -> 'b
val list_disjoint_dec : ('a -> 'b -> bool) -> 'b list -> 'a list -> bool
val list_norepet_dec : ('a -> 'a -> bool) -> 'a list -> bool
val list_repeat : Datatypes.nat -> 'a -> 'a list
