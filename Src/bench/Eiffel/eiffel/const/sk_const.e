indexing
	description: "Skeleton constants."
	warning: "When updating this class, do not forget to update the run-time counterpart%N%
			%too (eif_struct.h)"
	date: "$Date$"
	revision: "$Revision$"

class SK_CONST
	
feature {NONE}

	Sk_exp: INTEGER is 0x80000000
			-- Defined in eif_struct.h as SK_EXP

	Sk_bool: INTEGER is 0x04000000
			-- Defined in eif_struct.h as SK_BOOL

	Sk_char: INTEGER is 0x08000000
			-- Defined in eif_struct.h as SK_CHAR

	Sk_int8: INTEGER is 0x0c000000
			-- Defined in eif_struct.h as SK_INT8

	Sk_int: INTEGER is 0x10000000
			-- Defined in eif_struct.h as SK_INT

	Sk_int32: INTEGER is 0x10000000
			-- Defined in eif_struct.h as SK_INT32

	Sk_int16: INTEGER is 0x14000000
			-- Defined in eif_struct.h as SK_INT16

	Sk_float: INTEGER is 0x18000000
			-- Defined in eif_struct.h as SK_FLOAT

	Sk_wchar: INTEGER is 0x1c000000
			-- Defined in eif_struct.h as SK_WCHAR

	Sk_double: INTEGER is 0x20000000
			-- Defined in eif_struct.h as SK_DOUBLE

	Sk_int64: INTEGER is 0x24000000
			-- Defined in eif_struct.h as SK_INT64

	Sk_bit: INTEGER is 0x28000000
			-- Defined in eif_struct.h as SK_BIT

	Sk_pointer: INTEGER is 0x40000000
			-- Defined in eif_struct.h as SK_POINTER

	Sk_ref: INTEGER is 0xf8000000
			-- Defined in eif_struct.h as SK_REF

	Sk_void: INTEGER is 0x00000000
			-- Defined in eif_struct.h as SK_VOID

	Sk_dtype: INTEGER is 0x0000ffff
			-- Defined in eif_struct.h as SK_DTYPE

	--| -----------------------------
	--| also defined in eif_struct.h:
	--| SK_BMASK		0x07ffffff
	--| SK_SIMPLE		0x7c000000
	--| SK_HEAD			0xff000000
	--| SK_INVALID		0xffffffff
	--| SK_MASK			0x7fffffff
	--| -----------------------------

end
