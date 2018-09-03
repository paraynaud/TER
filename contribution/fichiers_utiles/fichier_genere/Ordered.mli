module OrderedPositive :
  sig
    type t = BinNums.positive
    val compare :
      BinNums.positive -> BinNums.positive -> 'a OrderedType.coq_Compare
    val eq_dec : BinNums.positive -> BinNums.positive -> bool
  end
module OrderedZ :
  sig
    type t = BinNums.coq_Z
    val compare :
      BinNums.coq_Z -> BinNums.coq_Z -> 'a OrderedType.coq_Compare
  end
module OrderedIndexed :
  functor (A : Maps.INDEXED_TYPE) ->
    sig
      type t = A.t
      val compare : A.t -> A.t -> 'a OrderedType.coq_Compare
      val eq_dec : A.t -> A.t -> bool
    end
