class CHAR_VALUE_I 

inherit

	VALUE_I
		redefine
			generate, is_character, is_propagation_equivalent,
			append_signature, string_value
		end
	CHARACTER_ROUTINES

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := char_val = other.char_val
		end

feature 

	char_val: CHARACTER;
			-- Integer constant value

	set_char_val (i: CHARACTER) is
			-- Assign `i' to `char_val'.
		do
			char_val := i;
		end;

	is_character: BOOLEAN is True
			-- Is the current constant a character one ?

	is_propagation_equivalent (other: CHAR_VALUE_I): BOOLEAN is
		do
			Result := same_type (other) and then char_val = other.char_val
		end;

	valid_type (t: TYPE_A): BOOLEAN is
			-- Is the current value compatible with `t' ?
		do
			Result := t.is_character;
		end;

	generate (buffer: GENERATION_BUFFER) is
			-- Generate value in `buffer'.
		do
			buffer.putstring ("(EIF_CHARACTER) '");
			buffer.escape_char (buffer,char_val);
			buffer.putchar ('%'');
		end;

	generate_il is
			-- Generate IL code for character constant value.
		do
			il_generator.put_character_constant (char_val)
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a character constant value.
		do
			ba.append (Bc_char);
			ba.append (char_val);
		end;

	vqmc: VQMC is
		do
			!VQMC2!Result;
		end;

	dump: STRING is
		do
			Result := char_val.out;
		end;

	append_signature (st: STRUCTURED_TEXT) is
		do
			st.add_char ('%'');
			st.add_string (char_text (char_val));
			st.add_char ('%'');
		end;

	string_value: STRING is
		do
			Result := char_text (char_val)
		end	

end
