indexing

	description: 
		"A feature name is repeated more than once in export adaptation.";
	date: "$Date$";
	revision: "$Revision $"

class VLEL3 

inherit

	VLEL2
		redefine
			subcode
		end;

feature -- Properties

	subcode: INTEGER is 3;

end -- class VLEL3
