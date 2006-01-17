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

create
	make

feature {NONE} -- Initialization

	make (v: CHARACTER) is
			-- Create current with value `v'.
		do
			character_value := v
		ensure
			character_value_set: character_value = v
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := character_value = other.character_value
		end

feature 

	character_value: CHARACTER;
			-- Integer constant value

	is_character: BOOLEAN is True
			-- Is the current constant a character one ?

	valid_type (t: TYPE_A): BOOLEAN is
			-- Is the current value compatible with `t' ?
		do
			Result := t.is_character;
		end;

	generate (buffer: GENERATION_BUFFER) is
			-- Generate value in `buffer'.
		do
			buffer.put_string ("(EIF_CHARACTER) '");
			buffer.escape_char (character_value);
			buffer.put_character ('%'');
		end;

	generate_il is
			-- Generate IL code for character constant value.
		do
			il_generator.put_character_constant (character_value)
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a character constant value.
		do
			ba.append (Bc_char);
			ba.append (character_value);
		end;

	dump: STRING is
		do
			Result := character_value.out;
		end;

	append_signature (st: STRUCTURED_TEXT) is
		do
			st.add_char ('%'');
			st.add_string (char_text (character_value));
			st.add_char ('%'');
		end;

	string_value: STRING is
		do
			Result := char_text (character_value)
		end	

feature -- Multi-branch instruction processing

	inspect_value (value_type: TYPE_A): CHAR_VAL_B is
			-- Inspect value of the given `value_type'
		do
			create Result.make (character_value)
		end

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
