class CHAR_DESC 

inherit

	ATTR_DESC
		redefine
			is_character
		end
	
feature 

	is_character: BOOLEAN is True
			-- Is the attribute a character one ?

	level: INTEGER is
			-- Level comparison
		once
			Result := Character_level;
		end;

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			buffer.putstring ("SK_CHAR");
		end;

	sk_value: INTEGER is
			-- Sk value
		do
			Result := Sk_char
		end;

	trace is
		do
			io.error.putstring (attribute_name);
			io.error.putstring ("[CHARACTER]");
		end;

end
