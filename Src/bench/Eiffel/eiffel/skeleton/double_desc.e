class DOUBLE_DESC 

inherit

	ATTR_DESC
		rename
			Double_level as level
		redefine
			is_double
		end
	
feature 

	is_double: BOOLEAN is True;
			-- Is the attribute a double one ?

	sk_value: INTEGER is
		do
			Result := Sk_double
		end

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			buffer.putstring ("SK_DOUBLE");
		end;

	trace is
		do
			io.error.putstring (attribute_name);
			io.error.putstring ("[DOUBLE]");
		end;

end
