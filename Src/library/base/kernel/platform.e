indexing

	description: "[
		Platform-dependent properties.
		This class is an ancestor to all developer-written classes.
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class PLATFORM

feature -- Access bytes size

	Boolean_bytes: INTEGER is
			-- Number of bytes in a value of type `BOOLEAN'
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"sizeof(EIF_BOOLEAN)"
		end

	Character_bytes: INTEGER is
			-- Number of bytes in a value of type `CHARACTER'
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"sizeof(EIF_CHARACTER)"
		end

	Wide_character_bytes: INTEGER is
			-- Number of bytes in a value of type `WIDE_CHARACTER'
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"sizeof(EIF_WIDE_CHAR)"
		end

	Integer_8_bytes: INTEGER is
			-- Number of bytes in a value of type `INTEGER_8'
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"sizeof(EIF_INTEGER_8)"
		end

	Integer_16_bytes: INTEGER is
			-- Number of bytes in a value of type `INTEGER_16'
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"sizeof(EIF_INTEGER_16)"
		end

	Integer_bytes: INTEGER is
			-- Number of bytes in a value of type `INTEGER'
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"sizeof(EIF_INTEGER)"
		end

	Integer_64_bytes: INTEGER is
			-- Number of bytes in a value of type `INTEGER_64'
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"sizeof(EIF_INTEGER_64)"
		end

	Real_bytes: INTEGER is
			-- Number of bytes in a value of type `REAL'
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"sizeof(EIF_REAL)"
		end

	Double_bytes: INTEGER is
			-- Number of bytes in a value of type `DOUBLE'
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"sizeof(EIF_DOUBLE)"
		end

	Pointer_bytes: INTEGER is
			-- Number of bytes in a value of type `POINTER'
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"sizeof(EIF_POINTER)"
		end

feature -- Access bits size

	Boolean_bits: INTEGER is
			-- Number of bits in a value of type `BOOLEAN'
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"esbool_size"
		end

	Character_bits: INTEGER is
			-- Number of bits in a value of type `CHARACTER'
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"eschar_size"
		end

	Integer_bits: INTEGER is
			-- Number of bits in a value of type `INTEGER'
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"esint_size"
		end

	Real_bits: INTEGER is
			-- Number of bits in a value of type `REAL'
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"esreal_size"
		end

	Double_bits: INTEGER is
			-- Number of bits in a value of type `DOUBLE'
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"esdouble_size"
		end

	Pointer_bits: INTEGER is
			-- Number of bits in a value of type `POINTER'
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"esptr_size"
		end

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class PLATFORM


