indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class CHAR_I

inherit
	BASIC_I
		rename
			make as base_make
		redefine
			is_char,
			same_as, element_type, tuple_code,
			description, sk_value, hash_code,
			maximum_interval_value,
			minimum_interval_value
		end

create
	make

feature -- Initialization

	make (w: BOOLEAN) is
			-- Create instance of CHAR_I. If `w' a normal character.
			-- Otherwise a wide character.
		require
			has_compiled_character_class:
				not w implies (System.character_class /= Void and then
					System.character_class.is_compiled)
			has_compiled_wide_character_class:
				w implies (System.wide_char_class /= Void and then
					System.wide_char_class.is_compiled)
		do
			is_wide := w
			if w then
				base_make (System.wide_char_class.compiled_class.class_id)
			else
				base_make (System.character_class.compiled_class.class_id)
			end
		ensure
			is_wide_set: is_wide = w
		end

feature -- Property

	is_wide: BOOLEAN
			-- Is current character a wide one?

	is_char: BOOLEAN is True
			-- Is the type a char type ?

	element_type: INTEGER_8 is
			-- Pointer element type
		do
			if is_wide then
				Result := {MD_SIGNATURE_CONSTANTS}.element_type_u4
			else
				Result := {MD_SIGNATURE_CONSTANTS}.Element_type_char
			end
		end

	tuple_code: INTEGER_8 is
			-- Tuple code for class type
		do
			if is_wide then
				Result := {SHARED_GEN_CONF_LEVEL}.wide_character_tuple_code
			else
				Result := {SHARED_GEN_CONF_LEVEL}.character_tuple_code
			end
		end

	reference_type: CL_TYPE_I is
			-- Assocated reference type of Current.
		do
			if is_wide then
				create Result.make (system.wide_char_ref_class.compiled_class.class_id)
			else
				create Result.make (system.character_ref_class.compiled_class.class_id)
			end
		end

feature -- Access

	level: INTEGER is
			-- Internal code for generation
		do
			if is_wide then
				Result := C_wide_char
			else
				Result := C_char
			end
		end

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to `Current' ?
		local
			char: like Current
		do
			if other.is_char then
				char ?= other
				Result := is_wide = char.is_wide
			end
		end

	description: CHAR_DESC is
			-- Type description for skeleton
		do
			create Result.make (is_wide)
		end

	c_string: STRING is
			-- String generated for the type.
		do
			if is_wide then
				Result := Wide_char_string
			else
				Result := Character_string
			end
		end

	union_tag: STRING is
		do
			if is_wide then
				Result := Union_wide_char_tag
			else
				Result := Union_character_tag
			end
		end

	hash_code: INTEGER is
			-- Hash code for current type
		do
			if is_wide then
				Result := Wide_char_code
			else
				Result := Character_code
			end
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			if is_wide then
				Result := Sk_wchar
			else
				Result := Sk_char
			end
		end

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			if is_wide then
				buffer.put_string ("SK_WCHAR")
			else
				buffer.put_string ("SK_CHAR")
			end
		end

	type_a: CHARACTER_A is
		do
			create Result.make (is_wide)
		end

	generate_union (buffer: GENERATION_BUFFER) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `buffer'.
		do
			if is_wide then
				buffer.put_string ("it_wchar")
			else
				buffer.put_string ("it_char")
			end
		end

feature -- Code generation

	minimum_interval_value: CHAR_VAL_B is
			-- Minimum value in inspect interval for current type
		do
			create Result.make ('%/0/')
		end

	maximum_interval_value: CHAR_VAL_B is
			-- Maximum value in inspect interval for current type
		do
			create Result.make ({EIFFEL_SCANNER_SKELETON}.Maximum_character_code.to_character)
		end

	make_default_byte_code (ba: BYTE_ARRAY) is
			-- Generate default value of basic type on stack.
		do
			if is_wide then
				ba.append (Bc_wchar)
				ba.append_integer (0)
			else
				ba.append (Bc_char)
				ba.append ('%U')
			end
		end

feature {NONE} -- Constants

	Character_string: STRING is "EIF_CHARACTER"
	Wide_char_string: STRING is "EIF_WIDE_CHAR"

	Union_character_tag: STRING is "carg"
	Union_wide_char_tag: STRING is "wcarg";

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
