indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."

class CHAR_VALUE_I

inherit
	VALUE_I
		redefine
			generate, is_character, inspect_value,
			append_signature, string_value
		end

	CHARACTER_ROUTINES

	SHARED_TYPES
		export
			{NONE} all
		end

create
	make_character_8,
	make_character_32

feature {NONE} -- Initialization

	make_character_8 (v: CHARACTER_8) is
			-- Create current with value `v'.
		do
			character_value := v
			is_character_32 := False
		ensure
			character_value_set: character_value = v
			is_character_8: is_character_8
		end

	make_character_32 (v: CHARACTER_32) is
			-- Create current with value `v'.
		do
			character_value := v
			is_character_32 := True
		ensure
			character_value_set: character_value = v
			is_character_32: is_character_32
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := character_value = other.character_value and then
				is_character_8 = other.is_character_8
		end

feature

	character_value: CHARACTER_32
			-- Character constant value

	is_character: BOOLEAN is True
			-- Is the current constant a character one?

	is_character_8: BOOLEAN is
			-- Is it CHARACTER_8 constant?
		do
			Result := not is_character_32
		end

	is_character_32: BOOLEAN
			-- Is it CHARACTER_32 constant?

	valid_type (t: TYPE_A): BOOLEAN is
			-- Is the current value compatible with `t' ?
		local
			c: CHARACTER_A
		do
			if t.is_character then
				c ?= t
				check
					attached_c: c /= Void
				end
				Result := is_character_8 or else c.is_character_32
			end
		end

	generate (buffer: GENERATION_BUFFER) is
			-- Generate value in `buffer'.
		do
			if is_character_32 then
				wide_char_type.c_type.generate_cast (buffer)
				buffer.put_natural_32 (character_value.natural_32_code)
				buffer.put_character ('U')
			else
				character_type.c_type.generate_cast (buffer)
				buffer.put_character_literal (character_value.to_character_8)
			end
		end

	generate_il is
			-- Generate IL code for character constant value.
		do
			if is_character_8 then
				il_generator.put_character_constant (character_value.to_character_8)
			else
				il_generator.put_natural_32_constant (character_value.natural_32_code)
			end
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a character constant value.
		do
			if is_character_8 then
				ba.append (Bc_char)
				ba.append (character_value.to_character_8)
			else
				ba.append (Bc_wchar)
				ba.append_character_32 (character_value)
			end
		end

	dump: STRING is
		do
			Result := character_value.out
		end

	append_signature (a_text_formatter: TEXT_FORMATTER) is
		do
			a_text_formatter.add_char ('%'')
			a_text_formatter.add_string (wchar_text (character_value))
			a_text_formatter.add_char ('%'')
		end

	string_value: STRING is
		do
			Result := wchar_text (character_value)
		end

feature -- Multi-branch instruction processing

	inspect_value (value_type: TYPE_A): CHAR_VAL_B is
			-- Inspect value of the given `value_type'
		do
			create Result.make (character_value)
		end

invariant
	consistent_type: is_character_8 xor is_character_32

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
