class REFERENCE_DESC 

inherit

	ATTR_DESC
		redefine
			is_reference
		end
	
feature 

	is_reference: BOOLEAN is True;
			-- Is the attribute a reference ?

	level: INTEGER is
			-- Level descritpion
		once
			Result := Reference_level;
		end;

	generate_code (file: UNIX_FILE) is
			-- Generate type code for current attribute description in
			-- file `file'.
		do
			file.putstring ("SK_REF");
		end;

	sk_value: INTEGER is
			-- Sk value
		once
			Result := Sk_ref
		end;

	trace is
		do
			io.error.putstring (attribute_name);
			io.error.putstring ("[REFERENCE]");
		end;

end
