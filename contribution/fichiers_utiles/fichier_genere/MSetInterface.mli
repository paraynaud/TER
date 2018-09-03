module MakeListOrdering :
  functor (O : Orders.OrderedType) ->
    sig
      module MO :
        sig
          module OrderTac :
            sig
              module OTF :
                sig
                  type t = O.t
                  val compare : O.t -> O.t -> Datatypes.comparison
                  val eq_dec : O.t -> O.t -> bool
                end
              module TO :
                sig
                  type t = OTF.t
                  val compare : O.t -> O.t -> Datatypes.comparison
                  val eq_dec : O.t -> O.t -> bool
                end
            end
          val eq_dec : O.t -> O.t -> bool
          val lt_dec : O.t -> O.t -> bool
          val eqb : O.t -> O.t -> bool
        end
    end
