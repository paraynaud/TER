(*
#use "printer_to_Z3_decl.ml";;
*)

let rec print_sig_to_Z3 s=
  match s with 
  | [] -> ""
  | h::t -> type_to_Z3 h ^ print_sig_to_Z3 t
;;

let print_decl_noeud  (id,ne) c_s_p_l =
match c_s_p_l with
  | [] -> ""
  | {prede =p ; sign = s}::t -> (
    match p with 
    | None -> "(declare-fun P_" ^ string_of_int id ^ "_" ^ string_of_int ne ^  " (" ^ print_sig_to_Z3 s ^  ") Bool)\n"
    | Some x -> ""
  )
;;

let rec print_decl_noeud_l id noeud_l =
  match noeud_l with
  | [] -> ""
  | h::t -> print_decl_noeud (id,h.noeud) h.c_s_p  ^ print_decl_noeud_l id t
;;

let rec print_decl_fun { indice = id; debut_ss = d ; fin_ss = f; ss_table = cns_l } =
 print_decl_noeud_l id cns_l
;;

let rec print_decl_fun_Z3 sig_l =
	match sig_l with
	| [] -> ""
	| h::t -> print_decl_fun h ^  print_decl_fun_Z3 t
;;



let rec decl_post table  = 
	match table with
	| [] -> ""
	| h::t -> "(define-fun post_" ^ string_of_int h.indice  ^" ((x1 Int)(x2 Int) (x3 Int) (x4 Int) (x5 Int)) Bool\n\t (or (= x3 5) (= x3 6))\n)\n" ^ decl_post t
;;

let decl_usefull_fun sig_l = 
"(define-fun bool_to_int( (b Bool) )  Int\n\t(if (= b true )\n\t\t1
\n\t\t0\n\t) \n)\n" ^ decl_post sig_l.table ^ "\n" (*^ 
"(define-fun pre ((x1 Int)(x2 Int) (x3 Int) (x4 Int) (x5 Int)) Bool\n\t(and (= x1 0 ) (= x2 0 ) (= x3 0 ) (= x4 0 ) (= x5 0 ) )\n)\n"*);;

let pre_cond =""
(*"(declare-const x1 Int)\n(declare-const x2 Int)\n(declare-const x3 Int)\n(declare-const x4 Int)\n(declare-const x5 Int)\n (assert(and (pre x1 x2 x3 x4 x5) (P_57_11 x1 x2 x3 x4 x5) ) )"*)
;;
let print_global_Z3 sig_l =
  ";declaration des fonctions\n " ^ print_decl_fun_Z3 sig_l.table ^ "\n; declaration des fonctions utiles\n" ^ decl_usefull_fun sig_l ^ pre_cond ^ "\n"
;;























(*
let rec printer_var_noeud_to_Z3 instr id s nb_var =
match nb_var with
	| 0 -> ""
	| n -> "x_" ^ string_of_int id ^ "_" ^ string_of_int instr.noeud_q ^" " ^ s
;;

let rec print_var_from_cfg_to_Z3 quad_l id s nb_var= 
  match quad_l with
  | [] -> ""
  | h::t -> printer_var_noeud_to_Z3 h id s nb_var ^ printer_var_from_cfg_to_Z3
;;


let rec print_decl_var_to_Z3 sig_l cfg_l =
  match cfg_l with 
  | [] -> ""
  | h::t -> 
    let id = h.ident in 
    let et = h.entry_point in 
    let nb_var = get_nb_var h.instrs in
    let sign_glob = get_sign_global sig_l id et in
    (print_var_from_cfg_to_Z3 h.instrs id sign nb_var) ^ print_decl_var_to_Z3  sig_l t
;;
 ^ "\n\n declaration des variables mtn\n\n" ^ print_decl_var_to_Z3 sig_l.table cfg_l*) 

