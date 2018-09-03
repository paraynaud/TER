val coq_Zeven : BinNums.coq_Z -> bool
type radix = BinNums.coq_Z
val radix_val : 'a -> 'a
val radix2 : BinNums.coq_Z
val cond_Zopp : bool -> BinNums.coq_Z -> BinNums.coq_Z
val coq_Zpos_div_eucl_aux1 :
  BinNums.positive -> BinNums.positive -> BinNums.coq_Z * BinNums.coq_Z
val coq_Zpos_div_eucl_aux :
  BinNums.positive -> BinNums.positive -> BinNums.coq_Z * BinNums.coq_Z
val coq_Zfast_div_eucl :
  BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z * BinNums.coq_Z
val iter_nat : ('a -> 'a) -> Datatypes.nat -> 'a -> 'a
val iter_pos : ('a -> 'a) -> BinNums.positive -> 'a -> 'a
