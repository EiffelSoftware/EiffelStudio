class REAL_DESC 

inherit

	ATTR_DESC
		redefine
			is_real
		end
feature 

	is_real: BOOLEAN is True;
			-- Is the attribute a real one ?

	level: INTEGER is
			-- level comparison
		once
			Result := Real_level;
		end;
		
	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			buffer.putstring ("SK_FLOAT");
		end;

	sk_value: INTEGER is
			-- Sk value
		once
			Result := Sk_float
		end;

	trace is
		do
			io.error.putstring (attribute_name);
			io.error.putstring ("[REAL]");
		end;

end
