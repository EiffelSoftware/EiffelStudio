-- Internal representation of class DOUBLE

class DOUBLE_B 

inherit
	CLASS_B
		redefine
			actual_type, generate_cecil_value, cecil_value
		end

creation
	make
	
feature 

	actual_type: DOUBLE_A is
			-- Actual double type
		once
			Result := Double_type
		end;

	generate_cecil_value is
			-- Generate Cecil type value
		do
			generation_buffer.putstring ("SK_DOUBLE");
		end;

	cecil_value: INTEGER is
			-- Cecil value
		do
			Result := Sk_double
		end;

end
