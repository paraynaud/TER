val coq_Beq_dec :
  'a -> 'b -> Fappli_IEEE.binary_float -> Fappli_IEEE.binary_float -> bool
val coq_BofZ :
  BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z -> Fappli_IEEE.binary_float
val coq_ZofB : 'a -> 'b -> Fappli_IEEE.binary_float -> BinNums.coq_Z option
val coq_ZofB_range :
  'a ->
  'b ->
  Fappli_IEEE.binary_float ->
  BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z option
val coq_Bexact_inverse_mantissa : BinNums.coq_Z -> BinNums.positive
val coq_Bexact_inverse :
  BinNums.coq_Z ->
  BinNums.coq_Z ->
  Fappli_IEEE.binary_float -> Fappli_IEEE.binary_float option
val pos_pow : BinNums.positive -> BinNums.positive -> BinNums.positive
val coq_Bparse :
  BinNums.coq_Z ->
  BinNums.coq_Z ->
  BinNums.positive ->
  BinNums.positive -> BinNums.coq_Z -> Fappli_IEEE.binary_float
val coq_Bconv :
  'a ->
  'b ->
  BinNums.coq_Z ->
  BinNums.coq_Z ->
  (bool -> Fappli_IEEE.nan_pl -> bool * Fappli_IEEE.nan_pl) ->
  Fappli_IEEE.mode -> Fappli_IEEE.binary_float -> Fappli_IEEE.binary_float
