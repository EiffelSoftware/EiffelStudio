-- Meta-type size

class SHARED_SIZE

feature {NONE}

	Char_size: INTEGER is
			-- Size of a character
		external
			"C [macro %"eif_eiffel.h%"]"
		alias
			"sizeof(EIF_CHARACTER)"
		end;

	Int8_size: INTEGER is
			-- Size of a 8 bits integer
		external
			"C [macro %"eif_eiffel.h%"]"
		alias
			"sizeof(EIF_INTEGER_8)"
		end;

	Int16_size: INTEGER is
			-- Size of a 16 bits integer
		external
			"C [macro %"eif_eiffel.h%"]"
		alias
			"sizeof(EIF_INTEGER_16)"
		end;

	Int32_size: INTEGER is
			-- Size of a 32 bits integer
		external
			"C [macro %"eif_eiffel.h%"]"
		alias
			"sizeof(EIF_INTEGER_32)"
		end;

	Int64_size: INTEGER is
			-- Size of a 64 bits integer
		external
			"C [macro %"eif_eiffel.h%"]"
		alias
			"sizeof(EIF_INTEGER_64)"
		end;

	Float_size: INTEGER is
			-- Size of a float
		external
			"C [macro %"eif_eiffel.h%"]"
		alias
			"sizeof(EIF_REAL)"
		end;

	Double_size: INTEGER is
			-- Size of a double
		external
			"C [macro %"eif_eiffel.h%"]"
		alias
			"sizeof(EIF_DOUBLE)"
		end;

	Pointer_size: INTEGER is
			-- Size of a function pointer
		external
			"C [macro %"eif_eiffel.h%"]"
		alias
			"sizeof(char *(*)())"
		end;

	Reference_size: INTEGER is
			-- Size of a reference
		external
			"C [macro %"eif_eiffel.h%"]"
		alias
			"sizeof(EIF_REFERENCE)"
		end;

end
