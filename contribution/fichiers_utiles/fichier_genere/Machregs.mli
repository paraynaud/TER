type mreg =
    AX
  | BX
  | CX
  | DX
  | SI
  | DI
  | BP
  | R8
  | R9
  | R10
  | R11
  | R12
  | R13
  | R14
  | R15
  | X0
  | X1
  | X2
  | X3
  | X4
  | X5
  | X6
  | X7
  | X8
  | X9
  | X10
  | X11
  | X12
  | X13
  | X14
  | X15
  | FP0
val mreg_eq : mreg -> mreg -> bool
val all_mregs : mreg list
val mreg_type : mreg -> AST.typ
module IndexedMreg :
  sig
    type t = mreg
    val eq : mreg -> mreg -> bool
    val index : mreg -> BinNums.positive
  end
val is_stack_reg : mreg -> bool
val register_names : (char list * mreg) list
val register_by_name : char list -> mreg option
val destroyed_by_op : Op.operation -> mreg list
val destroyed_by_load : 'a -> 'b -> 'c list
val destroyed_by_store : AST.memory_chunk -> 'a -> mreg list
val destroyed_by_cond : 'a -> 'b list
val destroyed_by_jumptable : mreg list
val destroyed_by_clobber : char list list -> mreg list
val destroyed_by_builtin : AST.external_function -> mreg list
val destroyed_at_function_entry : mreg list
val destroyed_by_setstack : AST.typ -> mreg list
val destroyed_at_indirect_call : mreg list
val temp_for_parent_frame : mreg
val mregs_for_operation : Op.operation -> mreg option list * mreg option
val mregs_for_builtin :
  AST.external_function -> mreg option list * mreg option list
val two_address_op : Op.operation -> bool
val builtin_constraints :
  AST.external_function -> AST.builtin_arg_constraint list
