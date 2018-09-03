type comparison = Ceq | Cne | Clt | Cle | Cgt | Cge
val pp_comparison :
  Format.formatter -> comparison -> Ppx_deriving_runtime.unit
val show_comparison : comparison -> Ppx_deriving_runtime.string
val negate_comparison : comparison -> comparison
val swap_comparison : comparison -> comparison
module type WORDSIZE = sig val wordsize : Datatypes.nat end
module Make :
  functor (WS : WORDSIZE) ->
    sig
      val wordsize : Datatypes.nat
      val zwordsize : BinNums.coq_Z
      val modulus : BinNums.coq_Z
      val half_modulus : BinNums.coq_Z
      val max_unsigned : BinNums.coq_Z
      val max_signed : BinNums.coq_Z
      val min_signed : BinNums.coq_Z
      type int = BinNums.coq_Z
      val pp_int : Format.formatter -> int -> Ppx_deriving_runtime.unit
      val show_int : int -> Ppx_deriving_runtime.string
      val intval : 'a -> 'a
      val coq_P_mod_two_p :
        BinNums.positive -> Datatypes.nat -> BinNums.coq_Z
      val coq_Z_mod_modulus : BinNums.coq_Z -> BinNums.coq_Z
      val unsigned : 'a -> 'a
      val signed : BinNums.coq_Z -> BinNums.coq_Z
      val repr : BinNums.coq_Z -> BinNums.coq_Z
      val zero : BinNums.coq_Z
      val one : BinNums.coq_Z
      val mone : BinNums.coq_Z
      val iwordsize : BinNums.coq_Z
      val eq_dec : BinNums.coq_Z -> BinNums.coq_Z -> bool
      val eq : BinNums.coq_Z -> BinNums.coq_Z -> bool
      val lt : BinNums.coq_Z -> BinNums.coq_Z -> bool
      val ltu : BinNums.coq_Z -> BinNums.coq_Z -> bool
      val neg : BinNums.coq_Z -> BinNums.coq_Z
      val add : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val sub : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val mul : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val divs : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val mods : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val divu : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val modu : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val coq_and : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val coq_or : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val xor : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val not : BinNums.coq_Z -> BinNums.coq_Z
      val shl : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val shru : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val shr : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val rol : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val ror : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val rolm :
        BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val shrx : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val mulhu : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val mulhs : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val negative : BinNums.coq_Z -> BinNums.coq_Z
      val add_carry :
        BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val add_overflow :
        BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val sub_borrow :
        BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val sub_overflow :
        BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val shr_carry : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val coq_Zshiftin : bool -> BinNums.coq_Z -> BinNums.coq_Z
      val coq_Zzero_ext : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val coq_Zsign_ext : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val zero_ext : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val sign_ext : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
      val coq_Z_one_bits :
        Datatypes.nat -> BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z list
      val one_bits : BinNums.coq_Z -> BinNums.coq_Z list
      val is_power2 : BinNums.coq_Z -> BinNums.coq_Z option
      val cmp : comparison -> BinNums.coq_Z -> BinNums.coq_Z -> bool
      val cmpu : comparison -> BinNums.coq_Z -> BinNums.coq_Z -> bool
      val notbool : BinNums.coq_Z -> BinNums.coq_Z
      val divmodu2 :
        BinNums.coq_Z ->
        BinNums.coq_Z ->
        BinNums.coq_Z -> (BinNums.coq_Z * BinNums.coq_Z) option
      val divmods2 :
        BinNums.coq_Z ->
        BinNums.coq_Z ->
        BinNums.coq_Z -> (BinNums.coq_Z * BinNums.coq_Z) option
      val testbit : BinNums.coq_Z -> BinNums.coq_Z -> bool
      val powerserie : BinNums.coq_Z list -> BinNums.coq_Z
      val int_of_one_bits : BinNums.coq_Z list -> BinNums.coq_Z
      val no_overlap :
        BinNums.coq_Z ->
        BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z -> bool
      val coq_Zsize : BinNums.coq_Z -> BinNums.coq_Z
      val size : BinNums.coq_Z -> BinNums.coq_Z
    end
module Wordsize_32 : sig val wordsize : Datatypes.nat end
module Int :
  sig
    val wordsize : Datatypes.nat
    val zwordsize : BinNums.coq_Z
    val modulus : BinNums.coq_Z
    val half_modulus : BinNums.coq_Z
    val max_unsigned : BinNums.coq_Z
    val max_signed : BinNums.coq_Z
    val min_signed : BinNums.coq_Z
    type int = BinNums.coq_Z
    val pp_int : Format.formatter -> int -> Ppx_deriving_runtime.unit
    val show_int : int -> Ppx_deriving_runtime.string
    val intval : 'a -> 'a
    val coq_P_mod_two_p : BinNums.positive -> Datatypes.nat -> BinNums.coq_Z
    val coq_Z_mod_modulus : BinNums.coq_Z -> BinNums.coq_Z
    val unsigned : 'a -> 'a
    val signed : BinNums.coq_Z -> BinNums.coq_Z
    val repr : BinNums.coq_Z -> BinNums.coq_Z
    val zero : BinNums.coq_Z
    val one : BinNums.coq_Z
    val mone : BinNums.coq_Z
    val iwordsize : BinNums.coq_Z
    val eq_dec : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val eq : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val lt : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val ltu : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val neg : BinNums.coq_Z -> BinNums.coq_Z
    val add : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val sub : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val mul : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val divs : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val mods : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val divu : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val modu : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val coq_and : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val coq_or : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val xor : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val not : BinNums.coq_Z -> BinNums.coq_Z
    val shl : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val shru : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val shr : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val rol : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val ror : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val rolm :
      BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val shrx : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val mulhu : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val mulhs : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val negative : BinNums.coq_Z -> BinNums.coq_Z
    val add_carry :
      BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val add_overflow :
      BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val sub_borrow :
      BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val sub_overflow :
      BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val shr_carry : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val coq_Zshiftin : bool -> BinNums.coq_Z -> BinNums.coq_Z
    val coq_Zzero_ext : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val coq_Zsign_ext : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val zero_ext : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val sign_ext : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val coq_Z_one_bits :
      Datatypes.nat -> BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z list
    val one_bits : BinNums.coq_Z -> BinNums.coq_Z list
    val is_power2 : BinNums.coq_Z -> BinNums.coq_Z option
    val cmp : comparison -> BinNums.coq_Z -> BinNums.coq_Z -> bool
    val cmpu : comparison -> BinNums.coq_Z -> BinNums.coq_Z -> bool
    val notbool : BinNums.coq_Z -> BinNums.coq_Z
    val divmodu2 :
      BinNums.coq_Z ->
      BinNums.coq_Z ->
      BinNums.coq_Z -> (BinNums.coq_Z * BinNums.coq_Z) option
    val divmods2 :
      BinNums.coq_Z ->
      BinNums.coq_Z ->
      BinNums.coq_Z -> (BinNums.coq_Z * BinNums.coq_Z) option
    val testbit : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val powerserie : BinNums.coq_Z list -> BinNums.coq_Z
    val int_of_one_bits : BinNums.coq_Z list -> BinNums.coq_Z
    val no_overlap :
      BinNums.coq_Z ->
      BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z -> bool
    val coq_Zsize : BinNums.coq_Z -> BinNums.coq_Z
    val size : BinNums.coq_Z -> BinNums.coq_Z
  end
module Wordsize_8 : sig val wordsize : Datatypes.nat end
module Byte :
  sig
    val wordsize : Datatypes.nat
    val zwordsize : BinNums.coq_Z
    val modulus : BinNums.coq_Z
    val half_modulus : BinNums.coq_Z
    val max_unsigned : BinNums.coq_Z
    val max_signed : BinNums.coq_Z
    val min_signed : BinNums.coq_Z
    type int = BinNums.coq_Z
    val pp_int : Format.formatter -> int -> Ppx_deriving_runtime.unit
    val show_int : int -> Ppx_deriving_runtime.string
    val intval : 'a -> 'a
    val coq_P_mod_two_p : BinNums.positive -> Datatypes.nat -> BinNums.coq_Z
    val coq_Z_mod_modulus : BinNums.coq_Z -> BinNums.coq_Z
    val unsigned : 'a -> 'a
    val signed : BinNums.coq_Z -> BinNums.coq_Z
    val repr : BinNums.coq_Z -> BinNums.coq_Z
    val zero : BinNums.coq_Z
    val one : BinNums.coq_Z
    val mone : BinNums.coq_Z
    val iwordsize : BinNums.coq_Z
    val eq_dec : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val eq : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val lt : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val ltu : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val neg : BinNums.coq_Z -> BinNums.coq_Z
    val add : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val sub : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val mul : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val divs : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val mods : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val divu : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val modu : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val coq_and : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val coq_or : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val xor : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val not : BinNums.coq_Z -> BinNums.coq_Z
    val shl : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val shru : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val shr : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val rol : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val ror : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val rolm :
      BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val shrx : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val mulhu : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val mulhs : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val negative : BinNums.coq_Z -> BinNums.coq_Z
    val add_carry :
      BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val add_overflow :
      BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val sub_borrow :
      BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val sub_overflow :
      BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val shr_carry : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val coq_Zshiftin : bool -> BinNums.coq_Z -> BinNums.coq_Z
    val coq_Zzero_ext : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val coq_Zsign_ext : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val zero_ext : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val sign_ext : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val coq_Z_one_bits :
      Datatypes.nat -> BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z list
    val one_bits : BinNums.coq_Z -> BinNums.coq_Z list
    val is_power2 : BinNums.coq_Z -> BinNums.coq_Z option
    val cmp : comparison -> BinNums.coq_Z -> BinNums.coq_Z -> bool
    val cmpu : comparison -> BinNums.coq_Z -> BinNums.coq_Z -> bool
    val notbool : BinNums.coq_Z -> BinNums.coq_Z
    val divmodu2 :
      BinNums.coq_Z ->
      BinNums.coq_Z ->
      BinNums.coq_Z -> (BinNums.coq_Z * BinNums.coq_Z) option
    val divmods2 :
      BinNums.coq_Z ->
      BinNums.coq_Z ->
      BinNums.coq_Z -> (BinNums.coq_Z * BinNums.coq_Z) option
    val testbit : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val powerserie : BinNums.coq_Z list -> BinNums.coq_Z
    val int_of_one_bits : BinNums.coq_Z list -> BinNums.coq_Z
    val no_overlap :
      BinNums.coq_Z ->
      BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z -> bool
    val coq_Zsize : BinNums.coq_Z -> BinNums.coq_Z
    val size : BinNums.coq_Z -> BinNums.coq_Z
  end
module Wordsize_64 : sig val wordsize : Datatypes.nat end
module Int64 :
  sig
    val wordsize : Datatypes.nat
    val zwordsize : BinNums.coq_Z
    val modulus : BinNums.coq_Z
    val half_modulus : BinNums.coq_Z
    val max_unsigned : BinNums.coq_Z
    val max_signed : BinNums.coq_Z
    val min_signed : BinNums.coq_Z
    type int = BinNums.coq_Z
    val pp_int : Format.formatter -> int -> Ppx_deriving_runtime.unit
    val show_int : int -> Ppx_deriving_runtime.string
    val intval : 'a -> 'a
    val coq_P_mod_two_p : BinNums.positive -> Datatypes.nat -> BinNums.coq_Z
    val coq_Z_mod_modulus : BinNums.coq_Z -> BinNums.coq_Z
    val unsigned : 'a -> 'a
    val signed : BinNums.coq_Z -> BinNums.coq_Z
    val repr : BinNums.coq_Z -> BinNums.coq_Z
    val zero : BinNums.coq_Z
    val one : BinNums.coq_Z
    val mone : BinNums.coq_Z
    val iwordsize : BinNums.coq_Z
    val eq_dec : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val eq : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val lt : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val ltu : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val neg : BinNums.coq_Z -> BinNums.coq_Z
    val add : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val sub : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val mul : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val divs : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val mods : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val divu : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val modu : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val coq_and : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val coq_or : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val xor : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val not : BinNums.coq_Z -> BinNums.coq_Z
    val shl : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val shru : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val shr : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val ror : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val mulhu : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val mulhs : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val coq_Z_one_bits :
      Datatypes.nat -> BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z list
    val is_power2 : BinNums.coq_Z -> BinNums.coq_Z option
    val cmp : comparison -> BinNums.coq_Z -> BinNums.coq_Z -> bool
    val cmpu : comparison -> BinNums.coq_Z -> BinNums.coq_Z -> bool
    val iwordsize' : BinNums.coq_Z
    val shl' : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val shru' : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val shr' : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val shrx' : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val one_bits' : BinNums.coq_Z -> BinNums.coq_Z list
    val is_power2' : BinNums.coq_Z -> BinNums.coq_Z option
    val loword : BinNums.coq_Z -> BinNums.coq_Z
    val hiword : BinNums.coq_Z -> BinNums.coq_Z
    val ofwords : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
  end
module Wordsize_Ptrofs : sig val wordsize : Datatypes.nat end
module Ptrofs :
  sig
    val wordsize : Datatypes.nat
    val modulus : BinNums.coq_Z
    val half_modulus : BinNums.coq_Z
    val max_unsigned : BinNums.coq_Z
    val max_signed : BinNums.coq_Z
    type int = BinNums.coq_Z
    val pp_int : Format.formatter -> int -> Ppx_deriving_runtime.unit
    val show_int : int -> Ppx_deriving_runtime.string
    val intval : 'a -> 'a
    val coq_P_mod_two_p : BinNums.positive -> Datatypes.nat -> BinNums.coq_Z
    val coq_Z_mod_modulus : BinNums.coq_Z -> BinNums.coq_Z
    val unsigned : 'a -> 'a
    val signed : BinNums.coq_Z -> BinNums.coq_Z
    val repr : BinNums.coq_Z -> BinNums.coq_Z
    val zero : BinNums.coq_Z
    val eq_dec : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val eq : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val ltu : BinNums.coq_Z -> BinNums.coq_Z -> bool
    val add : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val sub : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val mul : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val divs : BinNums.coq_Z -> BinNums.coq_Z -> BinNums.coq_Z
    val cmpu : comparison -> BinNums.coq_Z -> BinNums.coq_Z -> bool
    val to_int : BinNums.coq_Z -> BinNums.coq_Z
    val to_int64 : BinNums.coq_Z -> BinNums.coq_Z
    val of_int : BinNums.coq_Z -> BinNums.coq_Z
    val of_intu : BinNums.coq_Z -> BinNums.coq_Z
    val of_ints : BinNums.coq_Z -> BinNums.coq_Z
    val of_int64 : BinNums.coq_Z -> BinNums.coq_Z
  end
