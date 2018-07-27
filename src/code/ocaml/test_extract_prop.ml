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
#use "printer_propriete.ml";;
#use "decl_fun_var.ml";;
#use "main.ml";;
*)
(*
type triplet ={ noeud_q : int; instr_q : RTL.instruction; dir_q :int list}  
type quadruplet ={ noeud_q : int; pred_q : int list ; instr_q : RTL.instruction; dir_q :int list}  
type 'a cfg = {ident : int; param : reg list; entry_point : int ;instrs : 'a list}
*)


type noeud_inst = int;;
type dir_inst = int list ;;
type pred_u = int option
type inst_inst = RTL.instruction ;;
type ident_fun = int ;;
type pg = int (*la partie gauche d'un operation*) ;;
type pd = int list (*la partie droite d'un operation*) ;;
type arg = int option ;;
type args = int list ;;
type nb_var = int ;; 
type condition = 
  | T of Op.condition
  | N of Op.condition
;;
type reg_print = int list;;
type dir = int
(* le Or a ajouter pour les conditions tres probablement*)

type exp_log =
  | Implie of exp_log * exp_log
  | Prop_N of ident_fun * noeud_inst * nb_var 
  | Exp_ar of Op.operation * pd * pg * ident_fun * noeud_inst * dir
  | Exp_Bool of condition * pd *  ident_fun * noeud_inst * dir
  | Undefined
  | And of exp_log * exp_log
  | True
  | End of arg
;;
(** génération du corps d'un clause de horn**)
let var_classique id noeud dir i = 
  Exp_ar( Omove,  [i] , i ,id , noeud ,dir )
;;

let rec generation_var_sup id noeud i nv dir =
  if i = (nv +1)
    then True
    else 
			if i = nv 
				then (var_classique id noeud dir i )
				else And( (var_classique id noeud dir i ), (generation_var_sup id noeud (i+1) nv dir ) )
;;

let rec generation_var_inf id noeud i dir =
  match i with 
  |0 -> True
	|1 -> (var_classique id noeud dir i )
  | _ -> And( (var_classique id noeud dir i ) , (generation_var_inf id noeud (i-1) dir ) )
;;

let generation_var_op (id,noeud,n_v) var_modif  dir  = 
  match var_modif with
  |[ ] -> generation_var_inf id noeud n_v dir 
  |[e] -> And( 
            (generation_var_sup id noeud (e+1) n_v dir),
            (generation_var_inf id noeud (e-1) dir ) 
          )
  | _  -> Undefined
;;

let generation_body  (id,ne,nb_var)  var_modif dir=
  And( Prop_N(id,ne,nb_var), generation_var_op (id,ne,nb_var) var_modif dir)
;;
(** fin de la génération  du corps d'une clause de horn**)


let make_Exp op pd pg id ne dir =
  match op with
  (*| Ocmp cond-> Exp_Bool(T(cond), (int_list_from_binnums_list pd), id, ne , dir) on laissera probablement comme ca*)
  | _  -> Exp_ar(op, (int_list_from_binnums_list pd), (P.to_int pg), id, ne , dir)



let extract_prop_instr (id,nb_var) inst = 
  match inst.instr_q with
	| Inop x -> 
    Implie( 
      (generation_body (id, inst.noeud_q,nb_var) [] (List.nth inst.dir_q 0))
    ,
      Prop_N(id,(List.nth inst.dir_q 0),nb_var) 
    )
	| Iop (op,pd,pg,dir) -> 
    Implie(
      And(
        (generation_body (id, inst.noeud_q,nb_var) [P.to_int pg] (List.nth inst.dir_q 0) ) 
      ,
        (make_Exp op pd pg id (inst.noeud_q) (List.nth inst.dir_q 0) ) 
      )
    , 
      Prop_N(id,(List.nth inst.dir_q 0),nb_var) 
    )
	| Icond (cond,args,dir1,dir2) -> 
    And(
      Implie(
        And(
          (generation_body (id, inst.noeud_q,nb_var) [] (P.to_int dir1) )           
        ,
          Exp_Bool( T(cond), (int_list_from_binnums_list args), id, inst.noeud_q, (P.to_int dir1) ) 
        )
      ,
        Prop_N(id,(P.to_int dir1),nb_var) 
      )
    ,
      Implie(
        And(
          (generation_body (id, inst.noeud_q,nb_var) [] (P.to_int dir2) )           
        ,
          Exp_Bool( N(cond), (int_list_from_binnums_list args), id, inst.noeud_q, (P.to_int dir2) ) 
        )
      ,
        Prop_N(id,(P.to_int dir2),nb_var) 
      )
    )
	| Ireturn x -> (
		match x with 
		| None -> End(None )
		| Some y  -> End(Some(P.to_int y) )
	
	)
  | _ -> Undefined 
;;

(*type exp_log =
  | Implie of exp_log * exp_log
  | Prop_N of ident_fun * noeud_inst * nb_var 
  | Exp_ar of Op.operation * pd * pg * ident_fun * noeud_inst 
  | And of exp_log * exp_log*)
let rec extract_prop_instr_l (id,nb_var) instr_l  =
  match instr_l with
  | [] ->  []
  | h::t -> (extract_prop_instr (id,nb_var) h) :: (extract_prop_instr_l (id,nb_var) t)
;;


(*
  #use "test_extract_prop.ml";;  
#use "printer_propriete.ml";;
*)


let extract_prop_cfg cfg = 
  let nb_var = get_nb_var cfg.instrs in 
  extract_prop_instr_l (cfg.ident,nb_var) cfg.instrs 
;;

let rec extract_prop_cfg_list cfg_l = 
	match cfg_l with
  | [] -> []
  | h::t -> extract_prop_cfg h  :: extract_prop_cfg_list t
;;

let prop_extraites = 
let x = filtrage (recuperation_fonction_interne test) in
let cfg_original = creation_cfgS x in
let cfg_original_2dir = creation_cfgQ_from_cfgT cfg_original in
extract_prop_cfg_list cfg_original_2dir ;;



printf "%s" ("la taille de la list est : " ^ string_of_int (List.length (List.nth prop_extraites 1)) ^ "\n");;
List.nth  (List.nth prop_extraites 1) 10 ;;
List.nth  (List.nth prop_extraites 1) 9 ;;
List.nth  (List.nth prop_extraites 1) 8 ;;
List.nth  (List.nth prop_extraites 1) 7 ;;
List.nth  (List.nth prop_extraites 1) 6 ;;
List.nth  (List.nth prop_extraites 1) 5;;
List.nth  (List.nth prop_extraites 1) 4 ;;
List.nth  (List.nth prop_extraites 1) 3 ;;
List.nth  (List.nth prop_extraites 1) 2 ;;
List.nth  (List.nth prop_extraites 1) 1 ;;
List.nth  (List.nth prop_extraites 1) 0 ;;

























