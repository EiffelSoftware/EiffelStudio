indexing

	description: 
		"Error when a prefixed feature has arguments.";
	date: "$Date$";
	revision: "$Revision $"

class VFFD5 

inherit

	VFFD
		redefine
			subcode
		end;

feature -- Properties

	subcode: INTEGER is 5;

end -- class VFFD5
