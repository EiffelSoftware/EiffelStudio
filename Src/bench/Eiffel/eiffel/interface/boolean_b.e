-- Internal representation of class BOOLEAN

class BOOLEAN_B 

inherit
	CLASS_B
		redefine
			actual_type
		end

create
	make
	
feature -- Actual class type

	actual_type: BOOLEAN_A is
			-- Actual boolean type
		once
			Result := Boolean_type
		end;
	
end
