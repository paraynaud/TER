(*
ledit ocaml -I /local/raynaudp/TER/CompCert_et_lib/CompCert/fichier_mld/test_ledit/  -I /local/raynaudp/TER/CompCert_et_lib/CompCert/fichier_mld/src_backend/ -I /local/raynaudp/TER/CompCert_etbvjh_lib/CompCert/LIEN_AFFICHAGE/ocaml_dvp/ -open Camlcoq 
#use "topfind";;
#require "ppx_deriving.show"  ;;
#load "lib_cfg.cma";;
#use "Camlcoq.ml";;
#load "Camlcoq.cmo";;
#load "PrintOp.cmo";;
#use "/local/raynaudp/TER/CompCert_et_lib/CompCert/common/PrintAST.ml";;
#use "/local/raynaudp/TER/CompCert_et_lib/CompCert/resultat_rtl_paulo/gene_prop.rtl.3.0";;

#use "transition_cfg.ml";;
#use "transition_cfg2dir.ml";;
#use "fonctions_utiles.ml";;
#use "types_sig.ml";;
#use "generation_sig.ml";;
#use "test_extract_prop.ml";;
#use "biblio_printer.ml" ;;
#use "test_printer_prop.ml";;
#use "decl_fun_var.ml";;
#use "main.ml";;
*)
(* a deplacer plus tard*)
let equal_trip (id1,ne1,nb_var1) (id2,ne2,nb_var2) =
  (id1 = id2) && (ne1 = ne2)
;;

let rec list_fusion_no_occ l1 l2 = 
  match l1 with
  | [] -> l2
  | h :: t -> if List.exists (equal_trip h) l2 
      then list_fusion_no_occ t l2 
      else h :: list_fusion_no_occ t l2 
;;

let rec get_id_ne_to_print_variable exp_l=
  match exp_l with
  | Implie (e1,e2) -> list_fusion_no_occ (get_id_ne_to_print_variable e1) (get_id_ne_to_print_variable e2) 
  | And (e1,e2) -> list_fusion_no_occ (get_id_ne_to_print_variable e1) (get_id_ne_to_print_variable e2) 
  | Prop_N (id,ne,nb_var) -> [(id,ne,nb_var)]
  | Exp_ar (op,pd,pg,id,ne,dir) -> []
  | Exp_Bool (cond,pd,id,ne,dir) -> []
  | Undefined -> [] 
  | True -> []
  | End (i_opt,id,ne,nb_var) -> [(id,ne,nb_var)]
;;




let rec print_exp_log exp_l tab=
  match exp_l with
  | Implie (e1,e2) -> p_t tab ^ "( =>\n" ^ print_exp_log e1 (tab+1) ^ print_exp_log e2 (tab+1) ^ p_t tab ^ ")\n" 
  | And (e1,e2) -> p_t tab ^ "( and\n " ^ print_exp_log e1 (tab+1) ^ print_exp_log e2 (tab+1) ^ p_t tab ^ ")\n" 
  | Prop_N (id,ne,nb_var) -> p_t tab ^ "(" ^ printer_prop_ne_et_var (id,ne,nb_var) ^ ")\n"
  | Exp_ar (op,pd,pg,id,ne,dir) -> p_t tab ^ print_op_gen_to_Z3 (op,pd,pg,id,ne,dir)
  | Exp_Bool (cond,pd,id,ne,dir) -> 
    p_t tab ^ print_cond_gen_to_Z3 (cond,pd,id,ne,dir) 
  | Undefined -> p_t tab ^ "Undefined\n"
  | True -> p_t tab ^ "true\n"
  | End (i_opt,id,ne,nb_var) -> p_t tab ^"(=>\n" ^ p_t (tab+1) ^ "(" ^ printer_prop_ne_et_var (id,ne,nb_var) ^ ")\n" ^ p_t (tab+1)  ^ "(post_"^ string_of_int id ^ " " ^ (printer_var_test (id,ne,nb_var) 1) ^ ")\n"
(* a refaire 
reste a ameliorer*)
;;

let rec print_var_to_Z3 (id,ne,nb_var) s = 
  match nb_var with
  | 0 -> ""
  | n -> let type_var_tmp = List.nth s (n-1) in
    "(x_" ^ string_of_int id ^ "_" ^ string_of_int ne ^  "_" ^ string_of_int n ^" " ^ type_to_Z3 type_var_tmp ^ " ) " ^ print_var_to_Z3 (id,ne, (n-1) ) s
;;

let rec for_all_to_Z3 l sig_l= 
  match l with
  | [] -> ""
  | (id,ne,nb_var):: t -> 
    let s = get_sign_global !sig_l.table id ne in
    (print_var_to_Z3 (id,ne,nb_var) s )^  for_all_to_Z3 t sig_l
;;

let for_all l sig_l tab =
  p_t tab ^ ( match l with 
    | [] -> "" (*" attentiona  la prochaine parenthèse ecrite apres l'instruction il faut l'enlever \n"*)
    | _ -> "(forall ( "^ for_all_to_Z3 l sig_l ^")\n"
  )
;;

let rec print_prop_fun prop_l tab sig_l =
  match prop_l with
  | [] -> ""
  | h::t -> 
    let l = get_id_ne_to_print_variable h in 
    (for_all l sig_l tab) ^ (print_exp_log h (tab+1) ) ^ p_t tab ^ ")\n"^ (print_prop_fun t tab sig_l)
;;

let print_prop_fun_to_Z3 prop_l tab sig_l=
  p_t tab ^ "(and\n" ^ print_prop_fun prop_l (tab+1) sig_l ^   p_t tab ^ ")\n"
;;

let rec print_prop_fun_l prop_fun_l sig_l=
  match prop_fun_l with
  | [] -> ""
  | h::t -> "; nouveau cfg \n " ^ (print_prop_fun_to_Z3 h 1 sig_l) ^ (print_prop_fun_l t sig_l) 
;; 

let print_prop_to_Z3 prop_fun_l sig_l= 
"(assert \n" ^ print_prop_fun_l prop_fun_l sig_l^ "\n)\n"
;;


(*
    let sign_glob = get_sign_global sig_l id et in


let props = 
let x = filtrage (recuperation_fonction_interne test) in
let cfg_original = creation_cfgS x in
let cfg_original_2dir = creation_cfgQ_from_cfgT cfg_original in
extract_prop_cfg_list cfg_original_2dir ;;

printf "%s" (print_prop_fun_l props);;




*)











