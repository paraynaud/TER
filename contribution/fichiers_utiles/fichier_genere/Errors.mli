type errcode =
    MSG of char list
  | CTX of BinNums.positive
  | POS of BinNums.positive
type errmsg = errcode list
val msg : char list -> errcode list
type 'a res = OK of 'a | Error of errmsg
val assertion_failed : 'a res
val mmap : ('a -> 'b res) -> 'a list -> 'b list res
