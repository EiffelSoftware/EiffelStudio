class CHAR_DESC 

inherit

	ATTR_DESC
		redefine
			is_character
		end
	
feature 

	is_character: BOOLEAN is
			-- Is the attribute a character one ?
		do
			Result := True;
		end;

	level: INTEGER is
			-- Level comparison
		once
			Result := Character_level;
		end;

	generate_code (file: UNIX_FILE) is
			-- Generate type code for current attribute description in
			-- file `file'.
		do
			file.putstring ("SK_CHAR");
		end;

	sk_value: INTEGER is
			-- Sk value
		do
			Result := Sk_char
		end;

	trace is
		do
			io.error.putstring ("[CHARACTER]");
		end;

end
