type node = BinNums.positive
type instruction =
    Inop of node
  | Iop of Op.operation * Registers.reg list * Registers.reg * node
  | Iload of AST.memory_chunk * Op.addressing * Registers.reg list *
      Registers.reg * node
  | Istore of AST.memory_chunk * Op.addressing * Registers.reg list *
      Registers.reg * node
  | Icall of AST.signature * (Registers.reg, AST.ident) Datatypes.sum *
      Registers.reg list * Registers.reg * node
  | Itailcall of AST.signature * (Registers.reg, AST.ident) Datatypes.sum *
      Registers.reg list
  | Ibuiltin of AST.external_function * Registers.reg AST.builtin_arg list *
      Registers.reg AST.builtin_res * node
  | Icond of Op.condition * Registers.reg list * node * node
  | Ijumptable of Registers.reg * node list
  | Ireturn of Registers.reg option
type code = instruction Maps.PTree.t
type coq_function = {
  fn_sig : AST.signature;
  fn_params : Registers.reg list;
  fn_stacksize : BinNums.coq_Z;
  fn_code : code;
  fn_entrypoint : node;
}
val fn_sig : coq_function -> AST.signature
val fn_params : coq_function -> Registers.reg list
val fn_stacksize : coq_function -> BinNums.coq_Z
val fn_code : coq_function -> code
val fn_entrypoint : coq_function -> node
type fundef = coq_function AST.fundef
type program = (fundef, unit) AST.program
val transf_function :
  (BinNums.positive -> instruction -> instruction) ->
  coq_function -> coq_function
val successors_instr : instruction -> node list
val successors_map : coq_function -> node list Maps.PTree.tree
val instr_uses : instruction -> Registers.reg list
val instr_defs : instruction -> Registers.reg option
val max_pc_function : coq_function -> BinNums.positive
val max_reg_instr : BinNums.positive -> 'a -> instruction -> BinNums.positive
val max_reg_function : coq_function -> BinNums.positive
