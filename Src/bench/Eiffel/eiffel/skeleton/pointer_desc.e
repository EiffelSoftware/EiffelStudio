class POINTER_DESC 

inherit

	ATTR_DESC
		redefine
			is_pointer
		end
	
feature 

	is_pointer: BOOLEAN is True;
			-- is the attribute a pointer one ?

	level: INTEGER is
			-- level comparison
		once
			Result := Pointer_level;
		end;

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			buffer.putstring ("SK_POINTER");
		end;

	sk_value: INTEGER is
			-- Sk value
		once
			Result := Sk_pointer
		end;

	trace is
		do
			io.error.putstring (attribute_name);
			io.error.putstring ("[POINTER]");
		end;

end
