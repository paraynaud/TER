type label = BinNums.positive
type instruction =
    Mgetstack of Integers.Ptrofs.int * AST.typ * Machregs.mreg
  | Msetstack of Machregs.mreg * Integers.Ptrofs.int * AST.typ
  | Mgetparam of Integers.Ptrofs.int * AST.typ * Machregs.mreg
  | Mop of Op.operation * Machregs.mreg list * Machregs.mreg
  | Mload of AST.memory_chunk * Op.addressing * Machregs.mreg list *
      Machregs.mreg
  | Mstore of AST.memory_chunk * Op.addressing * Machregs.mreg list *
      Machregs.mreg
  | Mcall of AST.signature * (Machregs.mreg, AST.ident) Datatypes.sum
  | Mtailcall of AST.signature * (Machregs.mreg, AST.ident) Datatypes.sum
  | Mbuiltin of AST.external_function * Machregs.mreg AST.builtin_arg list *
      Machregs.mreg AST.builtin_res
  | Mlabel of label
  | Mgoto of label
  | Mcond of Op.condition * Machregs.mreg list * label
  | Mjumptable of Machregs.mreg * label list
  | Mreturn
type code = instruction list
type coq_function = {
  fn_sig : AST.signature;
  fn_code : code;
  fn_stacksize : BinNums.coq_Z;
  fn_link_ofs : Integers.Ptrofs.int;
  fn_retaddr_ofs : Integers.Ptrofs.int;
}
val fn_sig : coq_function -> AST.signature
val fn_code : coq_function -> code
val fn_stacksize : coq_function -> BinNums.coq_Z
val fn_link_ofs : coq_function -> Integers.Ptrofs.int
val fn_retaddr_ofs : coq_function -> Integers.Ptrofs.int
type fundef = coq_function AST.fundef
type program = (fundef, unit) AST.program
