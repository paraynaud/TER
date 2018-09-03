type reg = BinNums.positive
val pp_reg : Format.formatter -> reg -> Ppx_deriving_runtime.unit
val show_reg : reg -> Ppx_deriving_runtime.string
module Reg : sig val eq : BinNums.positive -> BinNums.positive -> bool end
module Regset :
  sig
    module X' :
      sig
        type t = Ordered.OrderedPositive.t
        val eq_dec :
          Ordered.OrderedPositive.t -> Ordered.OrderedPositive.t -> bool
        val compare :
          Ordered.OrderedPositive.t ->
          Ordered.OrderedPositive.t -> Datatypes.comparison
      end
    module MSet :
      sig
        module Raw :
          sig
            type elt = X'.t
            type tree =
              MSetAVL.MakeRaw(Int0.Z_as_Int)(X').tree =
                Leaf
              | Node of Int0.Z_as_Int.t * tree * X'.t * tree
            val empty : tree
            val is_empty : tree -> bool
            val mem : X'.t -> tree -> bool
            val min_elt : tree -> X'.t option
            val max_elt : tree -> X'.t option
            val choose : tree -> X'.t option
            val fold : (X'.t -> 'a -> 'a) -> tree -> 'a -> 'a
            val elements_aux : X'.t list -> tree -> X'.t list
            val elements : tree -> X'.t list
            val rev_elements_aux : X'.t list -> tree -> X'.t list
            val rev_elements : tree -> X'.t list
            val cardinal : tree -> Datatypes.nat
            val maxdepth : tree -> Datatypes.nat
            val mindepth : tree -> Datatypes.nat
            val for_all : (X'.t -> bool) -> tree -> bool
            val exists_ : (X'.t -> bool) -> tree -> bool
            type enumeration =
              MSetAVL.MakeRaw(Int0.Z_as_Int)(X').enumeration =
                End
              | More of elt * tree * enumeration
            val cons : tree -> enumeration -> enumeration
            val compare_more :
              X'.t ->
              (enumeration -> Datatypes.comparison) ->
              enumeration -> Datatypes.comparison
            val compare_cont :
              tree ->
              (enumeration -> Datatypes.comparison) ->
              enumeration -> Datatypes.comparison
            val compare_end : enumeration -> Datatypes.comparison
            val compare : tree -> tree -> Datatypes.comparison
            val equal : tree -> tree -> bool
            val subsetl : (tree -> bool) -> X'.t -> tree -> bool
            val subsetr : (tree -> bool) -> X'.t -> tree -> bool
            val subset : tree -> tree -> bool
            type t = tree
            val height : tree -> Int0.Z_as_Int.t
            val singleton : X'.t -> tree
            val create : tree -> X'.t -> tree -> tree
            val assert_false : tree -> X'.t -> tree -> tree
            val bal : tree -> X'.t -> tree -> tree
            val add : X'.t -> tree -> tree
            val join : tree -> X'.t -> tree -> tree
            val remove_min : tree -> X'.t -> tree -> tree * X'.t
            val merge : tree -> tree -> tree
            val remove : X'.t -> tree -> tree
            val concat : tree -> tree -> tree
            type triple =
              MSetAVL.MakeRaw(Int0.Z_as_Int)(X').triple = {
              t_left : t;
              t_in : bool;
              t_right : t;
            }
            val t_left : triple -> t
            val t_in : triple -> bool
            val t_right : triple -> t
            val split : X'.t -> tree -> triple
            val inter : tree -> t -> tree
            val diff : tree -> t -> tree
            val union : t -> t -> t
            val filter : (X'.t -> bool) -> tree -> tree
            val partition : (X'.t -> bool) -> tree -> tree * tree
            val ltb_tree : X'.t -> tree -> bool
            val gtb_tree : X'.t -> tree -> bool
            val isok : tree -> bool
            module MX :
              sig
                module OrderTac :
                  sig
                    module OTF :
                      sig
                        type t = X'.t
                        val compare : X'.t -> X'.t -> Datatypes.comparison
                        val eq_dec : X'.t -> X'.t -> bool
                      end
                    module TO :
                      sig
                        type t = OTF.t
                        val compare : X'.t -> X'.t -> Datatypes.comparison
                        val eq_dec : X'.t -> X'.t -> bool
                      end
                  end
                val eq_dec : X'.t -> X'.t -> bool
                val lt_dec : X'.t -> X'.t -> bool
                val eqb : X'.t -> X'.t -> bool
              end
            type coq_R_min_elt =
              MSetAVL.MakeRaw(Int0.Z_as_Int)(X').coq_R_min_elt =
                R_min_elt_0 of tree
              | R_min_elt_1 of tree * Int0.Z_as_Int.t * tree * X'.t * tree
              | R_min_elt_2 of tree * Int0.Z_as_Int.t * tree * X'.t * 
                  tree * Int0.Z_as_Int.t * tree * X'.t * tree * elt option *
                  coq_R_min_elt
            type coq_R_max_elt =
              MSetAVL.MakeRaw(Int0.Z_as_Int)(X').coq_R_max_elt =
                R_max_elt_0 of tree
              | R_max_elt_1 of tree * Int0.Z_as_Int.t * tree * X'.t * tree
              | R_max_elt_2 of tree * Int0.Z_as_Int.t * tree * X'.t * 
                  tree * Int0.Z_as_Int.t * tree * X'.t * tree * elt option *
                  coq_R_max_elt
            module L :
              sig
                module MO :
                  sig
                    module OrderTac :
                      sig
                        module OTF :
                          sig
                            type t = X'.t
                            val compare :
                              X'.t -> X'.t -> Datatypes.comparison
                            val eq_dec : X'.t -> X'.t -> bool
                          end
                        module TO :
                          sig
                            type t = OTF.t
                            val compare :
                              X'.t -> X'.t -> Datatypes.comparison
                            val eq_dec : X'.t -> X'.t -> bool
                          end
                      end
                    val eq_dec : X'.t -> X'.t -> bool
                    val lt_dec : X'.t -> X'.t -> bool
                    val eqb : X'.t -> X'.t -> bool
                  end
              end
            val flatten_e : enumeration -> elt list
            type coq_R_bal =
              MSetAVL.MakeRaw(Int0.Z_as_Int)(X').coq_R_bal =
                R_bal_0 of t * X'.t * t
              | R_bal_1 of t * X'.t * t * Int0.Z_as_Int.t * tree * X'.t *
                  tree
              | R_bal_2 of t * X'.t * t * Int0.Z_as_Int.t * tree * X'.t *
                  tree
              | R_bal_3 of t * X'.t * t * Int0.Z_as_Int.t * tree * X'.t *
                  tree * Int0.Z_as_Int.t * tree * X'.t * tree
              | R_bal_4 of t * X'.t * t
              | R_bal_5 of t * X'.t * t * Int0.Z_as_Int.t * tree * X'.t *
                  tree
              | R_bal_6 of t * X'.t * t * Int0.Z_as_Int.t * tree * X'.t *
                  tree
              | R_bal_7 of t * X'.t * t * Int0.Z_as_Int.t * tree * X'.t *
                  tree * Int0.Z_as_Int.t * tree * X'.t * tree
              | R_bal_8 of t * X'.t * t
            type coq_R_remove_min =
              MSetAVL.MakeRaw(Int0.Z_as_Int)(X').coq_R_remove_min =
                R_remove_min_0 of tree * elt * t
              | R_remove_min_1 of tree * elt * t * Int0.Z_as_Int.t * 
                  tree * X'.t * tree * (t * elt) * coq_R_remove_min * 
                  t * elt
            type coq_R_merge =
              MSetAVL.MakeRaw(Int0.Z_as_Int)(X').coq_R_merge =
                R_merge_0 of tree * tree
              | R_merge_1 of tree * tree * Int0.Z_as_Int.t * tree * X'.t *
                  tree
              | R_merge_2 of tree * tree * Int0.Z_as_Int.t * tree * X'.t *
                  tree * Int0.Z_as_Int.t * tree * X'.t * tree * t * elt
            type coq_R_concat =
              MSetAVL.MakeRaw(Int0.Z_as_Int)(X').coq_R_concat =
                R_concat_0 of tree * tree
              | R_concat_1 of tree * tree * Int0.Z_as_Int.t * tree * 
                  X'.t * tree
              | R_concat_2 of tree * tree * Int0.Z_as_Int.t * tree * 
                  X'.t * tree * Int0.Z_as_Int.t * tree * X'.t * tree * 
                  t * elt
            type coq_R_inter =
              MSetAVL.MakeRaw(Int0.Z_as_Int)(X').coq_R_inter =
                R_inter_0 of tree * tree
              | R_inter_1 of tree * tree * Int0.Z_as_Int.t * tree * X'.t *
                  tree
              | R_inter_2 of tree * tree * Int0.Z_as_Int.t * tree * X'.t *
                  tree * Int0.Z_as_Int.t * tree * X'.t * tree * t * bool *
                  t * tree * coq_R_inter * tree * coq_R_inter
              | R_inter_3 of tree * tree * Int0.Z_as_Int.t * tree * X'.t *
                  tree * Int0.Z_as_Int.t * tree * X'.t * tree * t * bool *
                  t * tree * coq_R_inter * tree * coq_R_inter
            type coq_R_diff =
              MSetAVL.MakeRaw(Int0.Z_as_Int)(X').coq_R_diff =
                R_diff_0 of tree * tree
              | R_diff_1 of tree * tree * Int0.Z_as_Int.t * tree * X'.t *
                  tree
              | R_diff_2 of tree * tree * Int0.Z_as_Int.t * tree * X'.t *
                  tree * Int0.Z_as_Int.t * tree * X'.t * tree * t * bool *
                  t * tree * coq_R_diff * tree * coq_R_diff
              | R_diff_3 of tree * tree * Int0.Z_as_Int.t * tree * X'.t *
                  tree * Int0.Z_as_Int.t * tree * X'.t * tree * t * bool *
                  t * tree * coq_R_diff * tree * coq_R_diff
            type coq_R_union =
              MSetAVL.MakeRaw(Int0.Z_as_Int)(X').coq_R_union =
                R_union_0 of tree * tree
              | R_union_1 of tree * tree * Int0.Z_as_Int.t * tree * X'.t *
                  tree
              | R_union_2 of tree * tree * Int0.Z_as_Int.t * tree * X'.t *
                  tree * Int0.Z_as_Int.t * tree * X'.t * tree * t * bool *
                  t * tree * coq_R_union * tree * coq_R_union
          end
        module E :
          sig
            type t = X'.t
            val compare : X'.t -> X'.t -> Datatypes.comparison
            val eq_dec : X'.t -> X'.t -> bool
          end
        type elt = X'.t
        type t_ = Raw.t
        val this : 'a -> 'a
        type t = t_
        val mem : X'.t -> Raw.tree -> bool
        val add : X'.t -> Raw.tree -> Raw.tree
        val remove : X'.t -> Raw.tree -> Raw.tree
        val singleton : X'.t -> Raw.tree
        val union : Raw.t -> Raw.t -> Raw.t
        val inter : Raw.tree -> Raw.t -> Raw.tree
        val diff : Raw.tree -> Raw.t -> Raw.tree
        val equal : Raw.tree -> Raw.tree -> bool
        val subset : Raw.tree -> Raw.tree -> bool
        val empty : Raw.tree
        val is_empty : Raw.tree -> bool
        val elements : Raw.tree -> X'.t list
        val choose : Raw.tree -> X'.t option
        val fold : (X'.t -> 'a -> 'a) -> Raw.tree -> 'a -> 'a
        val cardinal : Raw.tree -> Datatypes.nat
        val filter : (X'.t -> bool) -> Raw.tree -> Raw.tree
        val for_all : (X'.t -> bool) -> Raw.tree -> bool
        val exists_ : (X'.t -> bool) -> Raw.tree -> bool
        val partition : (X'.t -> bool) -> Raw.tree -> Raw.tree * Raw.tree
        val eq_dec : Raw.tree -> Raw.tree -> bool
        val compare : Raw.tree -> Raw.tree -> Datatypes.comparison
        val min_elt : Raw.tree -> X'.t option
        val max_elt : Raw.tree -> X'.t option
      end
    type elt = Ordered.OrderedPositive.t
    type t = MSet.t
    val empty : MSet.Raw.tree
    val is_empty : MSet.Raw.tree -> bool
    val mem : X'.t -> MSet.Raw.tree -> bool
    val add : X'.t -> MSet.Raw.tree -> MSet.Raw.tree
    val singleton : X'.t -> MSet.Raw.tree
    val remove : X'.t -> MSet.Raw.tree -> MSet.Raw.tree
    val union : MSet.Raw.t -> MSet.Raw.t -> MSet.Raw.t
    val inter : MSet.Raw.tree -> MSet.Raw.t -> MSet.Raw.tree
    val diff : MSet.Raw.tree -> MSet.Raw.t -> MSet.Raw.tree
    val eq_dec : MSet.Raw.tree -> MSet.Raw.tree -> bool
    val equal : MSet.Raw.tree -> MSet.Raw.tree -> bool
    val subset : MSet.Raw.tree -> MSet.Raw.tree -> bool
    val fold : (X'.t -> 'a -> 'a) -> MSet.Raw.tree -> 'a -> 'a
    val for_all : (X'.t -> bool) -> MSet.Raw.tree -> bool
    val exists_ : (X'.t -> bool) -> MSet.Raw.tree -> bool
    val filter : (X'.t -> bool) -> MSet.Raw.tree -> MSet.Raw.tree
    val partition :
      (X'.t -> bool) -> MSet.Raw.tree -> MSet.Raw.tree * MSet.Raw.tree
    val cardinal : MSet.Raw.tree -> Datatypes.nat
    val elements : MSet.Raw.tree -> X'.t list
    val choose : MSet.Raw.tree -> X'.t option
    module MF : sig val eqb : X'.t -> X'.t -> bool end
    val min_elt : MSet.Raw.tree -> X'.t option
    val max_elt : MSet.Raw.tree -> X'.t option
    val compare :
      MSet.Raw.tree -> MSet.Raw.tree -> 'a OrderedType.coq_Compare
    module E :
      sig
        type t = Ordered.OrderedPositive.t
        val compare :
          Ordered.OrderedPositive.t ->
          Ordered.OrderedPositive.t ->
          Ordered.OrderedPositive.t OrderedType.coq_Compare
        val eq_dec :
          Ordered.OrderedPositive.t -> Ordered.OrderedPositive.t -> bool
      end
  end
