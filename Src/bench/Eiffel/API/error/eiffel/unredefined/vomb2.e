indexing

	description: 
		"Interval has values of bad type.";
	date: "$Date$";
	revision: "$Revision $"

class VOMB2 

inherit

	VOMB1
		redefine
			subcode
		end;

feature -- Properties

	subcode: INTEGER is 2;

end -- class VOMB2
