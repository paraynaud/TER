type condition =
    Ccomp of Integers.comparison
  | Ccompu of Integers.comparison
  | Ccompimm of Integers.comparison * Integers.Int.int
  | Ccompuimm of Integers.comparison * Integers.Int.int
  | Ccompl of Integers.comparison
  | Ccomplu of Integers.comparison
  | Ccomplimm of Integers.comparison * Integers.Int64.int
  | Ccompluimm of Integers.comparison * Integers.Int64.int
  | Ccompf of Integers.comparison
  | Cnotcompf of Integers.comparison
  | Ccompfs of Integers.comparison
  | Cnotcompfs of Integers.comparison
  | Cmaskzero of Integers.Int.int
  | Cmasknotzero of Integers.Int.int
val pp_condition : Format.formatter -> condition -> Ppx_deriving_runtime.unit
val show_condition : condition -> Ppx_deriving_runtime.string
type addressing =
    Aindexed of BinNums.coq_Z
  | Aindexed2 of BinNums.coq_Z
  | Ascaled of BinNums.coq_Z * BinNums.coq_Z
  | Aindexed2scaled of BinNums.coq_Z * BinNums.coq_Z
  | Aglobal of AST.ident * Integers.Ptrofs.int
  | Abased of AST.ident * Integers.Ptrofs.int
  | Abasedscaled of BinNums.coq_Z * AST.ident * Integers.Ptrofs.int
  | Ainstack of Integers.Ptrofs.int
val pp_addressing :
  Format.formatter -> addressing -> Ppx_deriving_runtime.unit
val show_addressing : addressing -> Ppx_deriving_runtime.string
type operation =
    Omove
  | Ointconst of Integers.Int.int
  | Olongconst of Integers.Int64.int
  | Ofloatconst of Integers.Int64.int
  | Osingleconst of Floats.float32
  | Oindirectsymbol of AST.ident
  | Ocast8signed
  | Ocast8unsigned
  | Ocast16signed
  | Ocast16unsigned
  | Oneg
  | Osub
  | Omul
  | Omulimm of Integers.Int.int
  | Omulhs
  | Omulhu
  | Odiv
  | Odivu
  | Omod
  | Omodu
  | Oand
  | Oandimm of Integers.Int.int
  | Oor
  | Oorimm of Integers.Int.int
  | Oxor
  | Oxorimm of Integers.Int.int
  | Onot
  | Oshl
  | Oshlimm of Integers.Int.int
  | Oshr
  | Oshrimm of Integers.Int.int
  | Oshrximm of Integers.Int.int
  | Oshru
  | Oshruimm of Integers.Int.int
  | Ororimm of Integers.Int.int
  | Oshldimm of Integers.Int.int
  | Olea of addressing
  | Omakelong
  | Olowlong
  | Ohighlong
  | Ocast32signed
  | Ocast32unsigned
  | Onegl
  | Oaddlimm of Integers.Int64.int
  | Osubl
  | Omull
  | Omullimm of Integers.Int64.int
  | Omullhs
  | Omullhu
  | Odivl
  | Odivlu
  | Omodl
  | Omodlu
  | Oandl
  | Oandlimm of Integers.Int64.int
  | Oorl
  | Oorlimm of Integers.Int64.int
  | Oxorl
  | Oxorlimm of Integers.Int64.int
  | Onotl
  | Oshll
  | Oshllimm of Integers.Int.int
  | Oshrl
  | Oshrlimm of Integers.Int.int
  | Oshrxlimm of Integers.Int.int
  | Oshrlu
  | Oshrluimm of Integers.Int.int
  | Ororlimm of Integers.Int.int
  | Oleal of addressing
  | Onegf
  | Oabsf
  | Oaddf
  | Osubf
  | Omulf
  | Odivf
  | Onegfs
  | Oabsfs
  | Oaddfs
  | Osubfs
  | Omulfs
  | Odivfs
  | Osingleoffloat
  | Ofloatofsingle
  | Ointoffloat
  | Ofloatofint
  | Ointofsingle
  | Osingleofint
  | Olongoffloat
  | Ofloatoflong
  | Olongofsingle
  | Osingleoflong
  | Ocmp of condition
val pp_operation : Format.formatter -> operation -> Ppx_deriving_runtime.unit
val show_operation : operation -> Ppx_deriving_runtime.string
val eq_condition : condition -> condition -> bool
val eq_addressing : addressing -> addressing -> bool
val beq_operation : operation -> operation -> bool
val eq_operation : operation -> operation -> bool
val offset_in_range : BinNums.coq_Z -> bool
val ptroffset_min : BinNums.coq_Z
val ptroffset_max : BinNums.coq_Z
val ptroffset_in_range : BinNums.coq_Z -> bool
val addressing_valid : addressing -> bool
val type_of_condition : condition -> AST.typ list
val type_of_addressing_gen : 'a -> addressing -> 'a list
val type_of_addressing : addressing -> AST.typ list
val type_of_addressing32 : addressing -> AST.typ list
val type_of_addressing64 : addressing -> AST.typ list
val type_of_operation : operation -> AST.typ list * AST.typ
val is_move_operation : operation -> 'a list -> 'a option
val negate_condition : condition -> condition
val shift_stack_addressing : BinNums.coq_Z -> addressing -> addressing
val shift_stack_operation : BinNums.coq_Z -> operation -> operation
val offset_addressing_total : addressing -> BinNums.coq_Z -> addressing
val offset_addressing : addressing -> BinNums.coq_Z -> addressing option
val is_trivial_op : operation -> bool
val op_depends_on_memory : operation -> bool
val globals_addressing : addressing -> AST.ident list
val globals_operation : operation -> AST.ident list
val builtin_arg_ok_1 :
  'a AST.builtin_arg -> AST.builtin_arg_constraint -> bool
val builtin_arg_ok : 'a AST.builtin_arg -> AST.builtin_arg_constraint -> bool
