val ireg_of : Machregs.mreg -> Asm.ireg Errors.res
val freg_of : Machregs.mreg -> Asm.freg Errors.res
val mk_mov :
  Asm.preg ->
  Asm.preg -> Asm.instruction list -> Asm.instruction list Errors.res
val mk_shrximm :
  Integers.Int.int -> Asm.instruction list -> Asm.instruction list Errors.res
val mk_shrxlimm :
  Integers.Int.int -> Asm.instruction list -> Asm.instruction list Errors.res
val low_ireg : Asm.ireg -> bool
val mk_intconv :
  ('a -> Asm.ireg -> Asm.instruction) ->
  'a -> Asm.ireg -> Asm.instruction list -> Asm.instruction list Errors.res
val addressing_mentions : Asm.addrmode -> Asm.ireg -> bool
val mk_storebyte :
  Asm.addrmode ->
  Asm.ireg -> Asm.instruction list -> Asm.instruction list Errors.res
val loadind :
  Asm.ireg ->
  BinNums.coq_Z ->
  AST.typ ->
  Machregs.mreg -> Asm.instruction list -> Asm.instruction list Errors.res
val storeind :
  Machregs.mreg ->
  Asm.ireg ->
  BinNums.coq_Z ->
  AST.typ -> Asm.instruction list -> Asm.instruction list Errors.res
val transl_addressing :
  Op.addressing -> Machregs.mreg list -> Asm.addrmode Errors.res
val normalize_addrmode_32 : Asm.addrmode -> Asm.addrmode
val normalize_addrmode_64 :
  Asm.addrmode -> Asm.addrmode * BinNums.coq_Z option
val floatcomp :
  Integers.comparison -> Asm.freg -> Asm.freg -> Asm.instruction
val floatcomp32 :
  Integers.comparison -> Asm.freg -> Asm.freg -> Asm.instruction
val transl_cond :
  Op.condition ->
  Machregs.mreg list ->
  Asm.instruction list -> Asm.instruction list Errors.res
val testcond_for_signed_comparison : Integers.comparison -> Asm.testcond
val testcond_for_unsigned_comparison : Integers.comparison -> Asm.testcond
type extcond =
    Cond_base of Asm.testcond
  | Cond_or of Asm.testcond * Asm.testcond
  | Cond_and of Asm.testcond * Asm.testcond
val testcond_for_condition : Op.condition -> extcond
val mk_setcc_base :
  extcond -> Asm.ireg -> Asm.instruction list -> Asm.instruction list
val mk_setcc :
  extcond -> Asm.ireg -> Asm.instruction list -> Asm.instruction list
val mk_jcc :
  extcond -> Asm.label -> Asm.instruction list -> Asm.instruction list
val transl_op :
  Op.operation ->
  Machregs.mreg list ->
  Machregs.mreg -> Asm.instruction list -> Asm.instruction list Errors.res
val transl_load :
  AST.memory_chunk ->
  Op.addressing ->
  Machregs.mreg list ->
  Machregs.mreg -> Asm.instruction list -> Asm.instruction list Errors.res
val transl_store :
  AST.memory_chunk ->
  Op.addressing ->
  Machregs.mreg list ->
  Machregs.mreg -> Asm.instruction list -> Asm.instruction list Errors.res
val transl_instr :
  Mach.coq_function ->
  Mach.instruction ->
  bool -> Asm.instruction list -> Asm.instruction list Errors.res
val it1_is_parent : bool -> Mach.instruction -> bool
val transl_code_rec :
  Mach.coq_function ->
  Mach.instruction list ->
  bool -> (Asm.instruction list -> 'a Errors.res) -> 'a Errors.res
val transl_code' :
  Mach.coq_function ->
  Mach.instruction list -> bool -> Asm.instruction list Errors.res
val transl_function : Mach.coq_function -> Asm.coq_function Errors.res
val transf_function : Mach.coq_function -> Asm.coq_function Errors.res
val transf_fundef :
  Mach.coq_function AST.fundef -> Asm.coq_function AST.fundef Errors.res
val transf_program :
  (Mach.coq_function AST.fundef, 'a) AST.program ->
  (Asm.coq_function AST.fundef, 'a) AST.program Errors.res
