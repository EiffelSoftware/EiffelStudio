class CHAR_VALUE_I 

inherit

	VALUE_I
		redefine
			generate, is_character, equiv,
			append_clickable_signature
		end
	
feature 

	char_val: CHARACTER;
			-- Integer constant value

	set_char_val (i: CHARACTER) is
			-- Assign `i' to `char_val'.
		do
			char_val := i;
		end;

	is_character: BOOLEAN is
			-- Is the current constant a character one ?
		do
			Result := True;
		end;

	equiv (other: CHAR_VALUE_I): BOOLEAN is
		do
			Result := char_val = other.char_val
		end;

	valid_type (t: TYPE_A): BOOLEAN is
			-- Is the current value compatible with `t' ?
		do
			Result := t.is_character;
		end;

	generate (file: INDENT_FILE) is
			-- Generate value in `file'.
		do
			file.putchar ('%'');
			file.escape_char (char_val);
			file.putchar ('%'');
		end;

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

	append_clickable_signature (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_char ('%'');
--FIXME
-- %N, ...
			a_clickable.put_char (char_val);
			a_clickable.put_char ('%'');
		end;

end
