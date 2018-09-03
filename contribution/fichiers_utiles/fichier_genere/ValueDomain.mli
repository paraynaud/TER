type abool = Bnone | Just of bool | Maybe of bool | Btop
val club : abool -> abool -> abool
val cnot : abool -> abool
type aptr =
    Pbot
  | Gl of AST.ident * Integers.Ptrofs.int
  | Glo of AST.ident
  | Glob
  | Stk of Integers.Ptrofs.int
  | Stack
  | Nonstack
  | Ptop
val eq_aptr : aptr -> aptr -> bool
val plub : aptr -> aptr -> aptr
val pincl : aptr -> aptr -> bool
val padd : aptr -> BinNums.coq_Z -> aptr
val psub : aptr -> BinNums.coq_Z -> aptr
val poffset : aptr -> aptr
val cmp_different_blocks : Integers.comparison -> abool
val pcmp : Integers.comparison -> aptr -> aptr -> abool
val pdisjoint : aptr -> BinNums.coq_Z -> aptr -> BinNums.coq_Z -> bool
type aval =
    Vbot
  | I of Integers.Int.int
  | Uns of aptr * BinNums.coq_Z
  | Sgn of aptr * BinNums.coq_Z
  | L of Integers.Int64.int
  | F of Floats.float
  | FS of Floats.float32
  | Ptr of aptr
  | Ifptr of aptr
val coq_Vtop : aval
val eq_aval : aval -> aval -> bool
val usize : BinNums.coq_Z -> BinNums.coq_Z
val ssize : BinNums.coq_Z -> BinNums.coq_Z
val provenance : aval -> aptr
val ntop : aval
val ntop1 : aval -> aval
val ntop2 : aval -> aval -> aval
val uns : aptr -> BinNums.coq_Z -> aval
val sgn : aptr -> BinNums.coq_Z -> aval
val vlub : aval -> aval -> aval
val aptr_of_aval : aval -> aptr
val vplub : aval -> aptr -> aptr
val vpincl : aval -> aptr -> bool
val vincl : aval -> aval -> bool
val unop_int : (Integers.Int.int -> Integers.Int.int) -> aval -> aval
val binop_int :
  (Integers.Int.int -> Integers.Int.int -> Integers.Int.int) ->
  aval -> aval -> aval
val unop_long : (Integers.Int64.int -> Integers.Int64.int) -> aval -> aval
val binop_long :
  (Integers.Int64.int -> Integers.Int64.int -> Integers.Int64.int) ->
  aval -> aval -> aval
val unop_float : (Floats.float -> Floats.float) -> aval -> aval
val binop_float :
  (Floats.float -> Floats.float -> Floats.float) -> aval -> aval -> aval
val unop_single : (Floats.float32 -> Floats.float32) -> aval -> aval
val binop_single :
  (Floats.float32 -> Floats.float32 -> Floats.float32) ->
  aval -> aval -> aval
val shl : aval -> aval -> aval
val shru : aval -> aval -> aval
val shr : aval -> aval -> aval
val coq_and : aval -> aval -> aval
val coq_or : aval -> aval -> aval
val xor : aval -> aval -> aval
val notint : aval -> aval
val ror : aval -> aval -> aval
val neg : aval -> aval
val add : aval -> aval -> aval
val sub : aval -> aval -> aval
val mul : aval -> aval -> aval
val mulhs : aval -> aval -> aval
val mulhu : aval -> aval -> aval
val divs : aval -> aval -> aval
val divu : aval -> aval -> aval
val mods : aval -> aval -> aval
val modu : aval -> aval -> aval
val shrx : aval -> aval -> aval
val shift_long :
  (Integers.Int64.int -> Integers.Int.int -> Integers.Int64.int) ->
  aval -> aval -> aval
val shll : aval -> aval -> aval
val shrl : aval -> aval -> aval
val shrlu : aval -> aval -> aval
val andl : aval -> aval -> aval
val orl : aval -> aval -> aval
val xorl : aval -> aval -> aval
val notl : aval -> aval
val rotate_long :
  (Integers.Int64.int -> BinNums.coq_Z -> Integers.Int64.int) ->
  aval -> aval -> aval
val rorl : aval -> aval -> aval
val negl : aval -> aval
val addl : aval -> aval -> aval
val subl : aval -> aval -> aval
val mull : aval -> aval -> aval
val mullhs : aval -> aval -> aval
val mullhu : aval -> aval -> aval
val divls : aval -> aval -> aval
val divlu : aval -> aval -> aval
val modls : aval -> aval -> aval
val modlu : aval -> aval -> aval
val shrxl : aval -> aval -> aval
val negf : aval -> aval
val absf : aval -> aval
val addf : aval -> aval -> aval
val subf : aval -> aval -> aval
val mulf : aval -> aval -> aval
val divf : aval -> aval -> aval
val negfs : aval -> aval
val absfs : aval -> aval
val addfs : aval -> aval -> aval
val subfs : aval -> aval -> aval
val mulfs : aval -> aval -> aval
val divfs : aval -> aval -> aval
val zero_ext : BinNums.coq_Z -> aval -> aval
val sign_ext : BinNums.coq_Z -> aval -> aval
val longofint : aval -> aval
val longofintu : aval -> aval
val singleoffloat : aval -> aval
val floatofsingle : aval -> aval
val intoffloat : aval -> aval
val floatofint : aval -> aval
val intofsingle : aval -> aval
val singleofint : aval -> aval
val longoffloat : aval -> aval
val floatoflong : aval -> aval
val longofsingle : aval -> aval
val singleoflong : aval -> aval
val longofwords : aval -> aval -> aval
val loword : aval -> aval
val hiword : aval -> aval
val cmp_intv :
  Integers.comparison ->
  BinNums.coq_Z * BinNums.coq_Z -> BinNums.coq_Z -> abool
val uintv : aval -> Integers.Int.int * Integers.Int.int
val sintv : aval -> BinNums.coq_Z * BinNums.coq_Z
val cmpu_bool : Integers.comparison -> aval -> aval -> abool
val cmp_bool : Integers.comparison -> aval -> aval -> abool
val cmplu_bool : Integers.comparison -> aval -> aval -> abool
val cmpl_bool : Integers.comparison -> aval -> aval -> abool
val cmpf_bool : Integers.comparison -> aval -> aval -> abool
val cmpfs_bool : Integers.comparison -> aval -> aval -> abool
val maskzero : aval -> BinNums.coq_Z -> abool
val of_optbool : abool -> aval
val resolve_branch : abool -> bool option
val vnormalize : AST.memory_chunk -> aval -> aval
type acontent = ACval of AST.memory_chunk * aval
val eq_acontent : acontent -> acontent -> bool
type ablock = { ab_contents : acontent Maps.ZTree.t; ab_summary : aptr; }
val ab_contents : ablock -> acontent Maps.ZTree.t
val ab_summary : ablock -> aptr
val ablock_init : aptr -> ablock
val chunk_compat : AST.memory_chunk -> AST.memory_chunk -> bool
val ablock_load : AST.memory_chunk -> ablock -> Maps.ZIndexed.t -> aval
val ablock_load_anywhere : AST.memory_chunk -> ablock -> aval
val inval_after :
  BinNums.coq_Z ->
  Maps.ZIndexed.t -> 'a Maps.PTree.tree -> 'a Maps.PTree.tree
val inval_if :
  BinNums.coq_Z ->
  Maps.ZIndexed.t -> acontent Maps.PTree.tree -> acontent Maps.PTree.tree
val inval_before :
  BinNums.coq_Z ->
  Maps.ZIndexed.t -> acontent Maps.PTree.tree -> acontent Maps.PTree.tree
val ablock_store :
  AST.memory_chunk -> ablock -> Maps.ZIndexed.t -> aval -> ablock
val ablock_store_anywhere : 'a -> ablock -> aval -> ablock
val ablock_loadbytes : ablock -> aptr
val ablock_storebytes :
  ablock -> aptr -> BinNums.coq_Z -> BinNums.coq_Z -> ablock
val ablock_storebytes_anywhere : ablock -> aptr -> ablock
val bbeq : ablock -> ablock -> bool
val combine_acontents : acontent option -> acontent option -> acontent option
val blub : ablock -> ablock -> ablock
type romem = ablock Maps.PTree.t
type amem = {
  am_stack : ablock;
  am_glob : ablock Maps.PTree.t;
  am_nonstack : aptr;
  am_top : aptr;
}
val am_stack : amem -> ablock
val am_glob : amem -> ablock Maps.PTree.t
val am_nonstack : amem -> aptr
val am_top : amem -> aptr
val minit : aptr -> amem
val mtop : amem
val load : AST.memory_chunk -> ablock Maps.PTree.tree -> amem -> aptr -> aval
val loadv :
  AST.memory_chunk -> ablock Maps.PTree.tree -> amem -> aval -> aval
val store : AST.memory_chunk -> amem -> aptr -> aval -> amem
val storev : AST.memory_chunk -> amem -> aval -> aval -> amem
val loadbytes : amem -> ablock Maps.PTree.tree -> aptr -> aptr
val storebytes : amem -> aptr -> BinNums.coq_Z -> aptr -> amem
val mbeq : amem -> amem -> bool
val combine_ablock : ablock option -> ablock option -> ablock option
val mlub : amem -> amem -> amem
module AVal :
  sig
    type t = aval
    val beq : aval -> aval -> bool
    val bot : aval
    val top : aval
    val lub : aval -> aval -> aval
  end
module AE :
  sig
    type t' =
      Lattice.LPMap(AVal).t' =
        Bot
      | Top_except of AVal.t Maps.PTree.t
    type t = t'
    val get : BinNums.positive -> t' -> AVal.t
    val set : BinNums.positive -> AVal.t -> t' -> t'
    val beq : t' -> t' -> bool
    val bot : t'
    val top : t'
    module LM :
      sig
        type t = AVal.t Maps.PTree.t
        val get : BinNums.positive -> AVal.t Maps.PTree.tree -> AVal.t
        val set :
          BinNums.positive ->
          AVal.t -> AVal.t Maps.PTree.tree -> AVal.t Maps.PTree.tree
        val beq : AVal.t Maps.PTree.tree -> AVal.t Maps.PTree.tree -> bool
        val bot : 'a Maps.PTree.tree
        val opt_beq : AVal.t option -> AVal.t option -> bool
        type changed =
          Lattice.LPMap1(AVal).changed =
            Unchanged
          | Changed of AVal.t Maps.PTree.t
        val combine_l :
          (AVal.t option -> 'a option -> AVal.t option) ->
          AVal.t Maps.PTree.tree -> changed
        val combine_r :
          ('a option -> AVal.t option -> AVal.t option) ->
          AVal.t Maps.PTree.tree -> changed
        type changed2 =
          Lattice.LPMap1(AVal).changed2 =
            Same
          | Same1
          | Same2
          | CC of AVal.t Maps.PTree.t
        val xcombine :
          (AVal.t option -> AVal.t option -> AVal.t option) ->
          AVal.t Maps.PTree.tree -> AVal.t Maps.PTree.tree -> changed2
        val combine :
          (AVal.t option -> AVal.t option -> AVal.t option) ->
          AVal.t Maps.PTree.t -> AVal.t Maps.PTree.t -> AVal.t Maps.PTree.t
        val lub :
          AVal.t Maps.PTree.t -> AVal.t Maps.PTree.t -> AVal.t Maps.PTree.t
      end
    val opt_lub : AVal.t -> AVal.t -> AVal.t option
    val lub : t' -> t' -> t'
  end
type aenv = AE.t
val einit_regs : BinNums.positive list -> AE.t'
val eforget : BinNums.positive list -> AE.t' -> AE.t'
module VA :
  sig
    type t' = Bot | State of aenv * amem
    val t'_rect : 'a -> (aenv -> amem -> 'a) -> t' -> 'a
    val t'_rec : 'a -> (aenv -> amem -> 'a) -> t' -> 'a
    type t = t'
    val beq : t' -> t' -> bool
    val bot : t'
    val lub : t' -> t' -> t'
  end
