-- Error for a formal generic name as a class name in the surrounding
-- universe.

class VCFG1 

inherit

	EIFFEL_ERROR
		redefine
			subcode
		end;

feature 

	code: STRING is "VCFG";
			-- Error code

	subcode: INTEGER is 1;

	formal_name: ID_AS;
			-- Formal generic name

	set_formal_name (s: ID_AS) is
			-- Assign `s' to `formal_name'.
		do
			formal_name := s;
		end;

end
