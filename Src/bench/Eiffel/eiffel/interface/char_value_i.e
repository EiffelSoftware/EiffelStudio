class CHAR_VALUE_I 

inherit
	VALUE_I
		redefine
			generate, is_character,
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
			buffer.putstring ("(EIF_CHARACTER) '");
			buffer.escape_char (buffer,character_value);
			buffer.putchar ('%'');
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

end
