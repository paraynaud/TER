module N :
  sig
    val succ_double : BinNums.coq_N -> BinNums.coq_N
    val double : BinNums.coq_N -> BinNums.coq_N
    val succ_pos : BinNums.coq_N -> BinNums.positive
    val sub : BinNums.coq_N -> BinNums.coq_N -> BinNums.coq_N
    val compare : BinNums.coq_N -> BinNums.coq_N -> Datatypes.comparison
    val leb : BinNums.coq_N -> BinNums.coq_N -> bool
    val max : BinNums.coq_N -> BinNums.coq_N -> BinNums.coq_N
    val pos_div_eucl :
      BinNums.positive -> BinNums.coq_N -> BinNums.coq_N * BinNums.coq_N
    val coq_lor : BinNums.coq_N -> BinNums.coq_N -> BinNums.coq_N
    val coq_land : BinNums.coq_N -> BinNums.coq_N -> BinNums.coq_N
    val ldiff : BinNums.coq_N -> BinNums.coq_N -> BinNums.coq_N
    val coq_lxor : BinNums.coq_N -> BinNums.coq_N -> BinNums.coq_N
    val testbit : BinNums.coq_N -> BinNums.coq_N -> bool
    val eq_dec : BinNums.coq_N -> BinNums.coq_N -> bool
  end
