type float = Fappli_IEEE_bits.binary64
val pp_float : Format.formatter -> float -> Ppx_deriving_runtime.unit
val show_float : float -> Ppx_deriving_runtime.string
type float32 = Fappli_IEEE_bits.binary32
val pp_float32 : Format.formatter -> float32 -> Ppx_deriving_runtime.unit
val show_float32 : float32 -> Ppx_deriving_runtime.string
val cmp_of_comparison :
  Integers.comparison -> Datatypes.comparison option -> bool
module Float :
  sig
    val transform_quiet_pl : BinNums.positive -> BinNums.positive
    val expand_pl : BinNums.positive -> BinNums.positive
    val of_single_pl : 'a -> BinNums.positive -> 'a * BinNums.positive
    val reduce_pl : BinNums.positive -> BinNums.positive
    val to_single_pl : 'a -> BinNums.positive -> 'a * BinNums.positive
    val neg_pl : bool -> 'a -> bool * 'a
    val abs_pl : 'a -> 'b -> bool * 'b
    val binop_pl :
      Fappli_IEEE.binary_float ->
      Fappli_IEEE.binary_float -> bool * BinNums.positive
    val zero : Fappli_IEEE.binary_float
    val eq_dec : Fappli_IEEE.binary_float -> Fappli_IEEE.binary_float -> bool
    val neg : Fappli_IEEE.binary_float -> Fappli_IEEE.binary_float
    val abs : Fappli_IEEE.binary_float -> Fappli_IEEE.binary_float
    val add :
      Fappli_IEEE.binary_float ->
      Fappli_IEEE.binary_float -> Fappli_IEEE.binary_float
    val sub :
      Fappli_IEEE.binary_float ->
      Fappli_IEEE.binary_float -> Fappli_IEEE.binary_float
    val mul :
      Fappli_IEEE.binary_float ->
      Fappli_IEEE.binary_float -> Fappli_IEEE.binary_float
    val div :
      Fappli_IEEE.binary_float ->
      Fappli_IEEE.binary_float -> Fappli_IEEE.binary_float
    val cmp :
      Integers.comparison ->
      Fappli_IEEE.binary_float -> Fappli_IEEE.binary_float -> bool
    val of_single : Fappli_IEEE.binary_float -> Fappli_IEEE.binary_float
    val to_single : Fappli_IEEE.binary_float -> Fappli_IEEE.binary_float
    val to_int : Fappli_IEEE.binary_float -> BinNums.coq_Z option
    val to_intu : Fappli_IEEE.binary_float -> BinNums.coq_Z option
    val to_long : Fappli_IEEE.binary_float -> BinNums.coq_Z option
    val to_longu : Fappli_IEEE.binary_float -> BinNums.coq_Z option
    val of_int : BinNums.coq_Z -> Fappli_IEEE.binary_float
    val of_intu : BinNums.coq_Z -> Fappli_IEEE.binary_float
    val of_long : BinNums.coq_Z -> Fappli_IEEE.binary_float
    val of_longu : BinNums.coq_Z -> Fappli_IEEE.binary_float
    val from_parsed :
      BinNums.positive ->
      BinNums.positive -> BinNums.coq_Z -> Fappli_IEEE.binary_float
    val to_bits : Fappli_IEEE.binary_float -> BinNums.coq_Z
    val of_bits : BinNums.coq_Z -> Fappli_IEEE.binary_float
    val exact_inverse :
      Fappli_IEEE.binary_float -> Fappli_IEEE.binary_float option
    val ox8000_0000 : BinNums.coq_Z
  end
module Float32 :
  sig
    val transform_quiet_pl : BinNums.positive -> BinNums.positive
    val neg_pl : bool -> 'a -> bool * 'a
    val abs_pl : 'a -> 'b -> bool * 'b
    val binop_pl :
      Fappli_IEEE.binary_float ->
      Fappli_IEEE.binary_float -> bool * BinNums.positive
    val zero : Fappli_IEEE.binary_float
    val eq_dec : Fappli_IEEE.binary_float -> Fappli_IEEE.binary_float -> bool
    val neg : Fappli_IEEE.binary_float -> Fappli_IEEE.binary_float
    val abs : Fappli_IEEE.binary_float -> Fappli_IEEE.binary_float
    val add :
      Fappli_IEEE.binary_float ->
      Fappli_IEEE.binary_float -> Fappli_IEEE.binary_float
    val sub :
      Fappli_IEEE.binary_float ->
      Fappli_IEEE.binary_float -> Fappli_IEEE.binary_float
    val mul :
      Fappli_IEEE.binary_float ->
      Fappli_IEEE.binary_float -> Fappli_IEEE.binary_float
    val div :
      Fappli_IEEE.binary_float ->
      Fappli_IEEE.binary_float -> Fappli_IEEE.binary_float
    val cmp :
      Integers.comparison ->
      Fappli_IEEE.binary_float -> Fappli_IEEE.binary_float -> bool
    val to_int : Fappli_IEEE.binary_float -> BinNums.coq_Z option
    val to_intu : Fappli_IEEE.binary_float -> BinNums.coq_Z option
    val to_long : Fappli_IEEE.binary_float -> BinNums.coq_Z option
    val to_longu : Fappli_IEEE.binary_float -> BinNums.coq_Z option
    val of_int : BinNums.coq_Z -> Fappli_IEEE.binary_float
    val of_intu : BinNums.coq_Z -> Fappli_IEEE.binary_float
    val of_long : BinNums.coq_Z -> Fappli_IEEE.binary_float
    val of_longu : BinNums.coq_Z -> Fappli_IEEE.binary_float
    val from_parsed :
      BinNums.positive ->
      BinNums.positive -> BinNums.coq_Z -> Fappli_IEEE.binary_float
    val to_bits : Fappli_IEEE.binary_float -> BinNums.coq_Z
    val of_bits : BinNums.coq_Z -> Fappli_IEEE.binary_float
    val exact_inverse :
      Fappli_IEEE.binary_float -> Fappli_IEEE.binary_float option
  end
