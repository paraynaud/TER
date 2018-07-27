open Printf
open AST
open Maps
open Integers
open RTL
open BinNums
open BinPos
open Datatypes
open List0
open Op
open Registers

type ('f, 'v) fun_int =
|Fi of (ident * ('f, 'v) globdef)
|No
;;




let rec int_from_binnums x =
match x with
	| Coq_xI x1 -> let z = (int_from_binnums x1) in (2 * z +1)
	| Coq_xO x1 -> let z = int_from_binnums x1 in (2 * z )
	| Coq_xH -> 1
;;

let int_list_from_binnums_list x =
	List.map int_from_binnums x
;;


let to_String_binnums x =
	string_of_int (int_from_binnums x)
;;

let rec affiche_i_list i l =
	match (i,l) with
	| (0, _) -> []
	| (1, []) -> []
	| (1, e1::s) -> [e1]
	| (x ,[]) -> []
	| (x, e1::s) -> (affiche_i_list (x-1) s)
;;

let fun_split_extr_int i f =
	match f with
	|Internal x -> Fi(i,Gfun(f))
	|External x -> No 
;;

let fonction_split_fun_var (i,gd) =
	match gd with
	|Gfun f-> (fun_split_extr_int i f)
	|Gvar v-> No
;;

let rec fonction_interne_prog_defs  l =
	match l with 
	|e1::s -> (fonction_split_fun_var e1) :: ( fonction_interne_prog_defs s )
	|[] -> []
;;	

let rec filtrage x =
	match x with 
	|[] -> []
	|No::s -> (filtrage s)
	|Fi(x)::s -> x :: filtrage(s)
;;

let recuperation_fonction_interne {prog_defs = x1; prog_public = x2; prog_main = x3} =
	fonction_interne_prog_defs x1
;;


(* x contient la liste des fonctions interne du programme test *)







(** types du CFG**)

type triplet ={ noeud_t : int; instr_t : RTL.instruction; dir_t :int list}  
	[@@ deriving show];;

type quadruplet ={ noeud_q : int; pred_q : int list ; instr_q : RTL.instruction; dir_q :int list}  
	[@@ deriving show];;

type 'a cfg = {ident : int; param : reg list; signature : AST.signature ; entry_point : int ;instrs : 'a list}
	[@@ deriving show];;
(*type signature = { sig_args : typ list; sig_res : typ option;sig_cc:calling_convention }
type calling_convention = { cc_vararg : bool; cc_unproto : bool; cc_structret : bool }*)

type 'a cfg_complet = ('a cfg) list
	[@@ deriving show];;

type cfg_glob = 
	| T_cfg of triplet cfg
	| Q_cfg of quadruplet cfg
	[@@ deriving show]
;;

type cfg_list = cfg_glob list 
	[@@ deriving show];;

(*type cfg_fonction ={ident : int; param : reg list; entry_point : int ;instrs : triplet list};;*)
(** fin types du CFG**)


let get_ident_from_cfg cfg = 
	match cfg with
	|T_cfg(t_cfg) -> t_cfg.ident
	|Q_cfg(q_cfg) -> q_cfg.ident
;;

let get_entry_from_cfg cfg = 
	match cfg with
	|T_cfg(t_cfg) -> t_cfg.entry_point
	|Q_cfg(q_cfg) -> q_cfg.entry_point
;;

let rec get_dir_from_cfgT_instrs t_cfg n = 
	match t_cfg with
	| [] -> []
	| h :: t -> if h.noeud_t = n 
			then h.dir_t
			else get_dir_from_cfgT_instrs t n 					
;;

let rec get_dir_from_cfgQ_instrs q_cfg n = 
	match q_cfg with
	| [] -> []
	| h :: t -> if h.noeud_q = n 
			then h.dir_q
			else get_dir_from_cfgQ_instrs t n 	
;;


let get_dir_from_cfg_and_noeud cfg n = 
	match cfg with
	|T_cfg(t_cfg) -> get_dir_from_cfgT_instrs t_cfg.instrs n
	|Q_cfg(q_cfg) -> get_dir_from_cfgQ_instrs q_cfg.instrs n
;;



(*	#use "transition_cfg.ml";;	*)

(*
type 'a cfg = {ident : int; param : reg list; signature : AST.signature ; entry_point : int ;instrs : 'a list}
	[@@ deriving show];;
type signature = { sig_args : typ list; sig_res : typ option;sig_cc:calling_convention }
type calling_convention = { cc_vararg : bool; cc_unproto : bool; cc_structret : bool }*)


let rec get_couple_from_param_list_sig_arg prm_l typ_l = 
  match prm_l,typ_l with
  | ([],[]) -> [] 
  | (p1::tail1, typ1::tail2) -> ((P.to_int p1), (typ_to_type_var typ1)):: (get_couple_from_param_list_sig_arg tail1 tail2) 
;;

let get_couple_reg_param {ident = i; param = p_l ; signature = { sig_args= t_l; sig_res = t_o; sig_cc = sig_c }; entry_point = et; instrs= instr_l} =
  get_couple_from_param_list_sig_arg p_l t_l 
;;

let rec get_couple_reg_param_list cfg_l =
  match cfg_l with
  | [] -> []
  | h::t -> (h.ident, h.entry_point, get_couple_reg_param h) :: get_couple_reg_param_list t
;;




let special_return x =
	match x with
	| Some y -> []
	| None -> []
;;

let recup_dest i = 
	match i with 
	| Inop x -> [int_from_binnums x]
	| Iop (x1,x2,x3,x4) -> [int_from_binnums x4]
	| Iload (x1,x2,x3,x4,x5) -> [int_from_binnums x5]
	| Istore (x1,x2,x3,x4,x5) -> [int_from_binnums x5]
	| Icall (x1,x2,x3,x4,x5) -> [int_from_binnums x5]
	| Itailcall (x1,x2,x3) -> []
	| Ibuiltin (x1,x2,x3,x4) -> [int_from_binnums x4]
	| Icond (x1,x2,x3,x4) -> [int_from_binnums x3; int_from_binnums x4]
	| Ijumptable (x1,x2) -> [int_from_binnums x1]
	| Ireturn x -> special_return x
;;

(* /2 arrondi en dessous    
	attention aux idinces*)
let rec recherche_dico noeud l b_min b_sup =
	let milieu = (b_min + (b_sup - b_min)/2)  in
	(*printf " min :%d  max %d milieu %d" b_min b_sup milieu;*)
	let n_dico = (match List.nth_opt l milieu with
								|Some(x) -> x
								|None -> (noeud -1) 
								)
	in 
	if noeud = n_dico 
		then true
		else
			if b_min = b_sup 
			then false	
			else
				if n_dico > noeud 
				then recherche_dico noeud l (milieu+1) b_sup 
				else recherche_dico noeud l b_min (milieu)
;;
(*
 let x = [15;14;13;12;11;10;9;8;7;6;5;4;3;2;1] in recherche_dico 5 x 0 15;;
*)

let rec creation_triplet instrs =
	match instrs with
	| [] -> []
	| h :: t -> let (n , instr) = h in
 						 let y = recup_dest instr in 
							{noeud_t = n ; instr_t = instr; dir_t = y} :: (creation_triplet t)
;;

let rec creation_triplet_from_code2 f =
  let instrs =
    List.sort
      (fun (pc1, _) (pc2, _) -> Pervasives.compare pc2 pc1)
      (List.rev_map
        (fun (pc, i) -> (P.to_int pc, i))
        (PTree.elements f.fn_code)) in
				creation_triplet instrs
;;


let creation_triplet_from_fundef2 n f  = 
	(f.fn_entrypoint ,f.fn_params ,f.fn_sig,(creation_triplet_from_code2 f ))
;;



(** 1ere version visant créer des cfg de triplet**)

let creation_triplet_from_function n x = 
	match x with
	| Internal y -> creation_triplet_from_fundef2 n y
	| External y -> ( Coq_xH , [], {sig_args = []; sig_res = None; sig_cc = {cc_vararg = false; cc_unproto  = false; cc_structret = false } }, [])
(* il ne doit plus y avoir de function externe normalement*)
;;


let rec creation_triplet_from_globdef n gd=
	match gd with
	|	Gfun x -> creation_triplet_from_function n x
	|	Gvar x -> ( Coq_xH , [], {sig_args = []; sig_res = None;sig_cc = { cc_vararg = false; cc_unproto  = false; cc_structret = false } }, [])
(* normalement il ne doit plus y avoir de variable la dedans*)
;;




let creation_cfg_from_fun (i,gd) =
	let ( entry_point_f, param_f, sign_f, code_f) = (creation_triplet_from_globdef Coq_xH gd) in
	{ident = (int_from_binnums i); param = param_f; signature = sign_f; entry_point = (int_from_binnums entry_point_f) ; instrs = code_f}
;;

let rec creation_cfgS fonctions =
	match fonctions with
	| [] -> []
	| e::s -> (creation_cfg_from_fun e) :: (creation_cfgS s)
;;


(** 2eme version visant créer des cfg actuellement de triplet mais pouvant être traité de manière indépendante avec les quadruplet cfg**)

let rec creation_cfgS_v2 fonctions =
	match fonctions with
	| [] -> []
	| e::s -> T_cfg((creation_cfg_from_fun e)) :: (creation_cfgS_v2 s)
;;

let construction_cfgS fonctions =
	creation_cfgS_v2 fonctions 
;;












(* utilisation
let x = filtrage (recuperation_fonction_interne test);;

let cfg_test = creation_cfgS x;;

cfg_test;;

affiche_i_list 3 cfg_test;;
*)


(** la est le génie meme si je ne comprend pas tout**)
(* code developpé pour trouver la solution (la function ci dessous
let affich_from_fundef f =   
  let instrs =
    List.sort
      (fun (pc1, _) (pc2, _) -> Pervasives.compare pc2 pc1)
      (List.rev_map
        (fun (pc, i) -> (P.to_int pc, i))
        (PTree.elements f.fn_code)) in
	instrs
;;

let affich_from_fun  x = 
	match x with
	| Internal y -> affich_from_fundef  y
	| External y -> []
;;

let rec affich_from_globdef (i,gd) =
	match gd with
	|	Gfun x -> affich_from_fun x
	|	Gvar x -> []
;;

let rec delist x = 
	match x with
	| x :: [] -> x
	| h :: t -> delist t
;;

let main_59 = (affiche_i_list 3 x);;
let z = delist main_59;;

(**cette fonction résoud tous nos problèmes**)
let list_noeud_instrs = affich_from_globdef z ;;
(**cette fonction résoud tous nos problèmes**)

*)


(* PREMIER CODE 
Malheuresement comme il faut trier les instructions pour que ca ait du sens je ne le garde pas

let triplet_test  = 
	{ noeud_t = 5 ; instr_t = Ireturn( Some ( Coq_xH )); dir_t =  [3] }
;;

let get_instruction o =
	match o with 
	| Some i ->  (  i, (recup_dest i))
	| None ->  (Ireturn( Some ( Coq_xH )), [-585])
;;

let rec creation_triplet_from_code n fc =
	match fc with
	| PTree.Leaf ->  []
(*{noeud = (int_from_binnums n); instr = Ireturn( Some ( Coq_xH )); dir = []} :: []*)
	| PTree.Node(g,o,d) -> let (x,y) = (get_instruction o) in 
	 	 (List.append (creation_triplet_from_code (Coq_xO(n)) g) ({noeud = (int_from_binnums n); instr = x; dir = y} :: (creation_triplet_from_code (Coq_xI(n)) d) )) 
;;
let creation_triplet_from_fundef n {fn_sig =fs ; fn_params =fp ; fn_stacksize = f_stack ; fn_code = fc ; fn_entrypoint = fe } = 
	(fe,fp,(creation_triplet_from_code n fc ))
;;
*)


(*
elements de test:
use "/local/raynaudp/TER/CompCert_et_lib/CompCert/temp/aes.rtl.0";;
let coq_test = Coq_xI (Coq_xO( Coq_xO Coq_xH)) );;
show_positive coq_test;;
(*(List.append (List.append [] []) (List.append [] [1;2]));;*)
*)










