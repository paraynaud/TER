(* recueil de fonction utiles : 
  - max
  get_nb_var_cfg_list
*)

(** get_nb_var**)
let max a b = 
  if a > b then a else b
;; 

let rec max_int_list i_l =
  match i_l with
  | [] -> 0
  | h::t -> max h (max_int_list t)
;;

let max_list reg_list = 
  let int_list = int_list_from_binnums_list reg_list in
  max_int_list int_list
;;
(* est-il necessaire de la modifier? j'ai l'impression que seules les opétations rajoutent des nouvelle variables
*)
let get_nb_max_from_instr i =
  match i with 
  | Inop s -> 0
  | Iop(op, args, res, s) -> max (max_list args) (int_from_binnums res)
(*  | Iload(chunk, addr, args, dst, s) ->
  | Istore(chunk, addr, args, src, s) ->
  | Icall(sg, fn, args, res, s) ->
  | Itailcall(sg, fn, args) ->
  | Ibuiltin(ef, args, res, s) ->
  | Icond(cond, args, s1, s2) ->
  | Ijumptable(arg, tbl) ->
  | Ireturn None ->
  | Ireturn (Some arg) ->*)
  | _ -> 0
;;

let get_nb_var_from_quad q =
  get_nb_max_from_instr q.instr_q
;;

let rec get_nb_var cfg = 
  match cfg with  
  | [] -> 0
  | h :: t -> max (get_nb_var_from_quad h) (get_nb_var t)
;;

let rec get_nb_var_cfg_list cfg_l = 
  match cfg_l with
  | [] -> []
  | h :: t -> (get_nb_var h.instrs):: (get_nb_var_cfg_list t)
;;

let get_max_var c_l = get_nb_var_cfg_list c_l ;;





(**PRINTERS**)




let printer_prop (id,ne) =
  "P_" ^ string_of_int id ^ "_" ^ string_of_int ne ^ " "
;;

let pavar (id,ne,n) = 
  "x_" ^ string_of_int id ^ "_" ^ string_of_int ne  ^ "_" ^ string_of_int n ^ " "
;;

let rec printer_var_test (id,ne,nb_var) cmpt= 
if cmpt = nb_var 
then pavar (id,ne,cmpt)
else pavar (id,ne,cmpt) ^ (printer_var_test (id,ne, nb_var ) (cmpt+1) )
;;

let printer_prop_ne_et_var (id,ne,nb_var) =
  printer_prop (id,ne) ^ (printer_var_test (id,ne,nb_var) 1)
;;


(** fin des printer test**)















let p_var id noeud i pred=
  match pred with
  | None ->   "x_" ^ string_of_int id ^ "_" ^ string_of_int noeud ^ "_" ^ string_of_int i 
  | Some x ->  "x_" ^ string_of_int id ^ "_" ^ string_of_int noeud ^ "_" ^ string_of_int x ^ "_" ^ string_of_int i ^ " "
;;

let rec printer_var2 noeud id i o_pred=
  match i with 
  | 0 -> ""
  | n ->  p_var id noeud n o_pred ^ printer_var2 noeud id (n-1) o_pred
;;
	


let rec p_t i =  
  match i with
  | 0 -> ""
  | n -> "\t" ^ p_t (n-1)
;;
  
let rec printer_int_list l = 
  match l with 
  | [] -> ""
  | h :: t -> (string_of_int h)  ^ " " ^ (printer_int_list t)
;;

let rec printer_var (i : int) = 
  match i with 
  | 0 -> ""
  | n ->   printer_var (n-1) ^ " " ^ "x" ^ string_of_int n 
;;

let rec printer_var_list l = 
	match l with
  | [] -> ""
  | h::t -> "x" ^ string_of_int h ^ " " ^ printer_var_list t
;;


let rec printer_var_special (i : int) ( l : int list ) =
  match l with 
  | [] -> printer_var i
  | h::t -> if h = i 
    then printer_var_special (i-1) t ^ " " ^ "x" ^ string_of_int i ^ "_bis"
    else printer_var_special (i-1) (h ::t )^ " " ^ "x" ^ string_of_int i
;;


