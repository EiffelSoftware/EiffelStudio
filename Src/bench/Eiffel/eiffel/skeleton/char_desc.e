class CHAR_DESC 

inherit

	ATTR_DESC
		rename
			Character_level as level
		redefine
			is_character
		end
	
feature 

	is_character: BOOLEAN is True
			-- Is the attribute a character one ?

	sk_value: INTEGER is
		do
			Result := Sk_char
		end

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			buffer.putstring ("SK_CHAR");
		end;

	trace is
		do
			io.error.putstring (attribute_name);
			io.error.putstring ("[CHARACTER]");
		end;

end
