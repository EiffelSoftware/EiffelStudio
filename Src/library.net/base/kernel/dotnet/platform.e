indexing

	description: "[
		Platform-dependent properties.
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class PLATFORM

feature -- Platform

	is_dotnet: BOOLEAN is True
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

feature -- Access bytes size

	Boolean_bytes: INTEGER is
			-- Number of bytes in a value of type `BOOLEAN'
		do
			Result := {MARSHAL}.size_of_object (True)
		end

	Character_bytes, Wide_character_bytes: INTEGER is
			-- Number of bytes in a value of type `CHARACTER' or `WIDE_CHARACTER'.
		do
			Result := 2
		end

	natural_8_bytes: INTEGER is
			-- Number of bytes in a value of type `NATURAL_8'
		do
			Result := {MARSHAL}.size_of_object ((8).to_natural_8)
		end
		
	natural_16_bytes: INTEGER is
			-- Number of bytes in a value of type `NATURAL_16'
		do
			Result := {MARSHAL}.size_of_object ((16).to_natural_16)
		end

	natural_32_bytes: INTEGER is
			-- Number of bytes in a value of type `NATURAL_32'
		do
			Result := {MARSHAL}.size_of_object ((32).to_natural_32)
		end

	natural_64_bytes: INTEGER is
			-- Number of bytes in a value of type `NATURAL_64'
		do
			Result := {MARSHAL}.size_of_object ((64).to_natural_64)
		end

	Integer_8_bytes: INTEGER is
			-- Number of bytes in a value of type `INTEGER_8'
		do
			Result := {MARSHAL}.size_of_object ((8).to_integer_8)
		end
		
	Integer_16_bytes: INTEGER is
			-- Number of bytes in a value of type `INTEGER_16'
		do
			Result := {MARSHAL}.size_of_object ((16).to_integer_16)
		end

	Integer_bytes, Integer_32_bytes: INTEGER is
			-- Number of bytes in a value of type `INTEGER_32'
		do
			Result := {MARSHAL}.size_of_object (32)
		end

	Integer_64_bytes: INTEGER is
			-- Number of bytes in a value of type `INTEGER_64'
		do
			Result := {MARSHAL}.size_of_object ((64).to_integer_64)
		end

	Real_bytes: INTEGER is
			-- Number of bytes in a value of type `REAL'
		do
			Result := {MARSHAL}.size_of_object ((0.0).truncated_to_real)
		end

	Double_bytes: INTEGER is
			-- Number of bytes in a value of type `DOUBLE'
		do
			Result := {MARSHAL}.size_of_object (0.0)
		end

	Pointer_bytes: INTEGER is
			-- Number of bytes in a value of type `POINTER'
		do
			Result := {MARSHAL}.size_of_object (default_pointer)
		end

feature -- Access bits size

	Boolean_bits: INTEGER is
			-- Number of bits in a value of type `BOOLEAN'
		do
			Result := Boolean_bytes * 8
		end

	Character_bits: INTEGER is
			-- Number of bits in a value of type `CHARACTER'
		do
			Result := Character_bytes * 8
		end

	natural_8_bits: INTEGER is
			-- Number of bits in a value of type `NATURAL_8'
		do
			Result := natural_8_bytes * 8
		end

	natural_16_bits: INTEGER is
			-- Number of bits in a value of type `NATURAL_16'
		do
			Result := natural_16_bytes * 8
		end

	natural_32_bits: INTEGER is
			-- Number of bits in a value of type `NATURAL_32'
		do
			Result := natural_32_bytes * 8
		end

	natural_64_bits: INTEGER is
			-- Number of bits in a value of type `NATURAL_64'
		do
			Result := natural_64_bytes * 8
		end

	Integer_8_bits: INTEGER is
			-- Number of bits in a value of type `INTEGER_8'
		do
			Result := Integer_8_bytes * 8
		end

	Integer_16_bits: INTEGER is
			-- Number of bits in a value of type `INTEGER_16'
		do
			Result := Integer_16_bytes * 8
		end

	Integer_32_bits, Integer_bits: INTEGER is
			-- Number of bits in a value of type `INTEGER_32'
		do
			Result := Integer_32_bytes * 8
		end

	Integer_64_bits: INTEGER is
			-- Number of bits in a value of type `INTEGER_64'
		do
			Result := Integer_64_bytes * 8
		end

	Real_bits: INTEGER is
			-- Number of bits in a value of type `REAL'
		do
			Result := Real_bytes * 8
		end

	Double_bits: INTEGER is
			-- Number of bits in a value of type `DOUBLE'
		do
			Result := Double_bytes * 8
		end

	Pointer_bits: INTEGER is
			-- Number of bits in a value of type `POINTER'
		do
			Result := Pointer_bytes * 8
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


