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




let rec print_exp_log exp_l tab=
  match exp_l with
  | Implie (e1,e2) -> p_t tab ^ "( =>\n" ^ print_exp_log e1 (tab+1) ^ print_exp_log e2 (tab+1) ^ p_t tab ^ ")\n" 
  | And (e1,e2) -> p_t tab ^ "( and\n " ^ print_exp_log e1 (tab+1) ^ print_exp_log e2 (tab+1) ^ p_t tab ^ ")\n" 
  | Prop_N (id,ne,nb_var) -> p_t tab ^ printer_prop_ne_et_var (id,ne,nb_var) ^ "\n"
  | Exp_ar (op,pd,pg,id,ne,dir) -> p_t tab ^ print_op_gen_to_Z3 (op,pd,pg,id,ne,dir)
  | Exp_Bool (cond,pd,id,ne,dir) -> 
    p_t tab ^ print_cond_gen_to_Z3 (cond,pd,id,ne,dir) 
  | Undefined -> p_t tab ^ "Undefined\n"
  | True -> p_t tab ^ "true\n"
  | End (i_opt) -> p_t tab ^ (match i_opt with |None -> "return" | Some x -> "return x") ^ "\n"
;;

let rec print_prop_fun prop_l =
  match prop_l with
  | [] -> ""
  | h::t -> (print_exp_log h 0 ) ^ (print_prop_fun t)
;;


let rec print_prop_fun_l prop_fun_l =
	match prop_fun_l with
  | [] -> ""
  | h::t -> "nouvelle fonction\n " ^ (print_prop_fun h) ^ (print_prop_fun_l t) 
;; 


(*
let props = 
let x = filtrage (recuperation_fonction_interne test) in
let cfg_original = creation_cfgS x in
let cfg_original_2dir = creation_cfgQ_from_cfgT cfg_original in
extract_prop_cfg_list cfg_original_2dir ;;
printf "%s" (print_prop_fun_l props);;
*)











