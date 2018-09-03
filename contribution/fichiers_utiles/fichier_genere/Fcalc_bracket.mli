type location = Coq_loc_Exact | Coq_loc_Inexact of Datatypes.comparison
val new_location_even :
  BinNums.coq_Z -> BinNums.coq_Z -> location -> location
val new_location_odd : BinNums.coq_Z -> BinNums.coq_Z -> location -> location
val new_location : BinNums.coq_Z -> BinNums.coq_Z -> location -> location
