-- Internal representation of class BOOLEAN

class BOOLEAN_B 

inherit
	CLASS_B
		redefine
			actual_type, generate_cecil_value, cecil_value
		end

creation
	make
	
feature 

	actual_type: BOOLEAN_A is
			-- Actual boolean type
		once
			Result := Boolean_type
		end;

	generate_cecil_value is
			-- Generate Cecil type value
		do
			generation_buffer.putstring ("SK_BOOL");
		end;

	cecil_value: INTEGER is
			-- Cecil value
		do
			Result := Sk_bool
		end;

end
