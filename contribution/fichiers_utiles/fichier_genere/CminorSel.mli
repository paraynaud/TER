type expr =
    Evar of AST.ident
  | Eop of Op.operation * exprlist
  | Eload of AST.memory_chunk * Op.addressing * exprlist
  | Econdition of condexpr * expr * expr
  | Elet of expr * expr
  | Eletvar of Datatypes.nat
  | Ebuiltin of AST.external_function * exprlist
  | Eexternal of AST.ident * AST.signature * exprlist
and exprlist = Enil | Econs of expr * exprlist
and condexpr =
    CEcond of Op.condition * exprlist
  | CEcondition of condexpr * condexpr * condexpr
  | CElet of expr * condexpr
type exitexpr =
    XEexit of Datatypes.nat
  | XEjumptable of expr * Datatypes.nat list
  | XEcondition of condexpr * exitexpr * exitexpr
  | XElet of expr * exitexpr
type stmt =
    Sskip
  | Sassign of AST.ident * expr
  | Sstore of AST.memory_chunk * Op.addressing * exprlist * expr
  | Scall of AST.ident option * AST.signature *
      (expr, AST.ident) Datatypes.sum * exprlist
  | Stailcall of AST.signature * (expr, AST.ident) Datatypes.sum * exprlist
  | Sbuiltin of AST.ident AST.builtin_res * AST.external_function *
      expr AST.builtin_arg list
  | Sseq of stmt * stmt
  | Sifthenelse of condexpr * stmt * stmt
  | Sloop of stmt
  | Sblock of stmt
  | Sexit of Datatypes.nat
  | Sswitch of exitexpr
  | Sreturn of expr option
  | Slabel of Cminor.label * stmt
  | Sgoto of Cminor.label
type coq_function = {
  fn_sig : AST.signature;
  fn_params : AST.ident list;
  fn_vars : AST.ident list;
  fn_stackspace : BinNums.coq_Z;
  fn_body : stmt;
}
val fn_sig : coq_function -> AST.signature
val fn_params : coq_function -> AST.ident list
val fn_vars : coq_function -> AST.ident list
val fn_stackspace : coq_function -> BinNums.coq_Z
val fn_body : coq_function -> stmt
type fundef = coq_function AST.fundef
type program = (fundef, unit) AST.program
val lift_expr : Datatypes.nat -> expr -> expr
val lift_exprlist : Datatypes.nat -> exprlist -> exprlist
val lift_condexpr : Datatypes.nat -> condexpr -> condexpr
val lift : expr -> expr
