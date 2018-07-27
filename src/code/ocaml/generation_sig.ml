(*
#use "types_sig.ml";;
#use "generation_sig.ml";;
#use "test.ml";;
#use "decl_fun_var.ml";;
#use "/local/raynaudp/TER/CompCert_et_lib/CompCert/resultat_rtl_paulo/gene_prop.rtl.3.0";;
#use "/local/raynaudp/TER/CompCert_et_lib/CompCert/resultat_rtl_paulo/aes.rtl.8.0";;
*)
let rec f_a_faire x =
  match x with 
  |0 -> []
  |n -> I :: f_a_faire (n-1)
;;

let rec init nb_var=
  match nb_var with
  | 0 -> []
  | n -> Min :: init (n-1)
;;


let rec affich_sig s = 
  match s with
    | [] -> "" 
    | h:: t -> to_String_type_var h ^ affich_sig t
;;

let get_type_from_op op = 
  match op with
  |Ocmp x  -> B 
  |_ -> I
;;
let get_type_tab chunk = 
  Tab
;;

let rec modif_sig s res new_type =
  match res,s with
  |(0,x) -> x
  |(1,h::t) -> new_type :: t
  |(n,h::t) -> h::modif_sig t (n-1) new_type
  |(n,[]) -> []
;;

let transformation_signature id n p_tmp s cfg=
  if p_tmp = None then s else
  let Some p = p_tmp in 
	let quad_tmp = get_quad id p cfg in 
  if quad_tmp = None then s else
  let Some quad = quad_tmp in 
	let instr = quad.instr_q in 
  match instr with
    | Iop(op, args, res, sa) -> (let ns = modif_sig s (P.to_int res) (get_type_from_op op)in
          ns)  
    | Iload(chunk, addr, args, dst, succ) -> (let ns = modif_sig s (P.to_int dst) (get_type_tab chunk)in
          ns)  
    | Icall(sg, fn, args, res, sa) -> (let ns = modif_sig s (P.to_int res) I in ns)
    | _ -> s 
;;


let rec change_sig sign (indice,type_var) cmpt =
if indice = cmpt 
  then 
    (match sign with 
      | [] ->  []
      | h::t ->     (sup_type type_var h) :: t 
    )
  else
   (match sign with 
     | [] ->  []
     | h::t ->  h :: change_sig t (indice,type_var) (cmpt+1)
   )
;;

let rec remplace_sup s prm_typ_l =
	match prm_typ_l,s with 
	| [],sign -> sign
	| h::t,sign -> 
      let sig_tmp = change_sig sign h 1 in 
      remplace_sup (sig_tmp) t
;;

















(*transformation_signature 57 10 11 [B;B;B;B;B;B;B;B;B;B] !cfg_utile;;*)
