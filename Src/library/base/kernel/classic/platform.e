indexing

	description: "[
		Platform-dependent properties.
		]"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class PLATFORM

feature -- Platform

	frozen is_thread_capable: BOOLEAN is
			-- Is current platform capable of multi-threading?
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"EIF_THREADS_SUPPORTED"
		end

	is_dotnet: BOOLEAN is False
			-- Are we targetting .NET?

	is_windows: BOOLEAN is
			-- Are we running on Windows platform?
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"EIF_IS_WINDOWS"
		end

	is_unix: BOOLEAN is
			-- Are we running on a Unix like platform?
		once
			Result := not (is_vms or is_windows)
		end

	is_vms: BOOLEAN is
			-- Are we running on VMS?
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"EIF_IS_VMS"
		end

	is_little_endian: BOOLEAN is
			-- Is current platform a little endian one?
		external
			"C inline"
		alias
			"EIF_TEST(BYTEORDER == 0x1234)"
		end

feature -- Access bytes size

	Boolean_bytes: INTEGER is
			-- Number of bytes in a value of type `BOOLEAN'
		external
			"C macro use %"eif_misc.h%""
		alias
			"sizeof(EIF_BOOLEAN)"
		end

	Character_bytes: INTEGER is
			-- Number of bytes in a value of type `CHARACTER'
		external
			"C macro use %"eif_misc.h%""
		alias
			"sizeof(EIF_CHARACTER)"
		end

	Wide_character_bytes: INTEGER is
			-- Number of bytes in a value of type `WIDE_CHARACTER'
		external
			"C macro use %"eif_misc.h%""
		alias
			"sizeof(EIF_WIDE_CHAR)"
		end

	Natural_8_bytes: INTEGER is
			-- Number of bytes in a value of type `INTEGER_8'
		external
			"C macro use %"eif_misc.h%""
		alias
			"sizeof(EIF_NATURAL_8)"
		end

	Natural_16_bytes: INTEGER is
			-- Number of bytes in a value of type `INTEGER_16'
		external
			"C macro use %"eif_misc.h%""
		alias
			"sizeof(EIF_NATURAL_16)"
		end

	Natural_32_bytes: INTEGER is
			-- Number of bytes in a value of type `INTEGER'
		external
			"C macro use %"eif_misc.h%""
		alias
			"sizeof(EIF_NATURAL_32)"
		end

	Natural_64_bytes: INTEGER is
			-- Number of bytes in a value of type `INTEGER_64'
		external
			"C macro use %"eif_misc.h%""
		alias
			"sizeof(EIF_NATURAL_64)"
		end

	Integer_8_bytes: INTEGER is
			-- Number of bytes in a value of type `INTEGER_8'
		external
			"C macro use %"eif_misc.h%""
		alias
			"sizeof(EIF_INTEGER_8)"
		end

	Integer_16_bytes: INTEGER is
			-- Number of bytes in a value of type `INTEGER_16'
		external
			"C macro use %"eif_misc.h%""
		alias
			"sizeof(EIF_INTEGER_16)"
		end

	Integer_32_bytes, Integer_bytes: INTEGER is
			-- Number of bytes in a value of type `INTEGER'
		external
			"C macro use %"eif_misc.h%""
		alias
			"sizeof(EIF_INTEGER_32)"
		end

	Integer_64_bytes: INTEGER is
			-- Number of bytes in a value of type `INTEGER_64'
		external
			"C macro use %"eif_misc.h%""
		alias
			"sizeof(EIF_INTEGER_64)"
		end

	Real_32_bytes, Real_bytes: INTEGER is
			-- Number of bytes in a value of type `REAL'
		external
			"C macro use %"eif_misc.h%""
		alias
			"sizeof(EIF_REAL_32)"
		end

	Real_64_bytes, Double_bytes: INTEGER is
			-- Number of bytes in a value of type `DOUBLE'
		external
			"C macro use %"eif_misc.h%""
		alias
			"sizeof(EIF_REAL_64)"
		end

	Pointer_bytes: INTEGER is
			-- Number of bytes in a value of type `POINTER'
		external
			"C macro use %"eif_misc.h%""
		alias
			"sizeof(EIF_POINTER)"
		end

feature -- Access bits size

	Boolean_bits: INTEGER is
			-- Number of bits in a value of type `BOOLEAN'
		external
			"C macro use %"eif_misc.h%""
		alias
			"esbool_size"
		end

	Character_bits: INTEGER is
			-- Number of bits in a value of type `CHARACTER'
		external
			"C macro use %"eif_misc.h%""
		alias
			"eschar_size"
		end

	Natural_8_bits: INTEGER is
		external
			"C macro use %"eif_misc.h%""
		alias
			"esuint8_size"
		end

	Natural_16_bits: INTEGER is
		external
			"C macro use %"eif_misc.h%""
		alias
			"esuint16_size"
		end

	Natural_32_bits: INTEGER is
			-- Number of bits in a value of type `INTEGER'
		external
			"C macro use %"eif_misc.h%""
		alias
			"esuint32_size"
		end

	Natural_64_bits: INTEGER is
		external
			"C macro use %"eif_misc.h%""
		alias
			"esuint64_size"
		end

	Integer_8_bits: INTEGER is
		external
			"C macro use %"eif_misc.h%""
		alias
			"esint8_size"
		end

	Integer_16_bits: INTEGER is
		external
			"C macro use %"eif_misc.h%""
		alias
			"esint16_size"
		end

	Integer_32_bits, Integer_bits: INTEGER is
			-- Number of bits in a value of type `INTEGER'
		external
			"C macro use %"eif_misc.h%""
		alias
			"esint32_size"
		end

	Integer_64_bits: INTEGER is
		external
			"C macro use %"eif_misc.h%""
		alias
			"esint64_size"
		end

	Real_32_bits, Real_bits: INTEGER is
			-- Number of bits in a value of type `REAL'
		external
			"C macro use %"eif_misc.h%""
		alias
			"esreal32_size"
		end

	Real_64_bits, Double_bits: INTEGER is
			-- Number of bits in a value of type `DOUBLE'
		external
			"C macro use %"eif_misc.h%""
		alias
			"esreal64_size"
		end

	Pointer_bits: INTEGER is
			-- Number of bits in a value of type `POINTER'
		external
			"C macro use %"eif_misc.h%""
		alias
			"esptr_size"
		end

feature -- Access min max values

	Maximum_character_code: INTEGER is
			-- Largest supported code for CHARACTER values
		do
			Result := {CHARACTER}.Max_value
		ensure
			meaningful: Result >= 127
		end

	Maximum_integer: INTEGER is
			-- Largest supported value of type INTEGER.
		do
			Result := {INTEGER}.Max_value
		ensure
			meaningful: Result >= 0
		end

	Minimum_character_code: INTEGER is
			-- Smallest supported code for CHARACTER values
		do
			Result := {CHARACTER}.Min_value
		ensure
			meaningful: Result <= 0
		end

	Minimum_integer: INTEGER is
			-- Smallest supported value of type INTEGER
		do
			Result := {INTEGER}.Min_value
		ensure
			meaningful: Result <= 0
		end

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"







end -- class PLATFORM


