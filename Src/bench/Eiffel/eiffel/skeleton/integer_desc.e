class INTEGER_DESC 

inherit

	ATTR_DESC
		redefine
			is_integer
		end
	
feature 

	is_integer: BOOLEAN is True;
			-- is the attribute a character one ?

	level: INTEGER is
			-- level comparison
		once
			Result := Integer_level;
		end;

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			buffer.putstring ("SK_INT");
		end;

	sk_value: INTEGER is
			-- Sk value
		once
			Result := Sk_int
		end;

	trace is
		do
			io.error.putstring (attribute_name);
			io.error.putstring ("[INTEGER]");
		end;

end
