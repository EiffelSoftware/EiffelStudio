-- Skeleton constants

class SK_CONST
	
feature {NONE}

	Sk_exp: INTEGER is
			-- Hexa value 0x80000000
		external
			"C [macro %"eif_struct.h%"]"
		alias
			"SK_EXP"
		end

	Sk_bool: INTEGER is
			-- Hexa value 0x04000000
		external
			"C [macro %"eif_struct.h%"]"
		alias
			"SK_BOOL"
		end

	Sk_char: INTEGER is
			-- Hexa value 0x08000000
		external
			"C [macro %"eif_struct.h%"]"
		alias
			"SK_CHAR"
		end

	Sk_int: INTEGER is
			-- Hexa value 0x10000000
		external
			"C [macro %"eif_struct.h%"]"
		alias
			"SK_INT"
		end

	Sk_float: INTEGER is
			-- Hexa value 0x18000000
		external
			"C [macro %"eif_struct.h%"]"
		alias
			"SK_FLOAT"
		end

	Sk_double: INTEGER is
			-- Hexa value 0x20000000
		external
			"C [macro %"eif_struct.h%"]"
		alias
			"SK_DOUBLE"
		end

	Sk_bit: INTEGER is
			-- Hexa value 0x28000000
		external
			"C [macro %"eif_struct.h%"]"
		alias
			"SK_BIT"
		end

	Sk_pointer: INTEGER is
			-- Hexa value 0x40000000
		external
			"C [macro %"eif_struct.h%"]"
		alias
			"SK_POINTER"
		end

	Sk_ref: INTEGER is
			-- Hexa value 0xf8000000
		external
			"C [macro %"eif_struct.h%"]"
		alias
			"SK_REF"
		end

	Sk_void: INTEGER is
			-- Hexa value 0x00000000
		external
			"C [macro %"eif_struct.h%"]"
		alias
			"SK_VOID"
		end

	Sk_dtype: INTEGER is
			-- Hexa value 0x0000ffff
		external
			"C [macro %"eif_struct.h%"]"
		alias
			"SK_DTYPE"
		end

end
