module type TREE =
  sig
    type elt
    val elt_eq : elt -> elt -> bool
    type 'x t
    val empty : 'a1 t
    val get : elt -> 'a1 t -> 'a1 option
    val set : elt -> 'a1 -> 'a1 t -> 'a1 t
    val remove : elt -> 'a1 t -> 'a1 t
    val beq : ('a1 -> 'a1 -> bool) -> 'a1 t -> 'a1 t -> bool
    val map : (elt -> 'a1 -> 'a2) -> 'a1 t -> 'a2 t
    val map1 : ('a1 -> 'a2) -> 'a1 t -> 'a2 t
    val combine :
      ('a1 option -> 'a2 option -> 'a3 option) -> 'a1 t -> 'a2 t -> 'a3 t
    val elements : 'a1 t -> (elt * 'a1) list
    val fold : ('a2 -> elt -> 'a1 -> 'a2) -> 'a1 t -> 'a2 -> 'a2
    val fold1 : ('a2 -> 'a1 -> 'a2) -> 'a1 t -> 'a2 -> 'a2
  end
module PTree :
  sig
    type elt = BinNums.positive
    val elt_eq : BinNums.positive -> BinNums.positive -> bool
    type 'a tree = Leaf | Node of 'a tree * 'a option * 'a tree
    type 'a t = 'a tree
    val empty : 'a tree
    val get : BinNums.positive -> 'a tree -> 'a option
    val set : BinNums.positive -> 'a -> 'a tree -> 'a tree
    val remove : BinNums.positive -> 'a tree -> 'a tree
    val bempty : 'a tree -> bool
    val beq : ('a -> 'b -> bool) -> 'a tree -> 'b tree -> bool
    val prev_append :
      BinNums.positive -> BinNums.positive -> BinNums.positive
    val prev : BinNums.positive -> BinNums.positive
    val xmap :
      (BinNums.positive -> 'a -> 'b) ->
      'a tree -> BinNums.positive -> 'b tree
    val map : (BinNums.positive -> 'a -> 'b) -> 'a tree -> 'b tree
    val map1 : ('a -> 'b) -> 'a tree -> 'b tree
    val coq_Node' : 'a tree -> 'a option -> 'a tree -> 'a tree
    val filter1 : ('a -> bool) -> 'a tree -> 'a tree
    val xcombine_l :
      ('a option -> 'b option -> 'c option) -> 'a tree -> 'c tree
    val xcombine_r :
      ('a option -> 'b option -> 'c option) -> 'b tree -> 'c tree
    val combine :
      ('a option -> 'b option -> 'c option) -> 'a tree -> 'b tree -> 'c tree
    val xelements :
      'a tree ->
      BinNums.positive ->
      (BinNums.positive * 'a) list -> (BinNums.positive * 'a) list
    val elements : 'a tree -> (BinNums.positive * 'a) list
    val xkeys : 'a tree -> BinNums.positive -> BinNums.positive list
    val xfold :
      ('a -> BinNums.positive -> 'b -> 'a) ->
      BinNums.positive -> 'b tree -> 'a -> 'a
    val fold : ('a -> BinNums.positive -> 'b -> 'a) -> 'b tree -> 'a -> 'a
    val fold1 : ('a -> 'b -> 'a) -> 'b tree -> 'a -> 'a
  end
module PMap :
  sig
    type 'a t = 'a * 'a PTree.t
    val init : 'a -> 'a * 'b PTree.tree
    val get : BinNums.positive -> 'a * 'a PTree.tree -> 'a
    val set :
      BinNums.positive -> 'a -> 'b * 'a PTree.tree -> 'b * 'a PTree.tree
    val map : ('a -> 'b) -> 'a * 'a PTree.tree -> 'b * 'b PTree.tree
  end
module type INDEXED_TYPE =
  sig type t val index : t -> BinNums.positive val eq : t -> t -> bool end
module IMap :
  functor (X : INDEXED_TYPE) ->
    sig
      type elt = X.t
      val elt_eq : X.t -> X.t -> bool
      type 'x t = 'x PMap.t
      val init : 'a -> 'a * 'b PTree.tree
      val get : X.t -> 'a * 'a PTree.tree -> 'a
      val set : X.t -> 'a -> 'b * 'a PTree.tree -> 'b * 'a PTree.tree
      val map : ('a -> 'b) -> 'a * 'a PTree.tree -> 'b * 'b PTree.tree
    end
module ZIndexed :
  sig
    type t = BinNums.coq_Z
    val index : BinNums.coq_Z -> BinNums.positive
    val eq : BinNums.coq_Z -> BinNums.coq_Z -> bool
  end
module ZMap :
  sig
    type elt = ZIndexed.t
    val elt_eq : ZIndexed.t -> ZIndexed.t -> bool
    type 'x t = 'x PMap.t
    val init : 'a -> 'a * 'b PTree.tree
    val get : ZIndexed.t -> 'a * 'a PTree.tree -> 'a
    val set : ZIndexed.t -> 'a -> 'b * 'a PTree.tree -> 'b * 'a PTree.tree
    val map : ('a -> 'b) -> 'a * 'a PTree.tree -> 'b * 'b PTree.tree
  end
module ITree :
  functor (X : INDEXED_TYPE) ->
    sig
      type elt = X.t
      val elt_eq : X.t -> X.t -> bool
      type 'x t = 'x PTree.t
      val empty : 'a PTree.tree
      val get : X.t -> 'a PTree.tree -> 'a option
      val set : X.t -> 'a -> 'a PTree.tree -> 'a PTree.tree
      val remove : X.t -> 'a PTree.tree -> 'a PTree.tree
      val beq : ('a -> 'b -> bool) -> 'a PTree.tree -> 'b PTree.tree -> bool
      val combine :
        ('a option -> 'b option -> 'c option) ->
        'a PTree.tree -> 'b PTree.tree -> 'c PTree.tree
    end
module ZTree :
  sig
    type elt = ZIndexed.t
    val elt_eq : ZIndexed.t -> ZIndexed.t -> bool
    type 'x t = 'x PTree.t
    val empty : 'a PTree.tree
    val get : ZIndexed.t -> 'a PTree.tree -> 'a option
    val set : ZIndexed.t -> 'a -> 'a PTree.tree -> 'a PTree.tree
    val remove : ZIndexed.t -> 'a PTree.tree -> 'a PTree.tree
    val beq : ('a -> 'b -> bool) -> 'a PTree.tree -> 'b PTree.tree -> bool
    val combine :
      ('a option -> 'b option -> 'c option) ->
      'a PTree.tree -> 'b PTree.tree -> 'c PTree.tree
  end
module Tree_Properties :
  functor (T : TREE) ->
    sig
      val cardinal : 'a T.t -> Datatypes.nat
      val for_all : 'a T.t -> (T.elt -> 'a -> bool) -> bool
      val exists_ : 'a T.t -> (T.elt -> 'a -> bool) -> bool
      val coq_Equal_dec : ('a -> 'a -> bool) -> 'a T.t -> 'a T.t -> bool
      val coq_Equal_EqDec : ('a -> 'a -> bool) -> 'a T.t -> 'a T.t -> bool
      val of_list : (T.elt * 'a) list -> 'a T.t
    end
module PTree_Properties :
  sig
    val cardinal : 'a PTree.t -> Datatypes.nat
    val for_all : 'a PTree.t -> (PTree.elt -> 'a -> bool) -> bool
    val exists_ : 'a PTree.t -> (PTree.elt -> 'a -> bool) -> bool
    val coq_Equal_dec :
      ('a -> 'a -> bool) -> 'a PTree.t -> 'a PTree.t -> bool
    val coq_Equal_EqDec :
      ('a -> 'a -> bool) -> 'a PTree.t -> 'a PTree.t -> bool
    val of_list : (PTree.elt * 'a) list -> 'a PTree.t
  end
