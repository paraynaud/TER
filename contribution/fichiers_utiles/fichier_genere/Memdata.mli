val size_chunk : AST.memory_chunk -> BinNums.coq_Z
val size_chunk_nat : AST.memory_chunk -> Datatypes.nat
val align_chunk : AST.memory_chunk -> BinNums.coq_Z
type quantity = Q32 | Q64
val quantity_eq : quantity -> quantity -> bool
val size_quantity_nat : quantity -> Datatypes.nat
type memval =
    Undef
  | Byte of Integers.Byte.int
  | Fragment of Values.coq_val * quantity * Datatypes.nat
val bytes_of_int : Datatypes.nat -> BinNums.coq_Z -> BinNums.coq_Z list
val int_of_bytes : BinNums.coq_Z list -> BinNums.coq_Z
val rev_if_be : 'a list -> 'a list
val encode_int : Datatypes.nat -> BinNums.coq_Z -> BinNums.coq_Z list
val decode_int : BinNums.coq_Z list -> BinNums.coq_Z
val inj_bytes : Integers.Byte.int list -> memval list
val proj_bytes : memval list -> Integers.Byte.int list option
val inj_value_rec :
  Datatypes.nat -> Values.coq_val -> quantity -> memval list
val inj_value : quantity -> Values.coq_val -> memval list
val check_value :
  Datatypes.nat -> Values.coq_val -> quantity -> memval list -> bool
val proj_value : quantity -> memval list -> Values.coq_val
val encode_val : AST.memory_chunk -> Values.coq_val -> memval list
val decode_val : AST.memory_chunk -> memval list -> Values.coq_val
