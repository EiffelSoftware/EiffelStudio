class VTAT1A 

inherit

	VTAT1
	
feature 

	argument_name: STRING;
			-- Argument name which anchored type in unvalid

	set_argument_name (s: STRING) is
			-- Assign `s' to `argument_name'.
		do
			argument_name := s;
		end;

end
