-- Error for generic type for once function

class VFFD7 

inherit

	EIFFEL_ERROR
	
feature 

	body_id: INTEGER;
			-- Body id for the involved feature

	code: STRING is "VFFD";
			-- Error code

	set_body_id (i: INTEGER) is
			-- Assign `i' to `body_id'.
		do
			body_id := i;
		end;

end
