indexing

	description: 
		"Error for name clash on formal generic parameter.";
	date: "$Date$";
	revision: "$Revision $"

class VCFG2 

inherit

	VCFG1
		redefine
			subcode
		end;

feature -- Properties

	subcode: INTEGER is 2;

end -- class VCFG2
