indexing

	description: 
		"Error when a deferred class has a creation clause.";
	date: "$Date$";
	revision: "$Revision $"

class VGCP1

inherit

	VGCP
		redefine
			subcode
		end;

feature -- Properties

	subcode: INTEGER is 1;

end -- class VGCP1
