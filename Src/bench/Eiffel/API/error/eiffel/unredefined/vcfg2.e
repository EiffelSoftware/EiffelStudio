-- Error for name clash on formal generic parameter

class VCFG2 

inherit

	VCFG1
		redefine
			subcode
		end;

feature 

	subcode: INTEGER is 2;

end
