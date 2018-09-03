module MakeOrderTac : functor (O : Orders.EqLtLe) (P : sig  end) -> sig  end
module OT_to_OrderTac :
  functor (OT : Orders.OrderedType) ->
    sig
      module OTF :
        sig
          type t = OT.t
          val compare : OT.t -> OT.t -> Datatypes.comparison
          val eq_dec : OT.t -> OT.t -> bool
        end
      module TO :
        sig
          type t = OTF.t
          val compare : OT.t -> OT.t -> Datatypes.comparison
          val eq_dec : OT.t -> OT.t -> bool
        end
    end
