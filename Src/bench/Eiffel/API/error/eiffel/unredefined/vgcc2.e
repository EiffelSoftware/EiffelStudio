indexing

	description: 
		"Error for a creation of an instance of a deferred class.";
	date: "$Date$";
	revision: "$Revision $"

class VGCC2 

inherit

	VGCC
		redefine
			subcode
		end

feature -- Properties

	subcode: INTEGER is 2

end -- class VGCC2
