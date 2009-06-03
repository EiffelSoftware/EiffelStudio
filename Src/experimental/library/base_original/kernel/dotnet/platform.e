note

	description: "[
		Platform-dependent properties.
		]"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class PLATFORM

feature -- Platform

	frozen is_thread_capable: BOOLEAN = True
			-- Is current platform capable of multi-threading?

	is_dotnet: BOOLEAN = True
			-- Are we targetting .NET?

	frozen is_windows: BOOLEAN
			-- Are we running on Windows platform?
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"EIF_IS_WINDOWS"
		end

	is_unix: BOOLEAN
			-- Are we running on a Unix like platform?
		once
			Result := not (is_vms or is_windows)
		end

	is_vms: BOOLEAN
			-- Are we running on VMS?
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"EIF_IS_VMS"
		end

	is_little_endian: BOOLEAN
			-- Is current platform a little endian one?
		once
			Result := {BIT_CONVERTER}.is_little_endian
		end

feature -- Access bytes size

	Boolean_bytes: INTEGER
			-- Number of bytes in a value of type `BOOLEAN'
		do
			Result := {MARSHAL}.size_of_object (True)
		end

	Character_bytes: INTEGER
			-- Number of bytes in a value of type `CHARACTER'.
		do
			Result := 1
		end
	
	Wide_character_bytes: INTEGER
			-- Number of bytes in a value of type `WIDE_CHARACTER'.
		do
			Result := 2
		end

	natural_8_bytes: INTEGER
			-- Number of bytes in a value of type `NATURAL_8'
		do
			Result := {MARSHAL}.size_of_object ((8).to_natural_8)
		end
		
	natural_16_bytes: INTEGER
			-- Number of bytes in a value of type `NATURAL_16'
		do
			Result := {MARSHAL}.size_of_object ((16).to_natural_16)
		end

	natural_32_bytes: INTEGER
			-- Number of bytes in a value of type `NATURAL_32'
		do
			Result := {MARSHAL}.size_of_object ((32).to_natural_32)
		end

	natural_64_bytes: INTEGER
			-- Number of bytes in a value of type `NATURAL_64'
		do
			Result := {MARSHAL}.size_of_object ((64).to_natural_64)
		end

	Integer_8_bytes: INTEGER
			-- Number of bytes in a value of type `INTEGER_8'
		do
			Result := {MARSHAL}.size_of_object ((8).to_integer_8)
		end
		
	Integer_16_bytes: INTEGER
			-- Number of bytes in a value of type `INTEGER_16'
		do
			Result := {MARSHAL}.size_of_object ((16).to_integer_16)
		end

	Integer_bytes, Integer_32_bytes: INTEGER
			-- Number of bytes in a value of type `INTEGER_32'
		do
			Result := {MARSHAL}.size_of_object (32)
		end

	Integer_64_bytes: INTEGER
			-- Number of bytes in a value of type `INTEGER_64'
		do
			Result := {MARSHAL}.size_of_object ((64).to_integer_64)
		end

	Real_32_bytes, Real_bytes: INTEGER
			-- Number of bytes in a value of type `REAL'
		do
			Result := {MARSHAL}.size_of_object ((0.0).truncated_to_real)
		end

	Real_64_bytes, Double_bytes: INTEGER
			-- Number of bytes in a value of type `DOUBLE'
		do
			Result := {MARSHAL}.size_of_object (0.0)
		end

	Pointer_bytes: INTEGER
			-- Number of bytes in a value of type `POINTER'
		do
			Result := {MARSHAL}.size_of_object (default_pointer)
		end

feature -- Access bits size

	Boolean_bits: INTEGER
			-- Number of bits in a value of type `BOOLEAN'
		do
			Result := Boolean_bytes * 8
		end

	Character_bits: INTEGER
			-- Number of bits in a value of type `CHARACTER'
		do
			Result := Character_bytes * 8
		end

	natural_8_bits: INTEGER
			-- Number of bits in a value of type `NATURAL_8'
		do
			Result := natural_8_bytes * 8
		end

	natural_16_bits: INTEGER
			-- Number of bits in a value of type `NATURAL_16'
		do
			Result := natural_16_bytes * 8
		end

	natural_32_bits: INTEGER
			-- Number of bits in a value of type `NATURAL_32'
		do
			Result := natural_32_bytes * 8
		end

	natural_64_bits: INTEGER
			-- Number of bits in a value of type `NATURAL_64'
		do
			Result := natural_64_bytes * 8
		end

	Integer_8_bits: INTEGER
			-- Number of bits in a value of type `INTEGER_8'
		do
			Result := Integer_8_bytes * 8
		end

	Integer_16_bits: INTEGER
			-- Number of bits in a value of type `INTEGER_16'
		do
			Result := Integer_16_bytes * 8
		end

	Integer_32_bits, Integer_bits: INTEGER
			-- Number of bits in a value of type `INTEGER_32'
		do
			Result := Integer_32_bytes * 8
		end

	Integer_64_bits: INTEGER
			-- Number of bits in a value of type `INTEGER_64'
		do
			Result := Integer_64_bytes * 8
		end

	Real_32_bits, Real_bits: INTEGER
			-- Number of bits in a value of type `REAL'
		do
			Result := Real_bytes * 8
		end

	Real_64_bits, Double_bits: INTEGER
			-- Number of bits in a value of type `DOUBLE'
		do
			Result := Double_bytes * 8
		end

	Pointer_bits: INTEGER
			-- Number of bits in a value of type `POINTER'
		do
			Result := Pointer_bytes * 8
		end

feature -- Access min max values

	Maximum_character_code: INTEGER
			-- Largest supported code for CHARACTER values
		do
			Result := {CHARACTER}.Max_value
		ensure
			meaningful: Result >= 127
		end

	Maximum_integer: INTEGER 
			-- Largest supported value of type INTEGER.
		do
			Result := {INTEGER}.Max_value
		ensure
			meaningful: Result >= 0
		end

	Minimum_character_code: INTEGER
			-- Smallest supported code for CHARACTER values
		do
			Result := {CHARACTER}.Min_value
		ensure
			meaningful: Result <= 0
		end

	Minimum_integer: INTEGER
			-- Smallest supported value of type INTEGER
		do
			Result := {INTEGER}.Min_value
		ensure
			meaningful: Result <= 0
		end

note
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


