module type EqLtLe = sig type t end
module type OrderedType =
  sig
    type t
    val compare : t -> t -> Datatypes.comparison
    val eq_dec : t -> t -> bool
  end
module type OrderedType' =
  sig
    type t
    val compare : t -> t -> Datatypes.comparison
    val eq_dec : t -> t -> bool
  end
module OT_to_Full :
  functor (O : OrderedType') ->
    sig
      type t = O.t
      val compare : O.t -> O.t -> Datatypes.comparison
      val eq_dec : O.t -> O.t -> bool
    end
module type TotalLeBool' = sig type t val leb : t -> t -> bool end
