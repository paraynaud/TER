


let init_quad { noeud_t = n ; instr_t = i ; dir_t = d } =
	{ noeud_q = n; pred_q = [] ; instr_q = i; dir_q = d}
;;

let rec init_quad_list il =
	match il with
	| [] -> []
	| h :: t -> (init_quad h) :: (init_quad_list t)
;;


let f n d instr_qa = 
	if ( instr_qa.noeud_q = d)
		then { pred_q = ( List.append instr_qa.pred_q  [n] ) ;noeud_q = instr_qa.noeud_q ; instr_q = instr_qa.instr_q; dir_q = instr_qa.dir_q}
	else instr_qa
;;

let rec find_instr_and_change n d instrsq =
	match instrsq with
	| [] -> []
	| h :: t -> (f n d h) :: (find_instr_and_change n d t )
;; 


let rec ajout_prec_from_h instr_t instrsq = 
	let prec = instr_t.noeud_t in 
	let rec f_temp int_l instrsq_temp = 
		match int_l with
		| [] -> instrsq_temp
		| h::t -> let instrsq_ajout = (find_instr_and_change prec h instrsq_temp) in
							(f_temp t instrsq_ajout)
	in 
	f_temp instr_t.dir_t instrsq
;;

let rec construction_prec instrs_t instrs_q =
	match instrs_t with
	| [] -> instrs_q
	| h :: t -> let new_instrs_q = (ajout_prec_from_h h instrs_q) in
							(construction_prec t new_instrs_q) 
;;

let init_cfg_q {ident = id ; param = p ; signature =s; entry_point = e; instrs = il} =
	let instr_init = (init_quad_list il) in
	let instr_scd = (construction_prec il instr_init) in 
	{ident = id; param = p; signature = s; entry_point = e ;instrs = instr_scd};
;;


let creation_cfg_to_cfg2 cfg_t =
	let cfg_q = init_cfg_q cfg_t in
	cfg_q
;;

let rec creation_cfgQ_from_cfgT tl = 
	match tl with 
	| [] -> []
	| h :: t -> (creation_cfg_to_cfg2 h) :: (creation_cfgQ_from_cfgT t)
;;



let rec get_noeud ne l_instr =
  match l_instr with
  | [] -> None
  | h::t ->   
      let noeud = h.noeud_q in
      if noeud = ne 
        then 
          Some h
        else 
          get_noeud ne t
;;

let rec get_quad id ne cfg =
	match cfg with
	| [] -> None
	| h::t -> 
    let identificateur = h.ident in
    if identificateur = id 
      then
        let instrs = h.instrs in
        get_noeud ne instrs
      else
        get_quad id ne t
;;


(* 	#use "transition_cfg2dir.ml";;	*)
(*
let _ = 
	get_quad 57 10 !cfg_utile	
;;
*)













(** afficahge dans un fichier pour vérifier les predecesseurs**)

let toString_quadruplet instr = 
	show_quadruplet instr
;;

let rec toString_quadruplets instrs = 
	match instrs with
	| [] -> "" 
	| h :: t -> (toString_quadruplet h) ^ (toString_quadruplets t)
;;

let rec toString_cfg cfg =
	toString_quadruplets cfg.instrs
;;

let rec toString_cfg_list cfg_q =
	match cfg_q with
	| [] -> ""
	| h :: t -> (toString_cfg h) ^ (toString_cfg_list t)
;;

let print_cfg2 cfg_q=
	let oc = open_out ("/local/raynaudp/TER/CompCert_et_lib/CompCert/LIEN_AFFICHAGE/analyse_cfg2.txt") in
	fprintf oc "%s\n" (""^ toString_cfg_list cfg_q ); 
	close_out oc
;;

(*
(*code pour tester*)

(*on récupère les fonctions internes*)

let fonctions_internes = filtrage (recuperation_fonction_interne test);;

(*a partir des fonctions on créé un triplet cfg*)

let cfg_t = creation_cfgS fonctions_internes ;;

(*du triplet cfg on fait le quadruplet cfg*)

let cfg_q = creation_cfgQ_from_cfgT cfg_t ;;

(*affichage pour le tester*)
print_cfg2 cfg_q;;
*)

(*
let triplet_test  = 
	{ noeud_t = 5 ; instr_t = Ireturn( Some ( Coq_xH )); dir_t =  [3] }in 
	show_triplet triplet_test
;;
*)

(*
{ noeud_t : int; instr_t : RTL.instruction; dir_t :int list}
*)
(*type 'a cfg = {ident : int; param : reg list; entry_point : int ;instrs : 'a list}  *)
(* type 'a cfgt = { i: int ; instr : 'a list};; 
let x = { i = 1 ; instr = [2;3;5]};;



let quadruplet_test  = 
	{ pred_q = [1;2] ; noeud_q = 5 ; instr_q = Ireturn( Some ( Coq_xH )); dir_q =  [3] }
in show_quadruplet quadruplet_test;;
let cfg_q_test = {ident = 5; param = [] ; entry_point = 3 ; instrs =[ quadruplet_test; quadruplet_test; quadruplet_test]} in
printf "%s" (show_cfg show_quadruplet cfg_q_test)
;;
*)
