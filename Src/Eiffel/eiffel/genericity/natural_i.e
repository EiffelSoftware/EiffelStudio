indexing
	description: "C type for integers."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class NATURAL_I

inherit
	BASIC_I
		redefine
			generate_conversion_to_real_64,
			generate_conversion_to_real_32
		end

	SHARED_INCLUDE
		export
			{NONE} all
		undefine
			is_equal
		end

create
	make

feature -- Initialization

	make (n: INTEGER) is
			-- Create instance of LONG_I represented by `n' bits.
		require
			valid_n: n = 8 or n = 16 or n = 32 or n = 64
		do
			size := n.to_integer_8
		ensure
			size_set: size = n
		end

feature -- Access

	size: INTEGER_8
			-- Current is stored on `size' bits.

	level: INTEGER is
			-- Internal code for generation
		do
			inspect size
			when 8 then Result := {SHARED_C_LEVEL}.C_uint8
			when 16 then Result := {SHARED_C_LEVEL}.C_uint16
			when 32 then Result := {SHARED_C_LEVEL}.C_uint32
			when 64 then Result := {SHARED_C_LEVEL}.C_uint64
			end
		end

	tuple_code: NATURAL_8 is
			-- Tuple code for class type
		do
			inspect
				size
			when 8 then Result := {SHARED_GEN_CONF_LEVEL}.natural_8_tuple_code
			when 16 then Result := {SHARED_GEN_CONF_LEVEL}.natural_16_tuple_code
			when 32 then Result := {SHARED_GEN_CONF_LEVEL}.natural_32_tuple_code
			when 64 then Result := {SHARED_GEN_CONF_LEVEL}.natural_64_tuple_code
			end
		end

	element_type: INTEGER_8 is
		do
			inspect size
			when 8 then Result := {MD_SIGNATURE_CONSTANTS}.Element_type_u1
			when 16 then Result := {MD_SIGNATURE_CONSTANTS}.Element_type_u2
			when 32 then Result := {MD_SIGNATURE_CONSTANTS}.Element_type_u4
			when 64 then Result := {MD_SIGNATURE_CONSTANTS}.Element_type_u8
			end
		end

	sk_value: INTEGER is
		do
			inspect size
			when 8 then Result := {SK_CONST}.Sk_uint8
			when 16 then Result := {SK_CONST}.Sk_uint16
			when 32 then Result := {SK_CONST}.Sk_uint32
			when 64 then Result := {SK_CONST}.Sk_uint64
			end
		end

	c_string: STRING is
			-- String generated for the type.
		do
			inspect size
			when 8 then Result := String_natural_8
			when 16 then Result := String_natural_16
			when 32 then Result := String_natural_32
			when 64 then Result := String_natural_64
			end
		end

	typed_field: STRING is
			-- Value field of a C structure corresponding to this type
		do
			Result := "it_n"
			Result.append_integer (size // 8)
		end

	hash_code: INTEGER is
			-- Hash code for current type
		do
			inspect size
			when 8 then Result := {SHARED_HASH_CODE}.natural_8_code
			when 16 then Result := {SHARED_HASH_CODE}.natural_16_code
			when 32 then Result := {SHARED_HASH_CODE}.natural_32_code
			when 64 then Result := {SHARED_HASH_CODE}.natural_64_code
			end
		end

	new_attribute_description: NATURAL_DESC is
			-- Type description for skeleton
		do
			create Result.make (size)
		end

feature -- Byte code generation

	make_default_byte_code (ba: BYTE_ARRAY) is
			-- Generate default value of basic type on stack.
		do
			inspect size
			when 8 then
				ba.append ({BYTE_CONST}.Bc_uint8)
				ba.append_natural_8 (0)
			when 16 then
				ba.append ({BYTE_CONST}.Bc_uint16)
				ba.append_natural_16 (0)
			when 32 then
				ba.append ({BYTE_CONST}.Bc_uint32)
				ba.append_natural_32 (0)
			when 64 then
				ba.append ({BYTE_CONST}.Bc_uint64)
				ba.append_natural_64 (0)
			end
		end

feature -- C code generation

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		local
			l_string: STRING
		do
			inspect size
			when 8 then l_string := {SK_CONST}.sk_uint8_string
			when 16 then l_string := {SK_CONST}.sk_uint16_string
			when 32 then l_string := {SK_CONST}.sk_uint32_string
			when 64 then l_string := {SK_CONST}.sk_uint64_string
			end
			buffer.put_string (l_string)
		end

	generate_conversion_to_real_64 (buffer: GENERATION_BUFFER) is
			-- Generate conversion to `REAL_64', needed because
			-- for some descendants, it is not enough to just to a cast to EIF_REAL_64.
		do
			if size = 64 then
				shared_include_queue.put ({PREDEFINED_NAMES}.eif_helpers_header_name_id)
				buffer.put_string ("eif_uint64_to_real64 (")
			else
				buffer.put_string ("(EIF_REAL_64) (")
			end
		end

	generate_conversion_to_real_32 (buffer: GENERATION_BUFFER) is
			-- Generate conversion to `REAL_32', needed because
			-- for some descendants, it is not enough to just to a cast to EIF_REAL_32.
		do
			if size = 64 then
				shared_include_queue.put ({PREDEFINED_NAMES}.eif_helpers_header_name_id)
				buffer.put_string ("eif_uint64_to_real32 (")
			else
				buffer.put_string ("(EIF_REAL_32) (")
			end
		end

feature {NONE} -- Constants for generation

	String_natural_8: STRING is "EIF_NATURAL_8"
	String_natural_16: STRING is "EIF_NATURAL_16"
	String_natural_32: STRING is "EIF_NATURAL_32"
	String_natural_64: STRING is "EIF_NATURAL_64"

invariant
	correct_size: size = 8 or size = 16 or size = 32 or size = 64

indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
