-- Error for name clash on formal generic parameter

class VCFG3 

inherit

	VCFG1
		redefine
			subcode
		end;

feature 

	subcode: INTEGER is 3;

end
