-- Internal representation of class DOUBLE

class REAL_64_B 

inherit
	CLASS_B
		redefine
			actual_type
		end

create
	make
	
feature 

	actual_type: REAL_64_A is
			-- Actual double type
		once
			Result := Real_64_type
		end;

end
