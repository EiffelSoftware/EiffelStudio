class INTEGER_DESC 

inherit

	ATTR_DESC
		rename
			Integer_level as level
		redefine
			is_integer
		end
	
feature 

	is_integer: BOOLEAN is True;
			-- is the attribute a character one ?

	sk_value: INTEGER is
		do
			Result := Sk_int
		end

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			buffer.putstring ("SK_INT");
		end;

	trace is
		do
			io.error.putstring (attribute_name);
			io.error.putstring ("[INTEGER]");
		end;

end
