indexing

	description: 
		"Error when a feature name is more than once in a creation clause.";
	date: "$Date$";
	revision: "$Revision $"

class VGCP3 

inherit

	VGCP21
		redefine
			subcode
		end;

feature -- Properties

	subcode: INTEGER is 3;

end -- class VGCP3
