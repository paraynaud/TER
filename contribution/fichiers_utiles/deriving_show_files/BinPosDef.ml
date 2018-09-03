open BinNums

module Pos =
 struct
  type mask =
  | IsNul
  | IsPos of positive
  | IsNeg
  [@@deriving show]
 end
