class BOOLEAN_DESC 

inherit
	ATTR_DESC
		redefine
			is_boolean
		end
	
feature 

	is_boolean: BOOLEAN is True
			-- Is the attribute a boolean one ?

	level: INTEGER is
			-- Level comparison
		once
			Result := Boolean_level;
		end;

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			buffer.putstring ("SK_BOOL");
		end;

	sk_value: INTEGER is
			-- Sk value
		do
			Result := Sk_bool
		end;

	trace is
		do
			io.error.putstring (attribute_name);
			io.error.putstring ("[BOOLEAN]");
		end;

end
