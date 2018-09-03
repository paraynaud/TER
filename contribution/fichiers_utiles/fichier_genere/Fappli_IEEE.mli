type full_float =
    F754_zero of bool
  | F754_infinity of bool
  | F754_nan of bool * BinNums.positive
  | F754_finite of bool * BinNums.positive * BinNums.coq_Z
type nan_pl = BinNums.positive
val pp_nan_pl : Format.formatter -> nan_pl -> Ppx_deriving_runtime.unit
val show_nan_pl : nan_pl -> Ppx_deriving_runtime.string
type binary_float =
    B754_zero of bool
  | B754_infinity of bool
  | B754_nan of bool * nan_pl
  | B754_finite of bool * BinNums.positive * BinNums.coq_Z
val pp_binary_float :
  Format.formatter -> binary_float -> Ppx_deriving_runtime.unit
val show_binary_float : binary_float -> Ppx_deriving_runtime.string
val coq_FF2B : 'a -> 'b -> full_float -> binary_float
val coq_Bopp :
  'a ->
  'b -> (bool -> nan_pl -> bool * nan_pl) -> binary_float -> binary_float
val coq_Babs :
  'a ->
  'b -> (bool -> nan_pl -> bool * nan_pl) -> binary_float -> binary_float
val coq_Bcompare :
  'a -> 'b -> binary_float -> binary_float -> Datatypes.comparison option
type shr_record = { shr_m : BinNums.coq_Z; shr_r : bool; shr_s : bool; }
val shr_m : shr_record -> BinNums.coq_Z
val shr_1 : shr_record -> shr_record
val loc_of_shr_record : shr_record -> Fcalc_bracket.location
val shr_record_of_loc : BinNums.coq_Z -> Fcalc_bracket.location -> shr_record
val shr :
  shr_record -> BinNums.coq_Z -> BinNums.coq_Z -> shr_record * BinNums.coq_Z
val shr_fexp :
  BinNums.coq_Z ->
  BinNums.coq_Z ->
  BinNums.coq_Z ->
  BinNums.coq_Z -> Fcalc_bracket.location -> shr_record * BinNums.coq_Z
type mode =
    Coq_mode_NE
  | Coq_mode_ZR
  | Coq_mode_DN
  | Coq_mode_UP
  | Coq_mode_NA
val choice_mode :
  mode -> bool -> BinNums.coq_Z -> Fcalc_bracket.location -> BinNums.coq_Z
val overflow_to_inf : mode -> bool -> bool
val binary_overflow :
  BinNums.coq_Z -> BinNums.coq_Z -> mode -> bool -> full_float
val binary_round_aux :
  BinNums.coq_Z ->
  BinNums.coq_Z ->
  mode ->
  bool ->
  BinNums.positive -> BinNums.coq_Z -> Fcalc_bracket.location -> full_float
val coq_Bmult :
  BinNums.coq_Z ->
  BinNums.coq_Z ->
  (binary_float -> binary_float -> bool * nan_pl) ->
  mode -> binary_float -> binary_float -> binary_float
val shl_align :
  BinNums.positive ->
  BinNums.coq_Z -> BinNums.coq_Z -> BinNums.positive * BinNums.coq_Z
val shl_align_fexp :
  BinNums.coq_Z ->
  BinNums.coq_Z ->
  BinNums.positive -> BinNums.coq_Z -> BinNums.positive * BinNums.coq_Z
val binary_round :
  BinNums.coq_Z ->
  BinNums.coq_Z ->
  mode -> bool -> BinNums.positive -> BinNums.coq_Z -> full_float
val binary_normalize :
  BinNums.coq_Z ->
  BinNums.coq_Z ->
  mode -> BinNums.coq_Z -> BinNums.coq_Z -> bool -> binary_float
val coq_Bplus :
  BinNums.coq_Z ->
  BinNums.coq_Z ->
  (binary_float -> binary_float -> bool * nan_pl) ->
  mode -> binary_float -> binary_float -> binary_float
val coq_Bminus :
  BinNums.coq_Z ->
  BinNums.coq_Z ->
  (binary_float -> binary_float -> bool * nan_pl) ->
  mode -> binary_float -> binary_float -> binary_float
val coq_Fdiv_core_binary :
  BinNums.coq_Z ->
  BinNums.coq_Z ->
  BinNums.coq_Z ->
  BinNums.coq_Z ->
  BinNums.coq_Z -> (BinNums.coq_Z * BinNums.coq_Z) * Fcalc_bracket.location
val coq_Bdiv :
  BinNums.coq_Z ->
  BinNums.coq_Z ->
  (binary_float -> binary_float -> bool * nan_pl) ->
  mode -> binary_float -> binary_float -> binary_float
