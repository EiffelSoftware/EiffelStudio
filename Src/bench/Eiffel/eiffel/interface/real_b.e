-- Internal representation of class REAL

class REAL_32_B 

inherit

	CLASS_B
		redefine
			actual_type
		end

create

	make
	
feature 

	actual_type: REAL_32_A is
			-- actual real type
		once
			Result := Real_32_type
		end;

end
