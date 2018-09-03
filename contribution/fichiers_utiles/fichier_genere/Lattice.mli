module type SEMILATTICE =
  sig type t val beq : t -> t -> bool val bot : t val lub : t -> t -> t end
module type SEMILATTICE_WITH_TOP =
  sig
    type t
    val beq : t -> t -> bool
    val bot : t
    val lub : t -> t -> t
    val top : t
  end
module LPMap1 :
  functor (L : SEMILATTICE) ->
    sig
      type t = L.t Maps.PTree.t
      val get : BinNums.positive -> L.t Maps.PTree.tree -> L.t
      val set :
        BinNums.positive -> L.t -> L.t Maps.PTree.tree -> L.t Maps.PTree.tree
      val beq : L.t Maps.PTree.tree -> L.t Maps.PTree.tree -> bool
      val bot : 'a Maps.PTree.tree
      val opt_beq : L.t option -> L.t option -> bool
      type changed = Unchanged | Changed of L.t Maps.PTree.t
      val combine_l :
        (L.t option -> 'a option -> L.t option) ->
        L.t Maps.PTree.tree -> changed
      val combine_r :
        ('a option -> L.t option -> L.t option) ->
        L.t Maps.PTree.tree -> changed
      type changed2 = Same | Same1 | Same2 | CC of L.t Maps.PTree.t
      val xcombine :
        (L.t option -> L.t option -> L.t option) ->
        L.t Maps.PTree.tree -> L.t Maps.PTree.tree -> changed2
      val combine :
        (L.t option -> L.t option -> L.t option) ->
        L.t Maps.PTree.t -> L.t Maps.PTree.t -> L.t Maps.PTree.t
      val lub : L.t Maps.PTree.t -> L.t Maps.PTree.t -> L.t Maps.PTree.t
    end
module LPMap :
  functor (L : SEMILATTICE_WITH_TOP) ->
    sig
      type t' = Bot | Top_except of L.t Maps.PTree.t
      type t = t'
      val get : BinNums.positive -> t' -> L.t
      val set : BinNums.positive -> L.t -> t' -> t'
      val beq : t' -> t' -> bool
      val bot : t'
      val top : t'
      module LM :
        sig
          type t = L.t Maps.PTree.t
          val get : BinNums.positive -> L.t Maps.PTree.tree -> L.t
          val set :
            BinNums.positive ->
            L.t -> L.t Maps.PTree.tree -> L.t Maps.PTree.tree
          val beq : L.t Maps.PTree.tree -> L.t Maps.PTree.tree -> bool
          val bot : 'a Maps.PTree.tree
          val opt_beq : L.t option -> L.t option -> bool
          type changed =
            LPMap1(L).changed =
              Unchanged
            | Changed of L.t Maps.PTree.t
          val combine_l :
            (L.t option -> 'a option -> L.t option) ->
            L.t Maps.PTree.tree -> changed
          val combine_r :
            ('a option -> L.t option -> L.t option) ->
            L.t Maps.PTree.tree -> changed
          type changed2 =
            LPMap1(L).changed2 =
              Same
            | Same1
            | Same2
            | CC of L.t Maps.PTree.t
          val xcombine :
            (L.t option -> L.t option -> L.t option) ->
            L.t Maps.PTree.tree -> L.t Maps.PTree.tree -> changed2
          val combine :
            (L.t option -> L.t option -> L.t option) ->
            L.t Maps.PTree.t -> L.t Maps.PTree.t -> L.t Maps.PTree.t
          val lub : L.t Maps.PTree.t -> L.t Maps.PTree.t -> L.t Maps.PTree.t
        end
      val opt_lub : L.t -> L.t -> L.t option
      val lub : t' -> t' -> t'
    end
module LFSet :
  functor (S : FSetInterface.WS) ->
    sig
      type t = S.t
      val beq : S.t -> S.t -> bool
      val bot : S.t
      val lub : S.t -> S.t -> S.t
    end
module LBoolean :
  sig
    type t = bool
    val beq : bool -> bool -> bool
    val bot : bool
    val top : bool
    val lub : bool -> bool -> bool
  end
