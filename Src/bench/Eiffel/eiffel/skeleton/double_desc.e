class DOUBLE_DESC 

inherit

	ATTR_DESC
		redefine
			is_double
		end
	
feature 

	is_double: BOOLEAN is True;
			-- Is the attribute a double one ?

	level: INTEGER is
			-- Level comparison
		once
			Result := Double_level;
		end;

	generate_code (file: UNIX_FILE) is
			-- Generate type code for current attribute description in
			-- file `file'.
		do
			file.putstring ("SK_DOUBLE");
		end;

	sk_value: INTEGER is
			-- Sk value
		once
			Result := Sk_double
		end;

	trace is
		do
			io.error.putstring (attribute_name);
			io.error.putstring ("[DOUBLE]");
		end;

end
