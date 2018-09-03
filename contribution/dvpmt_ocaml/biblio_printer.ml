(*
#use "biblio_printer.ml" ;;
*)

(** printer_variables et prop**)
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

(** fin printer_variables et prop**)





(** printer expr**)
let comparison_name_to_Z3 = function
  | Ceq -> "="
  | Cne -> "!="
  | Clt -> "<"
  | Cle -> "<="
  | Cgt -> ">"
  | Cge -> ">="
;;

let print_cond_to_Z3 op args id ne =
  match (op, args) with
  | (Ccomp c, [r1;r2]) -> "( " ^  comparison_name_to_Z3 c ^ " " ^ pavar (id,ne,r1) ^ " " ^ pavar (id,ne,r2) ^ " )"
  | (Ccompimm(c, n), [r1]) -> "( " ^  comparison_name_to_Z3 c ^ " " ^ pavar (id,ne,r1) ^ " " ^ string_of_int (Z.to_int n) ^ " )"
  | (Ccomplimm(c, n), [r1]) -> "(  " ^ comparison_name_to_Z3 c ^ " " ^ pavar (id,ne,r1) ^ " " ^ string_of_int (Z.to_int n) ^ " )"
  | (Ccompuimm(c, n), [r1]) -> "(not(  " ^ comparison_name_to_Z3 Ceq ^ " " ^ pavar (id,ne,r1) ^ " " ^ string_of_int (Z.to_int n) ^ ") ) "
  | _ ->   "( +== " ^  printer_var_list args ^ ") )"
;;

let print_op_to_Z3 (op,pd,id,ne)=
  match op,pd with
  | Omove, [r1] -> " " ^ pavar (id,ne,r1) ^ " "
  | Olea addr, args -> (
		    match (addr, args ) with
		    | Aindexed n, [r1] -> " (+ " ^ pavar (id,ne,r1) ^ " " ^ string_of_int (Z.to_int n) ^ " )"
        | Aindexed2 n, [r1; r2] -> " (+ "  ^ "( + " ^ pavar (id,ne,r1)  ^ " " ^ pavar (id,ne,r2)  ^  " ) " ^  string_of_int (Z.to_int n) ^ " )"
        | Ascaled(sc,n), [r1] -> "(+ " ^ "( * " ^ pavar (id,ne,r1) ^ " " ^ (Z.to_string sc) ^ " ) " ^  (Z.to_string n) ^ " )"
(*      fprintf pp "%a * %s + %s" reg r1 (Z.to_string sc) (Z.to_string n)*)
        | _ -> "pas encore fait"
		    )
  | Ointconst n, [] ->  " " ^ string_of_int (Z.to_int n) ^ " "
  | Osub, [r1;r2] ->   "( - " ^ pavar (id,ne,r1) ^ " " ^ pavar (id,ne,r2) ^ " )"
  | Ocmp c, args -> print_cond_to_Z3 c args id ne 
  | _ -> "+= "
;;
(*Op.Osub *)

let print_cond_gen_to_Z3 (cond,pd,id,ne,dir) = 
  match cond with
   | T x -> (print_cond_to_Z3 x pd id ne) ^ "\n"
   | N x -> "(not" ^( print_cond_to_Z3 x pd id ne) ^ " )\n"  
;;

let print_op_gen_to_Z3 (op,pd,pg,id,ne,dir) = 
"( =  " ^ pavar (id,dir,pg)  ^ print_op_to_Z3 (op,pd,id,ne) ^ " )\n"
;;
(** fin printer expr**)
















