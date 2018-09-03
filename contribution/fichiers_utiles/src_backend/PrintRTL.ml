(* *********************************************************************)
(*                                                                     *)
(*              The Compcert verified compiler                         *)
(*                                                                     *)
(*          Xavier Leroy, INRIA Paris-Rocquencourt                     *)
(*                                                                     *)
(*  Copyright Institut National de Recherche en Informatique et en     *)
(*  Automatique.  All rights reserved.  This file is distributed       *)
(*  under the terms of the INRIA Non-Commercial License Agreement.     *)
(*                                                                     *)
(* *********************************************************************)

(** Pretty-printers for RTL code *)

open Printf
open Camlcoq
open Datatypes
open Maps
open AST
open RTL
open PrintAST



(** tests!!!**)
open BinNums
open Paulo
(** fin tests!!!**)




(* Printing of RTL code *)

let reg pp r =
  fprintf pp "x%d" (P.to_int r)

let rec regs pp = function
  | [] -> ()
  | [r] -> reg pp r
  | r1::rl -> fprintf pp "%a, %a" reg r1 regs rl

let ros pp = function
  | Coq_inl r -> reg pp r
  | Coq_inr s -> fprintf pp "\"%s\"" (extern_atom s)

let print_succ pp s dfl =
  let s = P.to_int s in
  if s <> dfl then fprintf pp "\tgoto %d\n" s

let print_instruction pp (pc, i) =
  fprintf pp "%5d:\t" pc;
  match i with
  | Inop s ->
      let s = P.to_int s in
      if s = pc - 1
      then fprintf pp "nop\n"
      else fprintf pp "goto %d\n" s
  | Iop(op, args, res, s) ->
      fprintf pp "%a = %a\n"
         reg res (PrintOp.print_operation reg) (op, args);
      print_succ pp s (pc - 1)
  | Iload(chunk, addr, args, dst, s) ->
      fprintf pp "%a = %s[%a]\n"
         reg dst (name_of_chunk chunk)
         (PrintOp.print_addressing reg) (addr, args);
      print_succ pp s (pc - 1)
  | Istore(chunk, addr, args, src, s) ->
      fprintf pp "%s[%a] = %a\n"
         (name_of_chunk chunk)
         (PrintOp.print_addressing reg) (addr, args)
         reg src;
      print_succ pp s (pc - 1)
  | Icall(sg, fn, args, res, s) ->
      fprintf pp "%a = %a(%a)\n"
        reg res ros fn regs args;
      print_succ pp s (pc - 1)
  | Itailcall(sg, fn, args) ->
      fprintf pp "tailcall %a(%a)\n"
        ros fn regs args
  | Ibuiltin(ef, args, res, s) ->
      fprintf pp "%a = %s(%a)\n"
        (print_builtin_res reg) res
        (name_of_external ef)
        (print_builtin_args reg) args;
      print_succ pp s (pc - 1)
  | Icond(cond, args, s1, s2) ->
      fprintf pp "if (%a) goto %d else goto %d\n"
        (PrintOp.print_condition reg) (cond, args)
        (P.to_int s1) (P.to_int s2)
  | Ijumptable(arg, tbl) ->
      let tbl = Array.of_list tbl in
      fprintf pp "jumptable (%a)\n" reg arg;
      for i = 0 to Array.length tbl - 1 do
        fprintf pp "\t\tcase %d: goto %d\n" i (P.to_int tbl.(i))
      done
  | Ireturn None ->
      fprintf pp "return\n"
  | Ireturn (Some arg) ->
      fprintf pp "return %a\n" reg arg

let print_function pp id f =
  fprintf pp "%s(%a) {\n" (extern_atom id) regs f.fn_params;
  let instrs =
    List.sort
      (fun (pc1, _) (pc2, _) -> Pervasives.compare pc2 pc1)
      (List.rev_map
        (fun (pc, i) -> (P.to_int pc, i))
        (PTree.elements f.fn_code)) in
  print_succ pp f.fn_entrypoint
    (match instrs with (pc1, _) :: _ -> pc1 | [] -> -1);
  List.iter (print_instruction pp) instrs;
  fprintf pp "}\n\n"

let print_globdef pp (id, gd) =
  match gd with
  | Gfun(Internal f) -> print_function pp id f
  | _ -> ()

let print_program pp (prog: RTL.program) =
  List.iter (print_globdef pp) prog.prog_defs



let print_instruction2 pp (pc, i) =
	let t = B(B( (L 1),(L 5)), B( (L 2), B( (L 3), (T(A 3)) ) )  ) in
	let x = Coq_xI( Coq_xO (Coq_xH) ) in
	let z = S(S(S(O))) in 
	let w = S(S(S(S(S(O))))) in
  	fprintf pp "%5d:\t" pc ;
	fprintf pp "\n test paulo.ml [%s]\n" (show_tree t);
	fprintf pp "\n test BinNums.ml [%s]\n" (show_positive x);
	fprintf pp "\n test z [%s]\n" (show_nat  z);
	fprintf pp "\n test w [%s]\n" (show_nat  w)

(*	fprintf pp "\n test tree (Maps.ml [%s]\n" (Maps.PTree.show_tree  i) *)
(*	fprintf pp show_RTL i *)


let print_function2 pp id f =

  fprintf pp "%s(%a)  ertert{\n" (extern_atom id) regs f.fn_params;
  let instrs =
    List.sort
      (fun (pc1, _) (pc2, _) -> Pervasives.compare pc2 pc1)
      (List.rev_map
        (fun (pc, i) -> (P.to_int pc, i))
        (PTree.elements f.fn_code)) in
  print_succ pp f.fn_entrypoint
    (match instrs with (pc1, _) :: _ -> pc1 | [] -> -1);
  List.iter (print_instruction2 pp) instrs;
  fprintf pp "}\n\n"

let print_globdef2 pp (id, gd) =
  match gd with
  | Gfun(Internal f) -> print_function2 pp id f
  | _ -> ()

let print_program2 pp (prog: RTL.program) =
	fprintf pp "paulo taf";
  List.iter (print_globdef2 pp) prog.prog_defs


let destination : string option ref = ref None




let print_if passno prog =
  match !destination with
  | None -> ()
  | Some f ->
      let oc = open_out (f ^ "." ^ Z.to_string passno) in
	    print_program2 oc prog;
      print_program oc prog;
      close_out oc

