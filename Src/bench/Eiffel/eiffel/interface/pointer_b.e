-- Internal representation of class POINTER

class POINTER_B 

inherit

	CLASS_B
		redefine
			actual_type, generate_cecil_value, cecil_value
		end

creation

	make
	
feature 

	actual_type: POINTER_A is
			-- Actual double type
		once
			Result := Pointer_type
		end; -- actual_type

	generate_cecil_value is
			-- Generate Cecil type value
		do
			generation_buffer.putstring ("SK_POINTER");
		end; -- generate_cecil_value

	cecil_value: INTEGER is
			-- Cecil value
		do
			Result := Sk_pointer 
		end;

end
