val hd : 'a -> 'a list -> 'a
val tl : 'a list -> 'a list
val in_dec : ('a -> 'b -> bool) -> 'b -> 'a list -> bool
val nth_error : 'a list -> Datatypes.nat -> 'a option
val remove : ('a -> 'b -> bool) -> 'a -> 'b list -> 'b list
val rev : 'a list -> 'a list
val rev_append : 'a list -> 'a list -> 'a list
val rev' : 'a list -> 'a list
val list_eq_dec : ('a -> 'b -> bool) -> 'a list -> 'b list -> bool
val map : ('a -> 'b) -> 'a list -> 'b list
val fold_left : ('a -> 'b -> 'a) -> 'b list -> 'a -> 'a
val fold_right : ('a -> 'b -> 'b) -> 'b -> 'a list -> 'b
val existsb : ('a -> bool) -> 'a list -> bool
val forallb : ('a -> bool) -> 'a list -> bool
val filter : ('a -> bool) -> 'a list -> 'a list
