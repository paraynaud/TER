module type OrderedTypeOrig = OrderedType.OrderedType
module Update_OT :
  functor (O : OrderedTypeOrig) ->
    sig
      type t = O.t
      val eq_dec : O.t -> O.t -> bool
      val compare : O.t -> O.t -> Datatypes.comparison
    end
