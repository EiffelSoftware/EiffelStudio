-- Error for name clash on formal generic parameter

class VCFG2 

inherit

	EIFFEL_ERROR
		redefine
			subcode
		end;

feature 

	code: STRING is "VCFG";
			-- Error code

	subcode: INTEGER is 2;

	formal_name1: ID_AS;
			-- First formal generic name

	formal_name2: ID_AS;
			-- Second formal generic name

	set_formal_name1 (s: ID_AS) is
			-- Assign `s' to `formal_name1'.
		do
			formal_name1 := s;
		end;

	set_formal_name2 (s: ID_AS) is
			-- Assign `s' to `formal_name2'.
		do
			formal_name2 := s;
		end;

end
