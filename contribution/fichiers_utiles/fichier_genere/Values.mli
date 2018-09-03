type block = BinNums.positive
val eq_block : BinNums.positive -> BinNums.positive -> bool
type coq_val =
    Vundef
  | Vint of Integers.Int.int
  | Vlong of Integers.Int64.int
  | Vfloat of Floats.float
  | Vsingle of Floats.float32
  | Vptr of block * Integers.Ptrofs.int
val coq_Vzero : coq_val
val coq_Vone : coq_val
val coq_Vtrue : coq_val
val coq_Vfalse : coq_val
val coq_Vptrofs : BinNums.coq_Z -> coq_val
module Val :
  sig
    val eq : coq_val -> coq_val -> bool
    val of_bool : bool -> coq_val
    val add : coq_val -> coq_val -> coq_val
    val addl : coq_val -> coq_val -> coq_val
    val cmp_different_blocks : Integers.comparison -> bool option
    val cmpu_bool :
      (block -> Integers.Ptrofs.int -> bool) ->
      Integers.comparison -> coq_val -> coq_val -> bool option
    val cmplu_bool :
      (block -> Integers.Ptrofs.int -> bool) ->
      Integers.comparison -> coq_val -> coq_val -> bool option
    val load_result : AST.memory_chunk -> coq_val -> coq_val
  end
