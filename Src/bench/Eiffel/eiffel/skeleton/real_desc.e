class REAL_DESC 

inherit

	ATTR_DESC
		rename
			Real_level as level
		redefine
			is_real
		end
feature 

	is_real: BOOLEAN is True;
			-- Is the attribute a real one ?

	sk_value: INTEGER is
		do
			Result := Sk_float
		end

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			buffer.putstring ("SK_FLOAT");
		end;

	trace is
		do
			io.error.putstring (attribute_name);
			io.error.putstring ("[REAL]");
		end;

end
