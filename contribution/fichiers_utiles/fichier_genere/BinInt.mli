module Z :
  sig
    val double : BinNums.coq_Z -> BinNums.coq_Z
    val succ_double : BinNums.coq_Z -> BinNums.coq_Z
    val pred_double : BinNums.coq_Z -> BinNums.coq_Z
    val pos_sub : BinNums.positive -> BinNums.positive -> BinNums.coq_Z
    val add : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val opp : BinNums.coq_Z -> BinNums.coq_Z
    val succ : BinNums.coq_Z -> BinNums.coq_Z
    val pred : BinNums.coq_Z -> BinNums.coq_Z
    val sub : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val mul : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val pow_pos : BinNums.coq_Z -> BinNums.positive -> BinNums.coq_Z
    val pow : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val compare : BinNums.coq_Z -> BinNums.coq_Z -> Datatypes.comparison
    val leb : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val ltb : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val geb : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val gtb : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val eqb : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val max : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val min : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val to_nat : BinNums.coq_Z -> Datatypes.nat
    val of_nat : Datatypes.nat -> BinNums.coq_Z
    val of_N : BinNums.coq_N -> BinNums.coq_Z
    val iter : BinNums.coq_Z -> ('a -> 'a) -> 'a -> 'a
    val pos_div_eucl :
      BinNums.positive -> BinNums.coq_Z -> BinNums.coq_Z * BinNums.coq_Z
    val div_eucl :
      BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z * BinNums.coq_Z
    val div : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val modulo : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val quotrem :
      BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z * BinNums.coq_Z
    val quot : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val rem : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val odd : BinNums.coq_Z -> bool
    val div2 : BinNums.coq_Z -> BinNums.coq_Z
    val log2 : BinNums.coq_Z -> BinNums.coq_Z
    val testbit : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val shiftl : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val shiftr : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val coq_lor : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val coq_land : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val coq_lxor : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val eq_dec : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val log2_up : BinNums.coq_Z -> BinNums.coq_Z
  end
