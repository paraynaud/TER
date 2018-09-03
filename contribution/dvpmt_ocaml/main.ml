(*
ledit ocaml -I /local/raynaudp/TER/CompCert_et_lib/CompCert/fichier_mld/test_ledit/  -I /local/raynaudp/TER/CompCert_et_lib/CompCert/fichier_mld/src_backend/ -open Camlcoq 
#use "topfind";;
#require "ppx_deriving.show"  ;;
#load "lib_cfg.cma";;
#use "Camlcoq.ml";;
#load "Camlcoq.cmo";;
#load "PrintOp.cmo";;
#use "/local/raynaudp/TER/CompCert_et_lib/CompCert/common/PrintAST.ml";;

#use "/local/raynaudp/TER/CompCert_et_lib/CompCert/resultat_rtl_paulo/valeur_absolue.rtl.3.0";;

#use "types_sig.ml";;
#use "transition_cfg.ml";;
#use "transition_cfg2dir.ml";;
#use "fonctions_utiles.ml";;
#use "extract_propriete.ml";;
#use "biblio_printer.ml";;
#use "generation_sig.ml";;
#use "decl_fun_var.ml";;
#use "printer_propriete.ml";;
#use "printer_to_Z3_decl.ml";;

#use "main.ml";;

#use "/local/raynaudp/TER/CompCert_et_lib/CompCert/resultat_rtl_paulo/gene_prop.rtl.3.0";;
#use "/local/raynaudp/TER/CompCert_et_lib/CompCert/resultat_rtl_paulo/test_presentation2.rtl.0.3";;
#use "/local/raynaudp/TER/CompCert_et_lib/CompCert/resultat_rtl_paulo/aes.rtl.8.0";;
#use "/local/raynaudp/TER/CompCert_et_lib/CompCert/resultat_rtl_paulo/demonstration_1_arg.rtl.0.3";;
#use "/local/raynaudp/TER/CompCert_et_lib/CompCert/resultat_rtl_paulo/milieu.rtl.0.3";;
#use "/local/raynaudp/TER/CompCert_et_lib/CompCert/resultat_rtl_paulo/milieu.rtl.1.3";;
*)

(* code à executer*)
let x = filtrage (recuperation_fonction_interne test) ;;
let cfg_original = creation_cfgS x ;;
let cfg_original_2dir = creation_cfgQ_from_cfgT cfg_original ;;
let prop_extraites = extract_prop_cfg_list cfg_original_2dir ;;
let sig_list = ref {debut = 0 ; fin = -1; table =  [] };;
sig_list := !(main_test2 cfg_original_2dir) ;;(* sig list est donc la liste des signatures obtenus*)
sig_list;;
printf"\n\n\n mtn sig_lsit";;



(print_global_Z3  !sig_list ) ;;
let oc =  open_out( "/local/raynaudp/TER/CompCert_et_lib/CompCert/LIEN_AFFICHAGE/original/test_Z3.txt");;

printf"step1\n\n";

fprintf oc "%s\n" (print_global_Z3  !sig_list ) ;

printf "%s\n" (print_global_Z3  !sig_list );

fprintf oc "%s" (print_prop_to_Z3 prop_extraites sig_list);;

printf"step3\n\n";

fprintf oc "%s" ("\n(check-sat)\n;(get-model)\n");

close_out oc;;

(*test sur aes.rtl
printf "\n\n\n\ntest\n\n\n\n";
List.nth (main_test3 1).ss_table 173;;
printf "\n\n\n\ntest2\n\n\n\n";

List.nth (List.nth (main_test3 1).ss_table 220).c_s_p 0;;
List.nth (List.nth (main_test3 1).ss_table 220).c_s_p 1;;
List.nth (List.nth (main_test3 1).ss_table 220).c_s_p 2;;
*)
(*
	printf "%s" (to_String_prop_cfg_list prop_extraites);

;;

let _ = 
	printf "%s" ( print_def_fun_from_prop_list prop_extraites)
;;
*)
