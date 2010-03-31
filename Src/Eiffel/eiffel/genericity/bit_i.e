note
	description: "C type for bits."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class BIT_I

inherit
	BASIC_I
		redefine
			is_bit,
			is_pointer,
			generate_typed_tag,
			generate_default_value
		end

create
	make

feature {NONE} -- Initialization

	make (count: like size)
			-- Initialize new instance of BIT_I with `count' bits
		do
			size := count
		ensure
			size_set: size = count
		end

feature -- Access

	size: NATURAL_32
			-- Bit size

	level: INTEGER
			-- Internal code for generation
		do
			Result := {SHARED_C_LEVEL}.C_ref
		end

	tuple_code: NATURAL_8
			-- Code for TUPLE type
		do
			Result := {SHARED_GEN_CONF_LEVEL}.reference_tuple_code
		end

	element_type: INTEGER_8
		do
			Result := {MD_SIGNATURE_CONSTANTS}.element_type_class
		end

	sk_value: NATURAL_32
		do
			Result := {SK_CONST}.sk_bit + size
		end

	c_string: STRING = "EIF_REFERENCE"
			-- String generated for the type.

	typed_field: STRING = "it_r"
			-- Value field of a C structure corresponding to this type

	hash_code: INTEGER
			-- Hash code for current type
		do
			Result := {SHARED_HASH_CODE}.bit_code | size.to_integer_32
			Result := Result.hash_code
		end

	new_attribute_description: BITS_DESC
			-- Type description for skeleton
		do
			create Result
			Result.set_size (size)
		end

feature -- Status report

	is_bit: BOOLEAN = True
			-- Is the type a long type ?

	is_pointer: BOOLEAN = True
			-- Is the type a pointer type ?

feature -- Byte code generation

	make_default_byte_code (ba: BYTE_ARRAY)
			-- Generate default value of basic type on stack.
		do
			ba.append ({BYTE_CONST}.Bc_create)
			ba.append ({BYTE_CONST}.Bc_bit)
			ba.append_natural_32 (size)
		end

feature -- C code generation

	generate_typed_tag (buffer: GENERATION_BUFFER)
			-- Generate tag of C structure "EIF_TYPED_VALUE" associated
			-- to the current C type in `buffer'.
		do
			buffer.put_string ("type = SK_REF")
		end

	generate_sk_value (buffer: GENERATION_BUFFER)
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.put_string ({SK_CONST}.sk_bit_string)
			buffer.put_three_character (' ', '+', ' ')
			buffer.put_string (uint32_string_cast)
			buffer.put_natural_32 (size)
		end

	generate_default_value (buffer : GENERATION_BUFFER)
			-- Generate default value associated to current basic type.
		do
			buffer.put_string ("RTLB(")
			buffer.put_natural_32 (size)
			buffer.put_character (')')
		end

feature {NONE} -- Constants

	uint32_string_cast: STRING = "(uint32) ";

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
