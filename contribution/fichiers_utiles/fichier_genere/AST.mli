val __ : Obj.t
type ident = BinNums.positive
val pp_ident : Format.formatter -> ident -> Ppx_deriving_runtime.unit
val show_ident : ident -> Ppx_deriving_runtime.string
val ident_eq : BinNums.positive -> BinNums.positive -> bool
type typ = Tint | Tfloat | Tlong | Tsingle | Tany32 | Tany64
val pp_typ : Format.formatter -> typ -> Ppx_deriving_runtime.unit
val show_typ : typ -> Ppx_deriving_runtime.string
val typ_eq : typ -> typ -> bool
val opt_typ_eq : typ option -> typ option -> bool
val list_typ_eq : typ list -> typ list -> bool
val coq_Tptr : typ
val typesize : typ -> BinNums.coq_Z
val subtype : typ -> typ -> bool
type calling_convention = {
  cc_vararg : bool;
  cc_unproto : bool;
  cc_structret : bool;
}
val pp_calling_convention :
  Format.formatter -> calling_convention -> Ppx_deriving_runtime.unit
val show_calling_convention :
  calling_convention -> Ppx_deriving_runtime.string
val cc_vararg : calling_convention -> bool
val cc_unproto : calling_convention -> bool
val cc_structret : calling_convention -> bool
val cc_default : calling_convention
val calling_convention_eq : calling_convention -> calling_convention -> bool
type signature = {
  sig_args : typ list;
  sig_res : typ option;
  sig_cc : calling_convention;
}
val pp_signature : Format.formatter -> signature -> Ppx_deriving_runtime.unit
val show_signature : signature -> Ppx_deriving_runtime.string
val sig_args : signature -> typ list
val sig_res : signature -> typ option
val proj_sig_res : signature -> typ
val signature_eq : signature -> signature -> bool
val signature_main : signature
type memory_chunk =
    Mint8signed
  | Mint8unsigned
  | Mint16signed
  | Mint16unsigned
  | Mint32
  | Mint64
  | Mfloat32
  | Mfloat64
  | Many32
  | Many64
val pp_memory_chunk :
  Format.formatter -> memory_chunk -> Ppx_deriving_runtime.unit
val show_memory_chunk : memory_chunk -> Ppx_deriving_runtime.string
val chunk_eq : memory_chunk -> memory_chunk -> bool
val coq_Mptr : memory_chunk
val type_of_chunk : memory_chunk -> typ
val chunk_of_type : typ -> memory_chunk
type init_data =
    Init_int8 of Integers.Int.int
  | Init_int16 of Integers.Int.int
  | Init_int32 of Integers.Int.int
  | Init_int64 of Integers.Int64.int
  | Init_float32 of Floats.float32
  | Init_float64 of Floats.float
  | Init_space of BinNums.coq_Z
  | Init_addrof of ident * Integers.Ptrofs.int
val init_data_size : init_data -> BinNums.coq_Z
val init_data_list_size : init_data list -> BinNums.coq_Z
type 'v globvar = {
  gvar_info : 'v;
  gvar_init : init_data list;
  gvar_readonly : bool;
  gvar_volatile : bool;
}
val gvar_info : 'a globvar -> 'a
val gvar_init : 'a globvar -> init_data list
val gvar_readonly : 'a globvar -> bool
val gvar_volatile : 'a globvar -> bool
type ('f, 'v) globdef = Gfun of 'f | Gvar of 'v globvar
type ('f, 'v) program = {
  prog_defs : (ident * ('f, 'v) globdef) list;
  prog_public : ident list;
  prog_main : ident;
}
val prog_defs : ('a, 'b) program -> (ident * ('a, 'b) globdef) list
val prog_public : ('a, 'b) program -> ident list
val prog_main : ('a, 'b) program -> ident
val prog_defmap : ('a, 'b) program -> ('a, 'b) globdef Maps.PTree.t
val transform_program_globdef :
  ('a -> 'b) -> 'c * ('a, 'd) globdef -> 'c * ('b, 'd) globdef
val transform_program : ('a -> 'b) -> ('a, 'c) program -> ('b, 'c) program
val transf_globvar :
  ('a -> 'b -> 'c Errors.res) -> 'a -> 'b globvar -> 'c globvar Errors.res
val transf_globdefs :
  (BinNums.positive -> 'a -> 'b Errors.res) ->
  (BinNums.positive -> 'c -> 'd Errors.res) ->
  (BinNums.positive * ('a, 'c) globdef) list ->
  (BinNums.positive * ('b, 'd) globdef) list Errors.res
val transform_partial_program2 :
  (ident -> 'a -> 'b Errors.res) ->
  (ident -> 'c -> 'd Errors.res) ->
  ('a, 'c) program -> ('b, 'd) program Errors.res
val transform_partial_program :
  ('a -> 'b Errors.res) -> ('a, 'c) program -> ('b, 'c) program Errors.res
type external_function =
    EF_external of char list * signature
  | EF_builtin of char list * signature
  | EF_runtime of char list * signature
  | EF_vload of memory_chunk
  | EF_vstore of memory_chunk
  | EF_malloc
  | EF_free
  | EF_memcpy of BinNums.coq_Z * BinNums.coq_Z
  | EF_annot of BinNums.positive * char list * typ list
  | EF_annot_val of BinNums.positive * char list * typ
  | EF_inline_asm of char list * signature * char list list
  | EF_debug of BinNums.positive * ident * typ list
val pp_external_function :
  Format.formatter -> external_function -> Ppx_deriving_runtime.unit
val show_external_function : external_function -> Ppx_deriving_runtime.string
val ef_sig : external_function -> signature
val ef_inline : external_function -> bool
val external_function_eq : external_function -> external_function -> bool
type 'f fundef = Internal of 'f | External of external_function
val transf_fundef : ('a -> 'b) -> 'a fundef -> 'b fundef
val transf_partial_fundef :
  ('a -> 'b Errors.res) -> 'a fundef -> 'b fundef Errors.res
type 'a rpair = One of 'a | Twolong of 'a * 'a
val map_rpair : ('a -> 'b) -> 'a rpair -> 'b rpair
val regs_of_rpair : 'a rpair -> 'a list
val regs_of_rpairs : 'a rpair list -> 'a list
type 'a builtin_arg =
    BA of 'a
  | BA_int of Integers.Int.int
  | BA_long of Integers.Int64.int
  | BA_float of Floats.float
  | BA_single of Floats.float32
  | BA_loadstack of memory_chunk * Integers.Ptrofs.int
  | BA_addrstack of Integers.Ptrofs.int
  | BA_loadglobal of memory_chunk * ident * Integers.Ptrofs.int
  | BA_addrglobal of ident * Integers.Ptrofs.int
  | BA_splitlong of 'a builtin_arg * 'a builtin_arg
  | BA_addptr of 'a builtin_arg * 'a builtin_arg
type 'a builtin_res =
    BR of 'a
  | BR_none
  | BR_splitlong of 'a builtin_res * 'a builtin_res
val globals_of_builtin_arg : 'a builtin_arg -> ident list
val globals_of_builtin_args : 'a builtin_arg list -> ident list
val params_of_builtin_arg : 'a builtin_arg -> 'a list
val params_of_builtin_args : 'a builtin_arg list -> 'a list
val params_of_builtin_res : 'a builtin_res -> 'a list
val map_builtin_arg : ('a -> 'b) -> 'a builtin_arg -> 'b builtin_arg
val map_builtin_res : ('a -> 'b) -> 'a builtin_res -> 'b builtin_res
type builtin_arg_constraint =
    OK_default
  | OK_const
  | OK_addrstack
  | OK_addressing
  | OK_all
