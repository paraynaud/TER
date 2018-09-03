(*
ledit ocaml -I /local/raynaudp/TER/CompCert_et_lib/CompCert/fichier_mld/test_ledit/  -I /local/raynaudp/TER/CompCert_et_lib/CompCert/fichier_mld/src_backend/  -open Camlcoq 
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
#use "extract_propriete.ml";;
#use "printer_propriete.ml";;
#use "types_sig.ml";;
#use "generation_sig.ml";;
#use "test.ml";;
#use "main.ml";;

*)
(* premier soucis nous n'avons pas encreo réglé le cas du return*)




type debut = int
type fin = int
type indice = int
type predecesseur = int option

type couple_sig_pred = {  prede : predecesseur ; sign :  type_var list}
type couple_ne_sig = { debut_sp: int ; fin_sp : int; noeud :  int ;c_s_p : couple_sig_pred list } ;;
type table_id_ne = { indice : int; debut_ss : int ; fin_ss : int; ss_table : couple_ne_sig list };;
type table_global = {debut : int ; fin : int ; table  :  table_id_ne list };;



let table_def = ref {debut = 0 ; fin = -1; table =  [] };;
let cfg_utile = ref [];;





(**recherche dichotomique**)
let rec appartient_c_s_p csp d f (id,ne,p) = 
    if d = (f+1) then (false,-1)
    else 
    let middle = (d+f)/2 in
    let tmp =  List.nth csp middle in
    if tmp.prede = p 
        then 
          if p = None then (false,middle)
            else (true,middle)
      else 
        if tmp.prede > p 
          then appartient_c_s_p csp (middle+1) f (id,ne,p)
        else 
          appartient_c_s_p csp d (middle-1) (id,ne,p)
;;

let rec recher_noeud (id,ne,p) middle d f =
  if d = (f+1) then 
    (
    (false,middle,-1,-1)
    )
  else  
  let middle_ss = (d+f)/2 in
  let value =  (List.nth (List.nth !table_def.table middle).ss_table middle_ss) in 
  if value.noeud = ne  
    then (
      let (b,indice) = appartient_c_s_p value.c_s_p value.debut_sp value.fin_sp (id,ne,p) in
	    if b
        then (
          (true,middle, middle_ss,indice)
        )
        else 
				(
          (false,middle, middle_ss,indice)
          )
    )
    else 
      (
			(*printf "%s" ("\non ne l'a pas trouvé d,f vaut "^ string_of_int d ^" , "^ string_of_int f ^ " et value_middle vaut " ^ string_of_int value_middle  ^" tandis que id,ne vaut "^ string_of_int id ^ "," ^ string_of_int ne ^ "\n");*)
      if ne > value.noeud
             then recher_noeud (id,ne,p) middle (middle_ss+1) f
             else recher_noeud (id,ne,p) middle d (middle_ss-1)
      )
;;


let rec recher_id (id,ne,p) d f = 
  if d = (f+1) then (false,-1,-1,-1)
  else
  let middle = (d+f)/2 in 
  let value_middle =  (List.nth !table_def.table middle).indice in 
  if id = value_middle 
    then
      let d = (List.nth !table_def.table middle).debut_ss in 
      let f = (List.nth !table_def.table middle).fin_ss in 
			(*
      printf "%s" ("(id,ne) vaut " ^ string_of_int id ^"," ^ string_of_int ne ^ " tandis que value_middle vaut "^ string_of_int value_middle ^ " et middle vaut "^  string_of_int middle ^ " ");
			*)
      recher_noeud (id,ne,p) middle d f 
    else
      if id > value_middle 
       then
         recher_id (id,ne,p) (middle+1) f
       else
         recher_id (id,ne,p) d (middle-1) 
;;

let rec dico_search (id,ne,p) =
  match (!table_def.debut, !table_def.fin, !table_def.table)   with 
  | (0,0,[]) -> (false,-1,-1,-1)
  | (d,f,tb) -> recher_id (id,ne,p) d f 
;;
(** fin recherche dico**)

(*true on rajoute un element false on ne l'ajoute pas*)
let rec placer_p_sig (p,s) h =
  match h with
  | [] -> (true , {prede = p; sign = s} :: [])
  | {prede= p1 ; sign = s1 }:: t -> 
    if p1 = p
      then 
        if  p1 = None       
          then       (
            (false ,{prede= p ;sign = s } :: t)            
           )
          else 
            (false ,{prede= p1 ;sign = s1 } :: t)            
      else 
        if p1 < p 
          then let (b,res) =  placer_p_sig (p,s) t in 
            (b || false , {prede= p1 ; sign = s1 }   :: res) 
          else (true , {prede= p ; sign = s } :: {prede= p1 ; sign = s1 } ::t)
;;





(*  #use "test.ml";;    *)
(*    List.nth !table_def.table 1;;  *)
let rec add_ss_table (id,ne,s,p) t = 
  match t with
  | [] ->  (true,{debut_sp = 0; fin_sp = 0; noeud = ne ; c_s_p = [{prede = p; sign = s }]}::[])
  | h :: tail -> 
    if h.noeud = ne 
      then
        let (b,res ) = (placer_p_sig (p,s) h.c_s_p) in 
        if b then 
          (false,{debut_sp = h.debut_sp ; fin_sp = h.fin_sp+1 ;noeud = h.noeud ; c_s_p = res  } :: tail)
          else
          (false,{debut_sp = h.debut_sp ; fin_sp = h.fin_sp ; noeud = h.noeud ; c_s_p = res } :: tail)
      else
        if h.noeud > ne 
          then  (true,{debut_sp = 0 ; fin_sp = 0 ; noeud = ne ; c_s_p = [{prede = p; sign = s}]}::h::tail)
          else let (b_temp,l_temp) = add_ss_table (id,ne,s,p) tail in 
             (false || b_temp , h :: l_temp)
;;


let rec placer_ss_table (id,ne,s,p) t i= 
  let (b,l) =   add_ss_table (id,ne,s,p) t.ss_table in
  match b with
  |true -> {indice = t.indice; debut_ss = 0 ; fin_ss = t.fin_ss+1  ; ss_table = l}
  |false ->  {indice = t.indice; debut_ss = 0 ; fin_ss = t.fin_ss  ; ss_table = l}
;;


let def_ss_table (id,ne,s,p) = {indice = id; debut_ss = 0 ; fin_ss = 0  ; ss_table = [{debut_sp = 0 ; fin_sp = 0 ; noeud = ne ; c_s_p = [{prede = p; sign = s}]}] }
;;


let	rec placer_list (id,ne,s,p) t = 
  match t with
  | [] -> [{indice = id; debut_ss = 0 ; fin_ss = 0  ; ss_table = [{debut_sp = 0 ; fin_sp = 0 ; noeud = ne ; c_s_p = [{prede = p; sign = s}]}] }]
  | h :: x -> if h.indice = id 
    then ( placer_ss_table (id,ne,s,p) h 1) :: x
    else  
      if h.indice > id  then (def_ss_table (id,ne,s,p) )  :: h :: x
      else  h :: (placer_list (id,ne,s,p) x )
;;


(** les couples passés en paramètres doivent etre  N*N **)
let placer (id,ne,s,p) =
  let (b,m,ms,vn) = dico_search (id,ne,p) in (* table_def une list globale*)
  match b with
  | true -> (*il existe déja donc nous ne le placons pas*) printf "%s" ("l'élement était déjà présent\n");
  | false -> (* il n'existe pas nous les placons*)
    table_def := 
    ( let ss_temp = (placer_list (id,ne,s,p) !table_def.table ) in
      match m with
      | -1 -> 
let table_temp = {debut = 0 ; fin = !table_def.fin + 1 ; table = ss_temp  } in table_temp (* il n'y pas pas encore de decl de fun pour cet fonction (id) dedans*)
      | -5 -> (*printf " petite erreur\n" ; *)
							let table_temp =  {debut = 0 ; fin = !table_def.fin; table = ss_temp} in table_temp 
      | _ -> let table_temp =  {debut = 0 ; fin = !table_def.fin; table = ss_temp } in table_temp 
    )
;;


(**fonction_utile utilisant la dichotmie**)


(* créé une signature pour none de manière indépendante dans un premier temps et ensuite créer celle du prédecesseur, dans l'état actuel des choses il est possible de faire plusieurs fois None, a n'utiliser que pour la crétion des signatures "locales" et pas lors d'homogénéisation sinon on ecrasera le None*)

let placer_sig_ind (id,n,p) nb_var = 
  let s_init = init nb_var in    
  placer(id, n, s_init , None );  
  let new_sign = transformation_signature id n p s_init !cfg_utile in 
  placer(id, n, new_sign , p )
;;

(** fin des fonctions utiles**)

let rec creation_def_fun quad cfg pred nb_var=
  let id = cfg.ident in 
  let ne = quad.noeud_q in 
  let (b,i1,i2,i3 ) = dico_search (id,ne,pred) in
	if ( b  )
		then printf "%s" ("existe déja\n")
		else(
      (*printf "%s" (" (id,ne,pred) valent " ^ string_of_int id ^ "," ^ string_of_int ne
      ^ "," ^ (match pred with |Some x -> (string_of_int x) | None -> "None" ) ^ ")\n");*)
      placer_sig_ind (id,ne,pred) nb_var;
			let dir = quad.dir_q in
			creation_suivant dir cfg (Some ne) nb_var;

			)
and  
  creation_suivant dir cfg pred nb_var=
  let et = cfg.entry_point in 
  match dir with
  | [] -> ()
  | h::t -> creation_def_fun (List.nth cfg.instrs (et-h)) cfg pred nb_var;
            creation_suivant t cfg pred nb_var
;;  


let print_cfg_to_def_fun cfg = 
  let id = cfg.ident in 
  let et = cfg.entry_point in 
  let nb_var = get_nb_var cfg.instrs in 
  placer(id, et, init nb_var, None );
	if ( List.length (List.nth cfg.instrs 0).dir_q = 1)
	then (
	  let dir = List.nth (List.nth cfg.instrs 0).dir_q 0 in 
  	let quad = List.nth cfg.instrs (et-dir) in
  	creation_def_fun quad cfg (Some et) nb_var;
	)
	else(
	  let dir1 = List.nth (List.nth cfg.instrs 0).dir_q 0 in 
	  let dir2 = List.nth (List.nth cfg.instrs 0).dir_q 1 in 
  	let quad1 = List.nth cfg.instrs (et-dir1) in
  	let quad2 = List.nth cfg.instrs (et-dir2) in
  	creation_def_fun quad1 cfg (Some et) nb_var;
  	creation_def_fun quad2 cfg (Some et) nb_var;
	)
(* c'était l'original avant le if
	  let dir = List.nth (List.nth cfg.instrs 0).dir_q 0 in 
  	let quad = List.nth cfg.instrs (et-dir) in
  	creation_def_fun quad cfg (Some et) nb_var;*)
;;


let rec print_cfg_l_to_def_fun_l cfg_l = 
  match cfg_l with
  | [] -> ()
  | h::t -> print_cfg_to_def_fun h ;
             print_cfg_l_to_def_fun_l t
;;


(**debut homogeneisation locale**)
let rec creation_homogene_local l csp_l =
  match csp_l with
  | [] -> l
  | h::t -> creation_homogene_local (map_spec_plus_first h.sign l) t
;;

let rec homogene_noeud cns_l i =
  match cns_l with
  | [] -> ()
  | h::t -> 
    let n_s = (creation_homogene_local ((List.nth h.c_s_p 0).sign) h.c_s_p) in       
    placer( i, h.noeud, n_s, None);
    homogene_noeud t i 
;;

let homogeneisation_local_table_id_ne { indice = i ; debut_ss = d ; fin_ss = f ; ss_table = cns_l }  = 
homogene_noeud cns_l i
;;


let rec homogeneisation_local_table l=
  match l with
  | [] -> ()
  | h::t -> (homogeneisation_local_table_id_ne h);
            (homogeneisation_local_table t) 
;;

let homogeneisation_local t_ref=
  let t = !t_ref.table in 
  homogeneisation_local_table t
;;
(**debut homogeneisation locale**)


(**debut homogeneisation globale**)
(*la nous devons homogeneiser les signature dont le predecesseur est None, cela viens après l'homogeneisation locale, sinon le resultat n'a pas de sens *)
let get_none_from_c_n_s { debut_sp = d ; fin_sp = f; noeud = n ;c_s_p = c_s_p_l } =
  if f >=0
    then (List.nth c_s_p_l 0).sign 
    else [Min]
;;
  
let rec homogeneisation_global_cns c_ne_sig_l l = 
  match c_ne_sig_l with
  | [] -> l
  | h::t -> homogeneisation_global_cns t (map_spec_plus_first (get_none_from_c_n_s h) l) 
;;

let rec placer_t_id_ne n_s l i =
  match l with
  |[] -> ()
  |h::t -> placer(i, h.noeud, n_s, None);
  placer_t_id_ne n_s t i ;
;;

let homogeneisation_global_table_id_ne  { indice = i ; debut_ss = d ; fin_ss = f ; ss_table = c_ne_sig_l } = 
  if f >= 0 then 
    let n_s = homogeneisation_global_cns c_ne_sig_l  (get_none_from_c_n_s (List.nth c_ne_sig_l 0)) in 
     placer_t_id_ne n_s c_ne_sig_l i;
  else printf "il y a un problème ici, une declaration de fonction sans noeud dedans"
;;

let rec homogeneisation_global_table t = 
  match t with
  | [] -> ()
  | h::tail -> (homogeneisation_global_table_id_ne h);
            (homogeneisation_global_table tail) 
;;

let homogeneisation_global t_ref=
  let t = !t_ref.table in
  homogeneisation_global_table t
;;

(**fin homogeneisation globale**)
(*
type couple_sig_pred = {  prede : predecesseur ; sign :  type_var list}
type couple_ne_sig = { debut_sp: int ; fin_sp : int; noeud :  int ;c_s_p : couple_sig_pred list } ;;
type table_id_ne = { indice : int; debut_ss : int ; fin_ss : int; ss_table : couple_ne_sig list };;
type table_global = {debut : int ; fin : int ; table  :  table_id_ne list };;
*)

(*
#use "types_sig.ml";;
#use "generation_sig.ml";;
#use "decl_fun_var.ml";;
#use "main.ml";;
List.nth !table_def.table 1;;  
*)


let add_type_param c_p_t_l =
  match c_p_t_l with
  | [] -> ()
  | (id, et, prm_typ_l)::t -> 
    let (b,m,ms,vn) = dico_search (id,et, None) in
    let s =  (List.nth (List.nth (List.nth !table_def.table m).ss_table ms).c_s_p vn).sign in 
    placer(id,et, (remplace_sup s prm_typ_l), None)
;;  

let main_test2 c= 
  printf "%s" ("\n\n\ncréation des signatures \n\n\n\n");
  table_def :=  {debut = 0 ; fin = -1; table =  [] };
  cfg_utile := c ; 
  print_cfg_l_to_def_fun_l c ;
	printf "%s" (" \n step3\n");
	table_def;
(** debut homogeneisation**)
  homogeneisation_local table_def;
  let couple_param_typ_list = get_couple_reg_param_list !cfg_utile in 
  add_type_param couple_param_typ_list;
  homogeneisation_global table_def;  
  table_def;;


let rec get_sign_global sig_l id et=
	let table = sig_l in
	recherche_sig_glob table id et
and recherche_sig_glob t id et =
	match t with 
	| [] -> []
	| h::tail -> if h.indice = id then recherche_sig_glob_in_tidne et h.ss_table
		else recherche_sig_glob tail id et
and recherche_sig_glob_in_tidne et cnesig_l =
	match cnesig_l with 
	|[] -> []
	| h::t -> if h.noeud = et then (List.nth h.c_s_p 0).sign
		else recherche_sig_glob_in_tidne et t
;;


(*
type couple_sig_pred = {  prede : predecesseur ; sign :  type_var list}
type couple_ne_sig = { debut_sp: int ; fin_sp : int; noeud :  int ;c_s_p : couple_sig_pred list } ;;
type table_id_ne = { indice : int; debut_ss : int ; fin_ss : int; ss_table : couple_ne_sig list };;
type table_global = {debut : int ; fin : int ; table  :  table_id_ne list };;
*)





(*
let main_test3 i= 
   List.nth !table_def.table i
;;


let _ = 
  table_def :=  {debut = 0 ; fin = -1; table =  [] };
    placer(0,3,[I;B],Some 0 );
    placer(0,3,[Min;Min],None);
    placer(0,3,[Min;Min],None);
    placer(0,3,[I;I],Some 4);
    printf "\n\nmamen\n\n";
    homogeneisation_local table_def;
    printf "\n\ncc\n\n";
    table_def;;
*)
(*
let _ = 
let l = [Min;Min;Min;Min] in 
let liste_csp =  { prede = None ; sign = [I;Min;Min;Min]} ::  { prede = None ; sign = [Min;I;Min;Min]} ::  { prede = None ; sign = [Min;Min;I;Min]} ::  { prede = None ; sign = [Min;Min;Min;B]} :: []in 
creation_homogene_local l liste_csp 
;;
*)
(*
let main_test = 
  placer(0,3,[I;I],Some 1);table_def;; placer(0,3,[I;B],Some 2);table_def;;placer (6,3 , [I],Some 1);table_def;; placer (6,3 , [B],Some 2);placer (6,3 , [B],Some 1);placer (3,2 , [I],Some 1) ;placer(5,8, [B],Some 1);placer (6,2,[I],Some 2);placer (6,3 , [B],Some 3);placer(5,9, [B],Some 1);placer(4,9, [B],Some 1);placer(2,3 , [I],Some 1);placer(3,9, [B],Some 1);placer(2,9, [B],Some 1);placer(1,9, [B],Some 2);placer(8,9, [B],Some 4);placer(2,7, [B],Some 2);placer(0,3,[I],Some 1);table_def;;
*)

(* petit bricolage temporaire dans la condition (m >= 0 && ms >= 0 && vn >= 0 ) cela veut dire qu'il y a déja une signature mais c'est None que l'on va modifier par la suite*)


(*
let get_sig_l (id,n,p)= 
  let (b,m,ms,vn) =
		(match p with  
		| Some pred -> dico_search (id,pred,None) 
		| None -> (false,-1,-1,-1)
	) in(
  printf "%s" ("le precedent est "  ^ (match p with | None -> "inexistant (none)" | Some x -> string_of_int x )  ^ " , la noeud est"^ string_of_int n ^ "  (m,ms,vn) valent " ^ string_of_int m ^ ","^ string_of_int ms ^ "," ^ string_of_int vn ^" let le booleen vaut : " ^ string_of_bool b ^ " \n") ;
	if b || (m >= 0 && ms >= 0 && vn >= 0 ) then
		let {prede = pred2; sign = s } = List.nth (List.nth (List.nth !table_def.table m).ss_table ms ).c_s_p vn in (
      (match pred2 with 
      | Some x -> printf "%s" ("le precedent est "  ^ string_of_int x ^ " et la signature est : " ^ affich_sig s  ^ "\n");
                let new_sign = transformation_signature id n p s !cfg_utile in 
                printf "%s" (" la nouvelle signature %s\n" ^ affich_sig new_sign);
                placer(id, n, new_sign , p);  
      | None -> printf "%s" ("le precedent est nul et la signature est : "^ affich_sig s  ^ "\n");
                let new_sign = transformation_signature id n p s !cfg_utile in 
                printf "%s" (" la nouvelle signature %s\n" ^ affich_sig new_sign);
                placer(id, n, new_sign , p );  
                placer(id, n, s , None );  

      );
			Some s
    )
	else None
)
 ;;

let sig_noeud (id,n,p )=
 let res = get_sig_l (id ,n ,p ) in
  match res with
  | Some x -> (
    printf "%s" ( "la signature est : " ^ affich_sig x ^ "\n");
    x 
    )
  | None ->  (
            printf "%s" ( "la signature est :  nulle\n");
            [I]
            )

*)

   
