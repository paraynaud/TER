val join_bits :
  BinNums.coq_Z ->
  BinNums.coq_Z -> bool -> BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
val split_bits :
  BinNums.coq_Z ->
  BinNums.coq_Z -> BinNums.coq_Z -> (bool * BinNums.coq_Z) * BinNums.coq_Z
val bits_of_binary_float :
  BinNums.coq_Z -> BinNums.coq_Z -> Fappli_IEEE.binary_float -> BinNums.coq_Z
val binary_float_of_bits_aux :
  BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z -> Fappli_IEEE.full_float
val binary_float_of_bits :
  BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z -> Fappli_IEEE.binary_float
type binary32 = Fappli_IEEE.binary_float
val pp_binary32 : Format.formatter -> binary32 -> Ppx_deriving_runtime.unit
val show_binary32 : binary32 -> Ppx_deriving_runtime.string
val b32_of_bits : BinNums.coq_Z -> Fappli_IEEE.binary_float
val bits_of_b32 : Fappli_IEEE.binary_float -> BinNums.coq_Z
type binary64 = Fappli_IEEE.binary_float
val pp_binary64 : Format.formatter -> binary64 -> Ppx_deriving_runtime.unit
val show_binary64 : binary64 -> Ppx_deriving_runtime.string
val b64_of_bits : BinNums.coq_Z -> Fappli_IEEE.binary_float
val bits_of_b64 : Fappli_IEEE.binary_float -> BinNums.coq_Z
