open AST
(*
  #use "types_sig.ml";;
   *)
type type_var = 
  |F
  |I
  |B
  |Min
  |Tab

let to_String_type_var t= 
  match t with 
  | F -> "F"
	| I -> "I "
  | B -> "B "
  | Min -> "Min "
  | Tab -> "Tab "
;;

let type_to_Z3 t=
  match t with 
  | F -> "Float "
	| I -> "Int "
  | B -> "Bool "
  | Min -> "erreur"
  | Tab -> "pas encore fait "
;;  
let sup_type_F t = 
  match t with
  | F -> F
  | I -> F
  | B -> F
  | Min -> F
  | Tab -> Tab
;;

let sup_type_I t = 
  match t with
  | F -> F
  | I -> I
  | B -> I
  | Min -> I
  | Tab -> Tab
;;

let sup_type_B t = 
  match t with
  | F -> F
  | I -> I
  | B -> B
  | Min -> B
  | Tab -> Tab
;;

let sup_type_Min t = 
  match t with
  | F -> F
  | I -> I
  | B -> B
  | Min -> Min
  | Tab -> Tab
;;

let sup_type_Tab t = 
  match t with
  | F -> Tab
  | I -> Tab
  | B -> Tab
  | Min -> Tab
  | Tab -> Tab
;;


let sup_type (t1 : type_var) (t2 : type_var) = 
  match t1 with
  | F -> sup_type_F t2
  | I -> sup_type_I t2
  | B -> sup_type_B t2
  | Min -> sup_type_Min t2
  | Tab -> sup_type_Tab t2
;;

let rec map_spec f l1 l2 =
	match (l1,l2) with
	| ([],[]) -> []
	| ([], x) -> x 
	| (x, []) -> x
	| (h1::t1 , h2::t2) ->  (f h1 h2) :: (map_spec f t1 t2)
;;
 
let map_spec_plus_first l1 l2 = map_spec sup_type l1 l2 ;;


let typ_to_type_var t =
  match t with
  | Tint -> I
  | Tfloat -> F
  | Tlong -> I
  | Tsingle -> I
  | Tany32 -> I
  | Tany64 -> I
;;
