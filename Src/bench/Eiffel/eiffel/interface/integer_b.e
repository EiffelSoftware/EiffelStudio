-- Internal representation of class INTEGER

class INTEGER_B 

inherit
	CLASS_B
		redefine
			actual_type, generate_cecil_value, cecil_value
		end

creation
	make
	
feature 

	actual_type: INTEGER_A is
			-- Actual integer type
		once
			Result := Integer_type;
		end;

	generate_cecil_value is
			-- Generate Cecil type value
		do
			generation_buffer.putstring ("SK_INT");
		end;

	cecil_value: INTEGER is
			-- Cecil value
		do
			Result := Sk_int
		end;

end
