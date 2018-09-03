module type Int =
  sig
    type t
    val i2z : t -> BinNums.coq_Z
    val _0 : t
    val _1 : t
    val _2 : t
    val _3 : t
    val add : t -> t -> t
    val opp : t -> t
    val sub : t -> t -> t
    val mul : t -> t -> t
    val max : t -> t -> t
    val eqb : t -> t -> bool
    val ltb : t -> t -> bool
    val leb : t -> t -> bool
    val gt_le_dec : t -> t -> bool
    val ge_lt_dec : t -> t -> bool
    val eq_dec : t -> t -> bool
  end
module Z_as_Int :
  sig
    type t = BinNums.coq_Z
    val _0 : BinNums.coq_Z
    val _1 : BinNums.coq_Z
    val _2 : BinNums.coq_Z
    val _3 : BinNums.coq_Z
    val add : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val opp : BinNums.coq_Z -> BinNums.coq_Z
    val sub : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val mul : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val max : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val eqb : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val ltb : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val leb : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val eq_dec : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val gt_le_dec : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val ge_lt_dec : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val i2z : 'a -> 'a
  end
