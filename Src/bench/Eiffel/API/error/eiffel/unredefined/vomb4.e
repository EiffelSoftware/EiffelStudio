-- Error when there is two unique with the same name involved in a
-- inspect instruction

class VOMB4 

inherit

	VOMB
		redefine
			subcode
		end

feature

	subcode: INTEGER is 4;

feature

	unique_name: STRING;
			-- Unique feature name

	set_unique_name (s: STRING) is
			-- Assign `s' to `unique_name'.
		do
			unique_name := s;
		end;

end
