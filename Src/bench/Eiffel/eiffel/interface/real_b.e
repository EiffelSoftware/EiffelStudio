-- Internal representation of class REAL

class REAL_B 

inherit

	CLASS_B
		redefine
			actual_type, generate_cecil_value, cecil_value
		end

creation

	make
	
feature 

	actual_type: REAL_A is
			-- actual real type
		once
			Result := Real_type
		end;

	generate_cecil_value is
			-- Generate Cecil type value
		do
			generation_buffer.putstring ("SK_FLOAT");
		end;

	cecil_value: INTEGER is
			-- Cecil value
		do
			Result := Sk_float
		end;

end
