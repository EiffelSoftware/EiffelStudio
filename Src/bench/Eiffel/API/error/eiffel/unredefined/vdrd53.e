-- Error when an argument type of a redefinition violates the rule
-- of signature conformance

class VDRD53 

inherit

	VDRD51
	
feature 

	argument_number: INTEGER;
			-- Name of the involved argument of the redefined feature

	set_argument_number (s: INTEGER) is
			-- Assign `s' to `argument_number'.
		do
			argument_number := s;
		end;

end
