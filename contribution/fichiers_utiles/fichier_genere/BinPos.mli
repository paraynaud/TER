module Pos :
  sig
    val succ : BinNums.positive -> BinNums.positive
    val add : BinNums.positive -> BinNums.positive -> BinNums.positive
    val add_carry : BinNums.positive -> BinNums.positive -> BinNums.positive
    val pred_double : BinNums.positive -> BinNums.positive
    val pred : BinNums.positive -> BinNums.positive
    val pred_N : BinNums.positive -> BinNums.coq_N
    type mask =
      BinPosDef.Pos.mask =
        IsNul
      | IsPos of BinNums.positive
      | IsNeg
    val succ_double_mask : mask -> mask
    val double_mask : mask -> mask
    val double_pred_mask : BinNums.positive -> mask
    val sub_mask : BinNums.positive -> BinNums.positive -> mask
    val sub_mask_carry : BinNums.positive -> BinNums.positive -> mask
    val mul : BinNums.positive -> BinNums.positive -> BinNums.positive
    val iter : ('a -> 'a) -> 'a -> BinNums.positive -> 'a
    val square : BinNums.positive -> BinNums.positive
    val div2 : BinNums.positive -> BinNums.positive
    val div2_up : BinNums.positive -> BinNums.positive
    val size : BinNums.positive -> BinNums.positive
    val compare_cont :
      Datatypes.comparison ->
      BinNums.positive -> BinNums.positive -> Datatypes.comparison
    val compare :
      BinNums.positive -> BinNums.positive -> Datatypes.comparison
    val max : BinNums.positive -> BinNums.positive -> BinNums.positive
    val eqb : BinNums.positive -> BinNums.positive -> bool
    val leb : BinNums.positive -> BinNums.positive -> bool
    val coq_Nsucc_double : BinNums.coq_N -> BinNums.coq_N
    val coq_Ndouble : BinNums.coq_N -> BinNums.coq_N
    val coq_lor : BinNums.positive -> BinNums.positive -> BinNums.positive
    val coq_land : BinNums.positive -> BinNums.positive -> BinNums.coq_N
    val ldiff : BinNums.positive -> BinNums.positive -> BinNums.coq_N
    val coq_lxor : BinNums.positive -> BinNums.positive -> BinNums.coq_N
    val shiftl_nat : BinNums.positive -> Datatypes.nat -> BinNums.positive
    val shiftr_nat : BinNums.positive -> Datatypes.nat -> BinNums.positive
    val testbit : BinNums.positive -> BinNums.coq_N -> bool
    val iter_op : ('a -> 'a -> 'a) -> BinNums.positive -> 'a -> 'a
    val to_nat : BinNums.positive -> Datatypes.nat
    val of_succ_nat : Datatypes.nat -> BinNums.positive
    val eq_dec : BinNums.positive -> BinNums.positive -> bool
  end
