-- Internal representation of class DOUBLE

class DOUBLE_B 

inherit
	CLASS_B
		redefine
			actual_type
		end

create
	make
	
feature 

	actual_type: DOUBLE_A is
			-- Actual double type
		once
			Result := Double_type
		end;

end
