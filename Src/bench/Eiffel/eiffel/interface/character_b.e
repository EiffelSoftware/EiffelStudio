-- Internal representation of class CHARACTER

class CHARACTER_B 

inherit
	CLASS_B
		redefine
			actual_type, generate_cecil_value, cecil_value
		end

creation
	make
	
feature 

	actual_type: CHARACTER_A is
			-- Actual character type
		once
			Result := Character_type;
		end;

	generate_cecil_value is
			-- Generate Cecil type value
		do
			generation_buffer.putstring ("SK_CHAR");
		end;

	cecil_value: INTEGER is
			-- Cecil value
		do
			Result := Sk_char
		end;

end
