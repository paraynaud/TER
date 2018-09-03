type token_raw =  
  | Add
  | Sub
  | Mul
  | Pow
  | Div
  | LP
  | RP
  | Num of int
  | Var of string
  | None
;;

type token_unit =  
  | Add
  | Sub
  | Mul
  | Div
  | Num of int
  | Var of string
  | Pow
  | Block of token_unit list
;;

type token_pow =  
  | Add
  | Sub
  | Mul
  | Div
  | Num of int
  | Var of string
  | Pow of token_pow list * int
  | Block of token_pow list
;;

type token_muldiv =  
  | Mul of token_muldiv list
  | Div of token_muldiv * token_muldiv
  | Num of int
  | Var of string
  | Pow of token_muldiv list * int
  | Block of token_muldiv list
  | Add
  | Sub
;;

type token_addsub =  
  | Mul of token_addsub list
  | Div of token_addsub * token_addsub
  | Num of int
  | Var of string
  | Pow of token_addsub list * int
  | Block of token_addsub list
  | Add of token_addsub list
  | Sub of token_addsub * token_addsub
;;


let tokenize (s: char Stream.t) :token_raw Stream.t =
let isNum (c: char): bool = 
	match c with
	| '0'..'9' -> true
	| _ -> false
in
let rec pNum (n: int): int = 
	let oc = Stream.peek s in
	match oc with
	| None -> n
	| Some(c) ->
		match c with
		| '0'..'9' ->
			let _ = Stream.junk s in
			pNum (10*n + (int_of_char c) - 48)
		| _ -> n
in
let rec pVar (st: string): string = 
	let oc = Stream.peek s in
	match oc with
	| None -> st
	| Some(c) ->
		match c with
		'a'..'z' | '_' | '0'..'9' as c->
			let _ = Stream.junk s in
			pVar (st ^ (String.make 1 c))
		| _ -> st
in
let toToken (c: char) (* last: token_raw *): token_raw =
	match c with
	| n when isNum(n) -> Num(pNum ((int_of_char n) - 48))
	(*(match last with Num(l) -> Num((10*l + (int_of_char n) - 48)) |_ -> Num((int_of_char n) - 48)*)
	| '+' -> Add
	| '-' -> Sub
	| '*' when Stream.peek s = Some('*')(*last=Mul*) -> let _ = Stream.junk s in Pow
	| '*' -> Mul
	| '^' -> Pow
	| '/' -> Div
	| '(' -> LP
	| ')' -> RP
	| 'a'..'z' | '_' as c ->
		Var(pVar (String.make 1 c))
	| _   -> None
in
let rec r () (* last: token_raw *): token_raw list =
	let ps = Stream.peek s in
	let _ = Stream.junk s in
	match ps with
	| Some(c) -> (match (toToken c (*last*)) with |None -> r ()(*last*) |cur -> cur::(r ()(*cur*))) 
	| None -> []
in
	Stream.of_list (r ()(*LP*))
;;


let blockify (s: token_raw Stream.t) (* char Stream.t *) :token_unit list =
(* let s = tokenize s in *)
let rec toToken (c: token_raw): token_unit =
	match c with
	| Add -> Add
	| Sub -> Sub
	| Mul -> Mul
	| Div -> Div
	| Var(s) -> Var(s)
	| Num(n) -> Num(n)
	| LP  -> Block(r ())
	| Pow -> Pow
	| _   -> failwith("No none or RP")
and r (): token_unit list =
	let ps = Stream.peek s in
	let _ = Stream.junk s in
	match ps with
	| Some(RP) -> []
	| Some(c)  -> let t = (toToken c) in t::(r ()) 
	| None     -> []
in
	(* Stream.of_list *)(r ())
;;

let powify (l: token_unit list) :token_pow list =
let rec r (l: token_unit list): token_pow list =
	match l with
	| Num(i)::Pow::Num(j)::ll   -> Pow(((Num(i)::[])),j)::(r ll)
	| Var(s)::Pow::Num(j)::ll   -> Pow(((Var(s)::[])),j)::(r ll)
	| Block(b)::Pow::Num(j)::ll -> Pow(((r b)),j)::(r ll)
	| Block(b)::ll              -> Block((r b))::(r ll)
	| Add::ll                   -> Add::(r ll)
	| Sub::ll                   -> Sub::(r ll)
	| Mul::ll                   -> Mul::(r ll)
	| Div::ll                   -> Div::(r ll)
	| Num(i)::ll                -> Num(i)::(r ll)
	| Var(s)::ll                -> Var(s)::(r ll)
	| []                        -> []
	| Pow::_                    -> failwith("error parsing pb gen: powify")
in
	(r l)
;;

let setMulPrio (l: token_pow list) :token_muldiv list =
let rec subl (t: token_pow): token_muldiv =
	match t with
	| Num(i)   -> Num(i)
	| Var(i)   -> Var(i)
	| Block(b) -> Block(r b)
	| Pow(a,b) -> Pow((r a), b)
	| _        -> failwith("setmul: bad format")
and mul (lm: token_muldiv list) (l: token_pow list): token_muldiv list =
	match l with
	| x::Mul::ll                  -> mul ((subl x)::lm) ll

	| x::Div::y::Mul::ll          -> mul (Div((subl x), (subl y))::lm) ll
	| x::Div::y::ll               -> Mul(Div((subl x), (subl y))::lm)::(r ll)

	| x::ll                       -> Mul((subl x)::lm)::(r ll)
	| []                          -> failwith("can't end here")
and r (l: token_pow list): token_muldiv list =
	match l with
	| x::Div::y::Mul::ll          -> mul (Div((subl x), (subl y))::[]) ll

	| x::Div::y::ll               -> Div((subl x), (subl y))::(r ll)
	| x::Mul::ll                  -> mul [] (x::Mul::ll)
	(* | Mul::ll                     -> mul [] ll *)
	| Pow(b,i)::ll                -> Pow((r b), i)::(r ll)
	| Block(b)::ll                -> Block((r b))::(r ll)
	| Add::ll                     -> Add::(r ll)
	| Sub::ll                     -> Sub::(r ll)
	| Num(i)::ll                  -> Num(i)::(r ll)
	| Var(i)::ll                  -> Var(i)::(r ll)
	| []                          -> []
	| Mul::_ | Div::_                -> failwith("error parsing pb gen: setMulPrio")
in
	(r l)
;;

let setAddPrio (l: token_muldiv list) :token_addsub list =
let rec subl (t: token_muldiv): token_addsub =
	match t with
	| Num(i)   -> Num(i)
	| Var(s)   -> Var(s)
	| Block(b) -> Block(r b)
	| Pow(a,b) -> Pow((r a), b)
	| Div(a, b)-> Div((List.hd (r (a::[]))), (List.hd (r (b::[]))))
	| Mul(a)   -> Mul(r a)
	| Add | Sub        -> failwith("satadd: bad format")
and add (lm: token_addsub list) (l: token_muldiv list): token_addsub list =
	match l with
	| x::Add::ll               -> add ((subl x)::lm) ll
	| x::Sub::y::Add::ll       -> add (Sub((subl x), (subl y))::lm) ll
	| x::Sub::y::Sub::ll       -> sub (Add((Sub((subl x), (subl y))::lm))) ll
	| x::Sub::y::ll            -> Add((Sub((subl x), (subl y))::lm))::(r ll)
	| x::ll                    -> Add((subl x)::lm)::(r ll)
	| []                       -> failwith("can't end here")
and sub (g: token_addsub) (l: token_muldiv list): token_addsub list =
	match l with
	| x::Sub::ll               -> sub (Sub(g, (subl x))) ll
	| x::Add::ll               -> add ((Sub(g, (subl x)))::[]) ll
	| x::ll                    -> Sub(g, (subl x))::(r ll)
	| []                       -> failwith("can't end here")
and r (l: token_muldiv list): token_addsub  list =
	match l with
	| x::Sub::y::Add::ll       -> add (Sub((subl x), (subl y))::[]) ll
	| x::Sub::y::Sub::ll       -> sub (Sub((subl x), (subl y))) ll
	| x::Sub::y::ll            -> Sub((subl x), (subl y))::(r ll)
	| x::Add::ll               -> add [] (x::Add::ll)
	| x::[]                    -> (subl x)::[]
	| []                       -> []
	| Sub::x::ll               -> r ((Mul([x; Num(-1)]))::ll) (* Neg *)
	(* pour subl *)
	| x::ll                    -> (subl x)::(r ll)
	(* | _(*::Sub::[]*)           -> failwith("error parsing pb gen: setAddPrio") *)
in
	(r l)
;;

type op =  
  | Mul of op list
  | Div of op * op
  | Num of int
  | Var of string
  | Pow of op * int
  | Block of op
  | Add of op list
  | Sub of op * op
;;
let rec cleaner (s: token_addsub list): op =
let rec r (l: token_addsub): op =
	match l with
	| Num(i)   -> Num(i)
	| Var(s)   -> Var(s)
	| Block(b) -> Block(cleaner b)
	| Pow(a,b) -> Pow((cleaner a), b)
	| Div(a, b)-> Div((r a), (r b))
	| Mul(a)   -> Mul(List.map r a)
	| Add(a)   -> Add(List.map r a)
	| Sub(a, b)-> Sub((r a), (r b))
in
	match s with
	| t::[] -> r t
	| _ -> failwith("bad format")
;;

open Batteries;;

(* -5 (-2*7) not supported *)

let rec print_sage (o: op): string =
	match o with
	| Num(i)   -> string_of_int i
	| Var(s)   -> s
	| Block(b) -> "("^(print_sage b)^")"
	| Pow(a,b) -> (print_sage a) ^ "**" ^ (string_of_int b)
	| Div(a, b)-> (print_sage a) ^ "/" ^ (print_sage b)
	| Mul(a)   -> String.concat "*" (List.map print_sage a)
	| Add(a)   -> String.concat "+" (List.map print_sage a)
	| Sub(a, b)-> (print_sage a) ^ "-" ^ (print_sage b)
;;

let rec print_smt (o: op): string =
	match o with
	| Num(i)   -> string_of_int i
	| Var(s)   -> s
	| Block(b) -> "("^(print_smt b)^")"
	| Pow(a,b) -> "(* " ^ (Array.fold_left (fun a b -> a ^ " " ^ b ) "" (Array.make b (print_smt a))) ^ ")"
	| Div(a, b)-> "(/ " ^ (print_smt a) ^ " " ^ (print_smt b) ^ ")"
	| Mul(a)   -> "(* " ^ String.concat " " (List.map print_smt a) ^ ")"
	| Add(a)   -> "(+ " ^ String.concat " " (List.map print_smt a) ^ ")"
	| Sub(a, b)-> "(- " ^ (print_smt a) ^ " " ^ (print_smt b) ^ ")"
;;

let ri (): int =
	if Random.int 2 = 1 then
		Random.int (int_of_float (2.**10.)) (* 2.**29 *)
	else
		- (Random.int (int_of_float (2.**10.))) (* 2.**29 *)
;;
(* let rval (n: int): int =
	Random.int n
;; *)
let rlist (n: int) (k:int): int list =
let rec r (n:float) (k:float): int list =
	if n >= 1. then
		if Random.float n <= k  then
			(int_of_float n)::(r (n-.1.) (k-.1.))
		else
			r (n-.1.) k
	else
		[]
in 
	r (float_of_int n) (float_of_int k)
;;

let rec genAff (i: int) (nv: int) (sa: int) : op list =
	let rec inner (vl: int list): op list = 
		match vl with
		| x::[] -> Mul(Num(ri ())::Var("x"^(string_of_int x))::[])::[]
		| x::ll -> Mul(Num(ri ())::Var("x"^(string_of_int x))::[])::(inner ll)
		| [] -> failwith "empty"
	in
	if i = 0 then
		[]
	else
	let vl = rlist nv sa in
		Add((Num(ri ()))::(inner vl))::(genAff (i - 1) nv sa)

;;

let genAffdecl (l: op list) : string =
let rec rgenAffdecl (l: op list) (i: int) : string =
	match l with
	| t::ll -> "(define-fun f" ^ (string_of_int i) ^ " () Real " ^ (print_smt t) ^ " )\n" ^ (rgenAffdecl ll (i+1))
	| []    -> ""
in
	rgenAffdecl l 0
;;

let genAfffact (n: int) : string =
let rec r (i: int): string =
	if i < n then
		"f" ^ (string_of_int i) ^ " " ^ (r (i+1))
	else
		""
in
	r 0
;;

let genAfffxor (n: int) : string =
let rec r (i: int): string =
	if i < n-1 then
		"(xor (< f" ^ (string_of_int i) ^ " 0) " ^ (r (i+1)) ^ " )"
	else
		"(< f" ^ (string_of_int i) ^ " 0)"
in
	r 0
;;

let gennonzero (n: int) : string =
let rec r (i: int): string =
	if i < n-1 then
		"(assert (not (= f" ^ (string_of_int i) ^ " 0)))\n" ^ (r (i+1))
	else
		"(assert (not (= f" ^ (string_of_int i) ^ " 0)))"
in
	r 0
;;

let rec genDefv (nv: int) : string =
	if nv=1 then
		"(declare-fun x1 ( ) Real )\n"
	else
		"(declare-fun x"^(string_of_int nv)^" ( ) Real )\n"^(genDefv (nv-1))
;;

let rec list_var (nv: int) : string =
	if nv=0 then
		""
	else
		" x"^(string_of_int nv)^(list_var (nv-1))
;;

let rec genCstrl (cl: op list) =
	match cl with
	| t::ll -> "(assert (> " ^ (print_smt t) ^ " 0))\n" ^ (genCstrl ll)
	| []    -> ""
;;



let norm_to_op (n: op list list): op =
	Add(List.map (fun x -> Mul(x)) n)
;;

let simplify_num (p: op list): op list =
	let rec inner p1 p2 =
		match p1,p2 with
		| (a,b,c),Num(i) -> (i*a,b,c)
		| (a,b,c),Div(Num(i),Num(j)) -> (i*a,j*b,c)
		| (a,b,c),x      -> (a,b,x::c)
	in
	let a,b,c = List.fold_left inner (1,1,[]) p in
		((if b != 1 then Div(Num(a),Num(b)) else Num(a))::c)
;;

let normalise (p: op): op list list =
let rec inner (p: op): op list list =
	match p with
	| Mul(a::[]) -> inner a
	| Mul(a::ll)   ->
		let n = inner a in
		let ln = List.map inner ll in
		List.fold_left (fun p q -> List.concat (List.map (fun a -> List.map ((@) a) q) p)) n ln
	| Add(a)   -> List.concat (List.map inner a)

	| Num(i)   -> [[Num(i)]]
	| Var(v)   -> [[Var(v)]]
	| Div(Num(i), Num(j))-> [[Div(Num(i), Num(j))]](* [[Num(i/j)]] *)
	| Div(_,_)           -> failwith "no_frac: bad div"
	| Block(b) -> inner b
	| Sub(a, b)-> inner (Add(a::(Mul(Num(-1)::b::[]))::[]))
	| Pow(a,b) ->
		(* let a = norm_to_op (normalise a) in *)
		let rec iinner n = if n <= 0 then [] else a::(iinner (n-1)) in
			inner (Mul(iinner b))
in
	List.map simplify_num (inner p)
;;

if Array.length Sys.argv < 3 then
	failwith "Use: pgen nbCyclo nbAff"
else
let basic = if Array.length Sys.argv > 13 then (int_of_string Sys.argv.(13)) else 0 in
let fact = if Array.length Sys.argv > 12 then (int_of_string Sys.argv.(12)) else 0 in
let raw  = if Array.length Sys.argv > 11 then (int_of_string Sys.argv.(11)) else 1 in
let nbpl = if Array.length Sys.argv > 10 then (int_of_string Sys.argv.(10)) else 0 in
let nbcl = if Array.length Sys.argv > 9 then (int_of_string Sys.argv.(9)) else 0 in
let sa = if Array.length Sys.argv > 8 then (int_of_string Sys.argv.(8)) else 1 in
let nv = if Array.length Sys.argv > 7 then (int_of_string Sys.argv.(7)) else 1 in
let extern_sage = if Array.length Sys.argv > 6 then (bool_of_string Sys.argv.(6)) else false in
let output_sufix = if Array.length Sys.argv > 5 then (Sys.argv.(5)) else "" in
let output_prefix = if Array.length Sys.argv > 4 then (Sys.argv.(4)) else "" in
let output_folder = if Array.length Sys.argv > 3 then (Sys.argv.(3)) else "./" in
let na = if Array.length Sys.argv > 2 then int_of_string (Sys.argv.(2)) else 1 in
let nc = if Array.length Sys.argv > 1 then int_of_string (Sys.argv.(1)) else 105 in
let lp = if nc <> 0 then
		let _ =  if not extern_sage then
					Sys.command ("./pgen.sage " ^ (string_of_int nc) ^ " > cyclopol")
				else 0 in
		let chan = open_in "cyclopol" in
		let s    = input_line chan in
		let _    =  close_in chan in
		let lb = powify (blockify (tokenize (Stream.of_string s))) in
		let lm = setMulPrio lb in
		let la = setAddPrio lm in
		let lp = cleaner la in
			lp
	else
		Num(1)
in
let _ = Random.self_init () in
let affs = genAff na nv sa in
let cstrl = genAff nbcl nv sa in

let _ = if(raw = 0) then ()
	else

	let oc = open_out (output_folder ^ output_prefix ^ "cl" ^ (string_of_int nbcl) ^ "c" ^ (string_of_int nc) ^ "a" ^ (string_of_int na) ^ "nv" ^ (string_of_int nv) ^ "d" ^ (string_of_int sa) ^ output_sufix ^ ".smt2") in
	let _ =
	begin
		Printf.fprintf oc "%s" ("(declare-fun x ( ) Real )\n" ^ (genDefv nv) ^
		(genAffdecl affs) ^
		("(define-fun P0 () Real (* " ^ (genAfffact na) ^ " " ^ (print_smt (lp)) ^ " ))\n") ^
		("(assert (> P0 0) )\n") ^
		(genCstrl cstrl) ^
		("(check-sat)"));
		close_out oc;
	end
	in ()
in

let _ = if(fact = 0) then ()
	else

	let oc = open_out (output_folder ^ output_prefix ^ "cl" ^ (string_of_int nbcl) ^ "c" ^ (string_of_int nc) ^ "a" ^ (string_of_int na) ^ "nv" ^ (string_of_int nv) ^ "d" ^ (string_of_int sa) ^ output_sufix ^ "_fact.smt2") in
	let _ =
	begin
		Printf.fprintf oc "%s" ("(declare-fun x ( ) Real )\n" ^ (genDefv nv) ^
		(genAffdecl affs) ^
		(if nc <> 0 then ("(define-fun P0 () Real " ^ (print_smt (lp)) ^ " )\n") else "") ^
		("(assert (not " ^ (if nc <> 0 then "(xor (< P0 0) " else "") ^ (genAfffxor na) ^ (if nc <> 0 then ")" else "") ^ ") )\n") ^
		(gennonzero na) ^ "\n"^
		(genCstrl cstrl) ^
		("(check-sat)"));
		close_out oc;
	end
	in

	let oc = open_out (output_folder ^ output_prefix ^ "cl" ^ (string_of_int nbcl) ^ "c" ^ (string_of_int nc) ^ "a" ^ (string_of_int na) ^ "nv" ^ (string_of_int nv) ^ "d" ^ (string_of_int sa) ^ output_sufix ^ "_fact.smt2_pol") in
	let _ =
	begin
		Printf.fprintf oc "%s" ("x" ^ (list_var nv) ^ "\n" ^
			(print_sage (Mul(List.map (fun x -> Block(x)) (lp::affs)))));
		close_out oc;
	end
	in ()
in

if basic = 0 then ()
else
let oc = open_out (output_folder ^ output_prefix ^ "cl" ^ (string_of_int nbcl) ^ "c" ^ (string_of_int nc) ^ "a" ^ (string_of_int na) ^ "nv" ^ (string_of_int nv) ^ "d" ^ (string_of_int sa) ^ output_sufix ^ "_basic.smt2") in
let _ =
begin
	Printf.fprintf oc "%s" ("(declare-fun x ( ) Real )\n" ^ (genDefv nv) ^
	("(define-fun P0 () Real " ^ (print_smt (norm_to_op (normalise (Mul(lp::affs))))) ^ ")\n") ^
	("(assert (> P0 0) )\n") ^
	(genCstrl cstrl) ^
	("(check-sat)"));
	close_out oc;
end
in
	print_endline (output_folder ^ output_prefix ^ "cl" ^ (string_of_int nbcl) ^ "c" ^ (string_of_int nc) ^ "a" ^ (string_of_int na) ^ "nv" ^ (string_of_int nv) ^ "d" ^ (string_of_int sa) ^ output_sufix);;

