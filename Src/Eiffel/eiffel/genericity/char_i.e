indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class CHAR_I

inherit
	BASIC_I
		rename
			make as base_make
		redefine
			is_char, is_character_8, is_character_32,
			element_type, tuple_code,
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
				not w implies (System.character_8_class /= Void and then
					System.character_8_class.is_compiled)
			has_compiled_wide_character_class:
				w implies (System.character_32_class /= Void and then
					System.character_32_class.is_compiled)
		do
			is_character_32 := w
			if w then
				base_make (System.character_32_class.compiled_class.class_id)
			else
				base_make (System.character_8_class.compiled_class.class_id)
			end
		ensure
			is_character_32_set: is_character_32 = w
		end

feature -- Property

	is_character_32: BOOLEAN
			-- Is the type a CHARACTER_32 type?

	is_char: BOOLEAN is True
			-- Is the type a char type ?

	is_character_8: BOOLEAN is
			-- Is the type a CHARACTER_8 type?
		do
			Result := not is_character_32
		end

	element_type: INTEGER_8 is
			-- Pointer element type
		do
			if is_character_32 then
				Result := {MD_SIGNATURE_CONSTANTS}.element_type_u4
			else
				Result := {MD_SIGNATURE_CONSTANTS}.Element_type_char
			end
		end

	tuple_code: INTEGER_8 is
			-- Tuple code for class type
		do
			if is_character_32 then
				Result := {SHARED_GEN_CONF_LEVEL}.wide_character_tuple_code
			else
				Result := {SHARED_GEN_CONF_LEVEL}.character_tuple_code
			end
		end

	reference_type: CL_TYPE_I is
			-- Assocated reference type of Current.
		do
			if is_character_32 then
				create Result.make (system.character_32_ref_class.compiled_class.class_id)
			else
				create Result.make (system.character_8_ref_class.compiled_class.class_id)
			end
		end

feature -- Access

	level: INTEGER is
			-- Internal code for generation
		do
			if is_character_32 then
				Result := C_wide_char
			else
				Result := C_char
			end
		end

	description: CHAR_DESC is
			-- Type description for skeleton
		do
			create Result.make (is_character_32)
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

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			if is_character_32 then
				Result := Sk_wchar
			else
				Result := Sk_char
			end
		end

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			if is_character_32 then
				buffer.put_string ("SK_WCHAR")
			else
				buffer.put_string ("SK_CHAR")
			end
		end

	type_a: CHARACTER_A is
		do
			if is_character_32 then
				Result := wide_char_type
			else
				Result := character_type
			end
		end

	generate_typed_tag (buffer: GENERATION_BUFFER) is
			-- Generate tag of C structure "EIF_TYPED_VALUE" associated
			-- to the current C type in `buffer'.
		do
			if is_character_32 then
				buffer.put_string ("type = SK_WCHAR")
			else
				buffer.put_string ("type = SK_CHAR")
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
			if is_character_32 then
				create Result.make ({CHARACTER_32}.max_value.to_character_32)
			else
				create Result.make ({CHARACTER_8}.Max_value.to_character_8)
			end
		end

	make_default_byte_code (ba: BYTE_ARRAY) is
			-- Generate default value of basic type on stack.
		do
			if is_character_32 then
				ba.append (Bc_wchar)
				ba.append_integer (0)
			else
				ba.append (Bc_char)
				ba.append ('%U')
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
