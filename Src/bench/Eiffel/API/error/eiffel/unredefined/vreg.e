-- Error when there are two arguments with the same name

class VREG 

inherit

	EIFFEL_ERROR
	
feature 

	body_id: INTEGER;
			-- Body id for the involved feature

	argument_name: ID_AS;
			-- Argument name violating the VREG rule

	code: STRING is "VREG";
			-- Error code

	set_body_id (i: INTEGER) is
			-- Assign `i' to `body_id'.
		do
			body_id := i;
		end;

	set_argument_name (s: ID_AS) is
			-- Assign `s' to `argument_name'.
		do
			argument_name := s;
		end;

end
