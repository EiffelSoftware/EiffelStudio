class POINTER_DESC 

inherit

	ATTR_DESC
		rename
			Pointer_level as level
		redefine
			is_pointer
		end
	
feature 

	is_pointer: BOOLEAN is True;
			-- is the attribute a pointer one ?

	sk_value: INTEGER is
		do
			Result := Sk_pointer
		end

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			buffer.putstring ("SK_POINTER");
		end;

	trace is
		do
			io.error.putstring (attribute_name);
			io.error.putstring ("[POINTER]");
		end;

end
