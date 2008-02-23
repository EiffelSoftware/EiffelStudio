indexing
	description: "C type for characters."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CHAR_I

inherit
	BASIC_I

create
	make

feature -- Initialization

	make (w: BOOLEAN) is
			-- Create instance of CHAR_I. If `w' a normal character.
			-- Otherwise a wide character.
		do
			is_character_32 := w
		ensure
			is_character_32_set: is_character_32 = w
		end

feature -- Access

	level: INTEGER is
			-- Internal code for generation
		do
			if is_character_32 then
				Result := {SHARED_C_LEVEL}.C_wide_char
			else
				Result := {SHARED_C_LEVEL}.C_char
			end
		end

	tuple_code: NATURAL_8 is
			-- Code for TUPLE type
		do
			if is_character_32 then
				Result := {SHARED_GEN_CONF_LEVEL}.wide_character_tuple_code
			else
				Result := {SHARED_GEN_CONF_LEVEL}.character_tuple_code
			end
		end

	element_type: INTEGER_8 is
		do
			if is_character_32 then
				Result := {MD_SIGNATURE_CONSTANTS}.element_type_u4
			else
				Result := {MD_SIGNATURE_CONSTANTS}.Element_type_char
			end
		end

	sk_value: INTEGER is
		do
			if is_character_32 then
				Result := {SK_CONST}.sk_wchar
			else
				Result := {SK_CONST}.sk_char
			end
		end

	c_string: STRING is
			-- String generated for the type.
		do
			if is_character_32 then
				Result := Wide_char_string
			else
				Result := Character_string
			end
		end

	typed_field: STRING is
			-- Value field of a C structure corresponding to this type
		do
			if is_character_32 then
				Result := "it_c4"
			else
				Result := "it_c1"
			end
		end

	hash_code: INTEGER is
			-- Hash code for current type
		do
			if is_character_32 then
				Result := {SHARED_HASH_CODE}.wide_char_code
			else
				Result := {SHARED_HASH_CODE}.character_code
			end
		end

	new_attribute_description: CHAR_DESC is
			-- Type description for skeleton
		do
			create Result.make (is_character_32)
		end

feature -- Status report

	is_character_32: BOOLEAN
			-- Is current representing a CHARACTER_32?

feature -- Byte code generation

	make_default_byte_code (ba: BYTE_ARRAY) is
			-- Generate default value of basic type on stack.
		do
			if is_character_32 then
				ba.append ({BYTE_CONST}.Bc_wchar)
				ba.append_integer (0)
			else
				ba.append ({BYTE_CONST}.Bc_char)
				ba.append ('%U')
			end
		end

feature -- C code generation

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			if is_character_32 then
				buffer.put_string ({SK_CONST}.sk_wchar_string)
			else
				buffer.put_string ({SK_CONST}.sk_char_string)
			end
		end

feature {NONE} -- Constants

	Character_string: STRING is "EIF_CHARACTER"
	Wide_char_string: STRING is "EIF_WIDE_CHAR";

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
