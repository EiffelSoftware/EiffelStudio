-- Internal representation of class REAL

class REAL_B 

inherit

	CLASS_B
		redefine
			actual_type
		end

create

	make
	
feature 

	actual_type: REAL_A is
			-- actual real type
		once
			Result := Real_type
		end;

end
