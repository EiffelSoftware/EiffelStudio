class BOOLEAN_DESC 

inherit
	ATTR_DESC
		rename
			Boolean_level as level
		redefine
			is_boolean
		end
	
feature 

	is_boolean: BOOLEAN is True
			-- Is the attribute a boolean one ?

	sk_value: INTEGER is
		do
			Result := Sk_bool
		end

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			buffer.putstring ("SK_BOOL");
		end;

	trace is
		do
			io.error.putstring (attribute_name);
			io.error.putstring ("[BOOLEAN]");
		end;

end
