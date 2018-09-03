type constant =
    Ointconst of Integers.Int.int
  | Ofloatconst of Floats.float
  | Osingleconst of Floats.float32
  | Olongconst of Integers.Int64.int
  | Oaddrsymbol of AST.ident * Integers.Ptrofs.int
  | Oaddrstack of Integers.Ptrofs.int
type unary_operation =
    Ocast8unsigned
  | Ocast8signed
  | Ocast16unsigned
  | Ocast16signed
  | Onegint
  | Onotint
  | Onegf
  | Oabsf
  | Onegfs
  | Oabsfs
  | Osingleoffloat
  | Ofloatofsingle
  | Ointoffloat
  | Ointuoffloat
  | Ofloatofint
  | Ofloatofintu
  | Ointofsingle
  | Ointuofsingle
  | Osingleofint
  | Osingleofintu
  | Onegl
  | Onotl
  | Ointoflong
  | Olongofint
  | Olongofintu
  | Olongoffloat
  | Olonguoffloat
  | Ofloatoflong
  | Ofloatoflongu
  | Olongofsingle
  | Olonguofsingle
  | Osingleoflong
  | Osingleoflongu
type binary_operation =
    Oadd
  | Osub
  | Omul
  | Odiv
  | Odivu
  | Omod
  | Omodu
  | Oand
  | Oor
  | Oxor
  | Oshl
  | Oshr
  | Oshru
  | Oaddf
  | Osubf
  | Omulf
  | Odivf
  | Oaddfs
  | Osubfs
  | Omulfs
  | Odivfs
  | Oaddl
  | Osubl
  | Omull
  | Odivl
  | Odivlu
  | Omodl
  | Omodlu
  | Oandl
  | Oorl
  | Oxorl
  | Oshll
  | Oshrl
  | Oshrlu
  | Ocmp of Integers.comparison
  | Ocmpu of Integers.comparison
  | Ocmpf of Integers.comparison
  | Ocmpfs of Integers.comparison
  | Ocmpl of Integers.comparison
  | Ocmplu of Integers.comparison
type expr =
    Evar of AST.ident
  | Econst of constant
  | Eunop of unary_operation * expr
  | Ebinop of binary_operation * expr * expr
  | Eload of AST.memory_chunk * expr
type label = AST.ident
type stmt =
    Sskip
  | Sassign of AST.ident * expr
  | Sstore of AST.memory_chunk * expr * expr
  | Scall of AST.ident option * AST.signature * expr * expr list
  | Stailcall of AST.signature * expr * expr list
  | Sbuiltin of AST.ident option * AST.external_function * expr list
  | Sseq of stmt * stmt
  | Sifthenelse of expr * stmt * stmt
  | Sloop of stmt
  | Sblock of stmt
  | Sexit of Datatypes.nat
  | Sswitch of bool * expr * (BinNums.coq_Z * Datatypes.nat) list *
      Datatypes.nat
  | Sreturn of expr option
  | Slabel of label * stmt
  | Sgoto of label
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
