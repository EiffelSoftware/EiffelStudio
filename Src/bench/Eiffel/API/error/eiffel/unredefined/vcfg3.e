indexing

	description: 
		"Error for name clash on formal generic parameter.";
	date: "$Date$";
	revision: "$Revision $"

class VCFG3 

inherit

	VCFG1
		redefine
			subcode
		end;

feature -- Properties

	subcode: INTEGER is 3;

end -- class VCFG3
