-- Error when argument name is also a feature name

class VRFA 

inherit

	EIFFEL_ERROR
		redefine
			Error_string
		end;
	
feature 

	body_id: INTEGER;
			-- Body id for the involved feature

	argument_name: ID_AS;
			-- Argument name violating the VRFA rule

	code: STRING is "VRFA";
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

	Error_string: STRING is
		do
			Result := "Warning "
		end;

end
