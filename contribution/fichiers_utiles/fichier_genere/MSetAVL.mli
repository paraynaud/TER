module MakeRaw :
  functor (I : Int0.Int) (X : Orders.OrderedType) ->
    sig
      type elt = X.t
      type tree = Leaf | Node of I.t * tree * X.t * tree
      val empty : tree
      val is_empty : tree -> bool
      val mem : X.t -> tree -> bool
      val min_elt : tree -> X.t option
      val max_elt : tree -> X.t option
      val choose : tree -> X.t option
      val fold : (X.t -> 'a -> 'a) -> tree -> 'a -> 'a
      val elements_aux : X.t list -> tree -> X.t list
      val elements : tree -> X.t list
      val rev_elements_aux : X.t list -> tree -> X.t list
      val rev_elements : tree -> X.t list
      val cardinal : tree -> Datatypes.nat
      val maxdepth : tree -> Datatypes.nat
      val mindepth : tree -> Datatypes.nat
      val for_all : (X.t -> bool) -> tree -> bool
      val exists_ : (X.t -> bool) -> tree -> bool
      type enumeration = End | More of elt * tree * enumeration
      val cons : tree -> enumeration -> enumeration
      val compare_more :
        X.t ->
        (enumeration -> Datatypes.comparison) ->
        enumeration -> Datatypes.comparison
      val compare_cont :
        tree ->
        (enumeration -> Datatypes.comparison) ->
        enumeration -> Datatypes.comparison
      val compare_end : enumeration -> Datatypes.comparison
      val compare : tree -> tree -> Datatypes.comparison
      val equal : tree -> tree -> bool
      val subsetl : (tree -> bool) -> X.t -> tree -> bool
      val subsetr : (tree -> bool) -> X.t -> tree -> bool
      val subset : tree -> tree -> bool
      type t = tree
      val height : tree -> I.t
      val singleton : X.t -> tree
      val create : tree -> X.t -> tree -> tree
      val assert_false : tree -> X.t -> tree -> tree
      val bal : tree -> X.t -> tree -> tree
      val add : X.t -> tree -> tree
      val join : tree -> X.t -> tree -> tree
      val remove_min : tree -> X.t -> tree -> tree * X.t
      val merge : tree -> tree -> tree
      val remove : X.t -> tree -> tree
      val concat : tree -> tree -> tree
      type triple = { t_left : t; t_in : bool; t_right : t; }
      val t_left : triple -> t
      val t_in : triple -> bool
      val t_right : triple -> t
      val split : X.t -> tree -> triple
      val inter : tree -> t -> tree
      val diff : tree -> t -> tree
      val union : t -> t -> t
      val filter : (X.t -> bool) -> tree -> tree
      val partition : (X.t -> bool) -> tree -> tree * tree
      val ltb_tree : X.t -> tree -> bool
      val gtb_tree : X.t -> tree -> bool
      val isok : tree -> bool
      module MX :
        sig
          module OrderTac :
            sig
              module OTF :
                sig
                  type t = X.t
                  val compare : X.t -> X.t -> Datatypes.comparison
                  val eq_dec : X.t -> X.t -> bool
                end
              module TO :
                sig
                  type t = OTF.t
                  val compare : X.t -> X.t -> Datatypes.comparison
                  val eq_dec : X.t -> X.t -> bool
                end
            end
          val eq_dec : X.t -> X.t -> bool
          val lt_dec : X.t -> X.t -> bool
          val eqb : X.t -> X.t -> bool
        end
      type coq_R_min_elt =
          R_min_elt_0 of tree
        | R_min_elt_1 of tree * I.t * tree * X.t * tree
        | R_min_elt_2 of tree * I.t * tree * X.t * tree * I.t * tree * 
            X.t * tree * elt option * coq_R_min_elt
      type coq_R_max_elt =
          R_max_elt_0 of tree
        | R_max_elt_1 of tree * I.t * tree * X.t * tree
        | R_max_elt_2 of tree * I.t * tree * X.t * tree * I.t * tree * 
            X.t * tree * elt option * coq_R_max_elt
      module L :
        sig
          module MO :
            sig
              module OrderTac :
                sig
                  module OTF :
                    sig
                      type t = X.t
                      val compare : X.t -> X.t -> Datatypes.comparison
                      val eq_dec : X.t -> X.t -> bool
                    end
                  module TO :
                    sig
                      type t = OTF.t
                      val compare : X.t -> X.t -> Datatypes.comparison
                      val eq_dec : X.t -> X.t -> bool
                    end
                end
              val eq_dec : X.t -> X.t -> bool
              val lt_dec : X.t -> X.t -> bool
              val eqb : X.t -> X.t -> bool
            end
        end
      val flatten_e : enumeration -> elt list
      type coq_R_bal =
          R_bal_0 of t * X.t * t
        | R_bal_1 of t * X.t * t * I.t * tree * X.t * tree
        | R_bal_2 of t * X.t * t * I.t * tree * X.t * tree
        | R_bal_3 of t * X.t * t * I.t * tree * X.t * tree * I.t * tree *
            X.t * tree
        | R_bal_4 of t * X.t * t
        | R_bal_5 of t * X.t * t * I.t * tree * X.t * tree
        | R_bal_6 of t * X.t * t * I.t * tree * X.t * tree
        | R_bal_7 of t * X.t * t * I.t * tree * X.t * tree * I.t * tree *
            X.t * tree
        | R_bal_8 of t * X.t * t
      type coq_R_remove_min =
          R_remove_min_0 of tree * elt * t
        | R_remove_min_1 of tree * elt * t * I.t * tree * X.t * tree *
            (t * elt) * coq_R_remove_min * t * elt
      type coq_R_merge =
          R_merge_0 of tree * tree
        | R_merge_1 of tree * tree * I.t * tree * X.t * tree
        | R_merge_2 of tree * tree * I.t * tree * X.t * tree * I.t * 
            tree * X.t * tree * t * elt
      type coq_R_concat =
          R_concat_0 of tree * tree
        | R_concat_1 of tree * tree * I.t * tree * X.t * tree
        | R_concat_2 of tree * tree * I.t * tree * X.t * tree * I.t * 
            tree * X.t * tree * t * elt
      type coq_R_inter =
          R_inter_0 of tree * tree
        | R_inter_1 of tree * tree * I.t * tree * X.t * tree
        | R_inter_2 of tree * tree * I.t * tree * X.t * tree * I.t * 
            tree * X.t * tree * t * bool * t * tree * coq_R_inter * tree *
            coq_R_inter
        | R_inter_3 of tree * tree * I.t * tree * X.t * tree * I.t * 
            tree * X.t * tree * t * bool * t * tree * coq_R_inter * tree *
            coq_R_inter
      type coq_R_diff =
          R_diff_0 of tree * tree
        | R_diff_1 of tree * tree * I.t * tree * X.t * tree
        | R_diff_2 of tree * tree * I.t * tree * X.t * tree * I.t * tree *
            X.t * tree * t * bool * t * tree * coq_R_diff * tree * coq_R_diff
        | R_diff_3 of tree * tree * I.t * tree * X.t * tree * I.t * tree *
            X.t * tree * t * bool * t * tree * coq_R_diff * tree * coq_R_diff
      type coq_R_union =
          R_union_0 of tree * tree
        | R_union_1 of tree * tree * I.t * tree * X.t * tree
        | R_union_2 of tree * tree * I.t * tree * X.t * tree * I.t * 
            tree * X.t * tree * t * bool * t * tree * coq_R_union * tree *
            coq_R_union
    end
module IntMake :
  functor (I : Int0.Int) (X : Orders.OrderedType) ->
    sig
      module Raw :
        sig
          type elt = X.t
          type tree =
            MakeRaw(I)(X).tree =
              Leaf
            | Node of I.t * tree * X.t * tree
          val empty : tree
          val is_empty : tree -> bool
          val mem : X.t -> tree -> bool
          val min_elt : tree -> X.t option
          val max_elt : tree -> X.t option
          val choose : tree -> X.t option
          val fold : (X.t -> 'a -> 'a) -> tree -> 'a -> 'a
          val elements_aux : X.t list -> tree -> X.t list
          val elements : tree -> X.t list
          val rev_elements_aux : X.t list -> tree -> X.t list
          val rev_elements : tree -> X.t list
          val cardinal : tree -> Datatypes.nat
          val maxdepth : tree -> Datatypes.nat
          val mindepth : tree -> Datatypes.nat
          val for_all : (X.t -> bool) -> tree -> bool
          val exists_ : (X.t -> bool) -> tree -> bool
          type enumeration =
            MakeRaw(I)(X).enumeration =
              End
            | More of elt * tree * enumeration
          val cons : tree -> enumeration -> enumeration
          val compare_more :
            X.t ->
            (enumeration -> Datatypes.comparison) ->
            enumeration -> Datatypes.comparison
          val compare_cont :
            tree ->
            (enumeration -> Datatypes.comparison) ->
            enumeration -> Datatypes.comparison
          val compare_end : enumeration -> Datatypes.comparison
          val compare : tree -> tree -> Datatypes.comparison
          val equal : tree -> tree -> bool
          val subsetl : (tree -> bool) -> X.t -> tree -> bool
          val subsetr : (tree -> bool) -> X.t -> tree -> bool
          val subset : tree -> tree -> bool
          type t = tree
          val height : tree -> I.t
          val singleton : X.t -> tree
          val create : tree -> X.t -> tree -> tree
          val assert_false : tree -> X.t -> tree -> tree
          val bal : tree -> X.t -> tree -> tree
          val add : X.t -> tree -> tree
          val join : tree -> X.t -> tree -> tree
          val remove_min : tree -> X.t -> tree -> tree * X.t
          val merge : tree -> tree -> tree
          val remove : X.t -> tree -> tree
          val concat : tree -> tree -> tree
          type triple =
            MakeRaw(I)(X).triple = {
            t_left : t;
            t_in : bool;
            t_right : t;
          }
          val t_left : triple -> t
          val t_in : triple -> bool
          val t_right : triple -> t
          val split : X.t -> tree -> triple
          val inter : tree -> t -> tree
          val diff : tree -> t -> tree
          val union : t -> t -> t
          val filter : (X.t -> bool) -> tree -> tree
          val partition : (X.t -> bool) -> tree -> tree * tree
          val ltb_tree : X.t -> tree -> bool
          val gtb_tree : X.t -> tree -> bool
          val isok : tree -> bool
          module MX :
            sig
              module OrderTac :
                sig
                  module OTF :
                    sig
                      type t = X.t
                      val compare : X.t -> X.t -> Datatypes.comparison
                      val eq_dec : X.t -> X.t -> bool
                    end
                  module TO :
                    sig
                      type t = OTF.t
                      val compare : X.t -> X.t -> Datatypes.comparison
                      val eq_dec : X.t -> X.t -> bool
                    end
                end
              val eq_dec : X.t -> X.t -> bool
              val lt_dec : X.t -> X.t -> bool
              val eqb : X.t -> X.t -> bool
            end
          type coq_R_min_elt =
            MakeRaw(I)(X).coq_R_min_elt =
              R_min_elt_0 of tree
            | R_min_elt_1 of tree * I.t * tree * X.t * tree
            | R_min_elt_2 of tree * I.t * tree * X.t * tree * I.t * tree *
                X.t * tree * elt option * coq_R_min_elt
          type coq_R_max_elt =
            MakeRaw(I)(X).coq_R_max_elt =
              R_max_elt_0 of tree
            | R_max_elt_1 of tree * I.t * tree * X.t * tree
            | R_max_elt_2 of tree * I.t * tree * X.t * tree * I.t * tree *
                X.t * tree * elt option * coq_R_max_elt
          module L :
            sig
              module MO :
                sig
                  module OrderTac :
                    sig
                      module OTF :
                        sig
                          type t = X.t
                          val compare : X.t -> X.t -> Datatypes.comparison
                          val eq_dec : X.t -> X.t -> bool
                        end
                      module TO :
                        sig
                          type t = OTF.t
                          val compare : X.t -> X.t -> Datatypes.comparison
                          val eq_dec : X.t -> X.t -> bool
                        end
                    end
                  val eq_dec : X.t -> X.t -> bool
                  val lt_dec : X.t -> X.t -> bool
                  val eqb : X.t -> X.t -> bool
                end
            end
          val flatten_e : enumeration -> elt list
          type coq_R_bal =
            MakeRaw(I)(X).coq_R_bal =
              R_bal_0 of t * X.t * t
            | R_bal_1 of t * X.t * t * I.t * tree * X.t * tree
            | R_bal_2 of t * X.t * t * I.t * tree * X.t * tree
            | R_bal_3 of t * X.t * t * I.t * tree * X.t * tree * I.t * 
                tree * X.t * tree
            | R_bal_4 of t * X.t * t
            | R_bal_5 of t * X.t * t * I.t * tree * X.t * tree
            | R_bal_6 of t * X.t * t * I.t * tree * X.t * tree
            | R_bal_7 of t * X.t * t * I.t * tree * X.t * tree * I.t * 
                tree * X.t * tree
            | R_bal_8 of t * X.t * t
          type coq_R_remove_min =
            MakeRaw(I)(X).coq_R_remove_min =
              R_remove_min_0 of tree * elt * t
            | R_remove_min_1 of tree * elt * t * I.t * tree * X.t * tree *
                (t * elt) * coq_R_remove_min * t * elt
          type coq_R_merge =
            MakeRaw(I)(X).coq_R_merge =
              R_merge_0 of tree * tree
            | R_merge_1 of tree * tree * I.t * tree * X.t * tree
            | R_merge_2 of tree * tree * I.t * tree * X.t * tree * I.t *
                tree * X.t * tree * t * elt
          type coq_R_concat =
            MakeRaw(I)(X).coq_R_concat =
              R_concat_0 of tree * tree
            | R_concat_1 of tree * tree * I.t * tree * X.t * tree
            | R_concat_2 of tree * tree * I.t * tree * X.t * tree * I.t *
                tree * X.t * tree * t * elt
          type coq_R_inter =
            MakeRaw(I)(X).coq_R_inter =
              R_inter_0 of tree * tree
            | R_inter_1 of tree * tree * I.t * tree * X.t * tree
            | R_inter_2 of tree * tree * I.t * tree * X.t * tree * I.t *
                tree * X.t * tree * t * bool * t * tree * coq_R_inter *
                tree * coq_R_inter
            | R_inter_3 of tree * tree * I.t * tree * X.t * tree * I.t *
                tree * X.t * tree * t * bool * t * tree * coq_R_inter *
                tree * coq_R_inter
          type coq_R_diff =
            MakeRaw(I)(X).coq_R_diff =
              R_diff_0 of tree * tree
            | R_diff_1 of tree * tree * I.t * tree * X.t * tree
            | R_diff_2 of tree * tree * I.t * tree * X.t * tree * I.t *
                tree * X.t * tree * t * bool * t * tree * coq_R_diff * 
                tree * coq_R_diff
            | R_diff_3 of tree * tree * I.t * tree * X.t * tree * I.t *
                tree * X.t * tree * t * bool * t * tree * coq_R_diff * 
                tree * coq_R_diff
          type coq_R_union =
            MakeRaw(I)(X).coq_R_union =
              R_union_0 of tree * tree
            | R_union_1 of tree * tree * I.t * tree * X.t * tree
            | R_union_2 of tree * tree * I.t * tree * X.t * tree * I.t *
                tree * X.t * tree * t * bool * t * tree * coq_R_union *
                tree * coq_R_union
        end
      module E :
        sig
          type t = X.t
          val compare : X.t -> X.t -> Datatypes.comparison
          val eq_dec : X.t -> X.t -> bool
        end
      type elt = X.t
      type t_ = Raw.t
      val this : 'a -> 'a
      type t = t_
      val mem : X.t -> Raw.tree -> bool
      val add : X.t -> Raw.tree -> Raw.tree
      val remove : X.t -> Raw.tree -> Raw.tree
      val singleton : X.t -> Raw.tree
      val union : Raw.t -> Raw.t -> Raw.t
      val inter : Raw.tree -> Raw.t -> Raw.tree
      val diff : Raw.tree -> Raw.t -> Raw.tree
      val equal : Raw.tree -> Raw.tree -> bool
      val subset : Raw.tree -> Raw.tree -> bool
      val empty : Raw.tree
      val is_empty : Raw.tree -> bool
      val elements : Raw.tree -> X.t list
      val choose : Raw.tree -> X.t option
      val fold : (X.t -> 'a -> 'a) -> Raw.tree -> 'a -> 'a
      val cardinal : Raw.tree -> Datatypes.nat
      val filter : (X.t -> bool) -> Raw.tree -> Raw.tree
      val for_all : (X.t -> bool) -> Raw.tree -> bool
      val exists_ : (X.t -> bool) -> Raw.tree -> bool
      val partition : (X.t -> bool) -> Raw.tree -> Raw.tree * Raw.tree
      val eq_dec : Raw.tree -> Raw.tree -> bool
      val compare : Raw.tree -> Raw.tree -> Datatypes.comparison
      val min_elt : Raw.tree -> X.t option
      val max_elt : Raw.tree -> X.t option
    end
