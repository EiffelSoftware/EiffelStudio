class BOOLEAN_DESC 

inherit

	CHAR_DESC
		redefine
			is_boolean, is_character, generate_code, sk_value
		end
	
feature 

	is_boolean: BOOLEAN is True
			-- Is the attribute a boolean one ?

	is_character: BOOLEAN is
			-- Is the attribute a character one ?
		do
			-- Do nothing
		end;

	generate_code (file: INDENT_FILE) is
			-- Generate type code for current attribute description in
			-- file `file'.
		do
			file.putstring ("SK_BOOL");
		end;

	sk_value: INTEGER is
			-- Sk value
		do
			Result := Sk_bool
		end;

end
