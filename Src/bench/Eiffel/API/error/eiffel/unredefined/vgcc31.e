indexing

	description: 
		"Error when a specified type of a creation instruction doesn't %
		%conform to the type of the target to create.";
	date: "$Date$";
	revision: "$Revision $"

class VGCC31 

inherit

	VGCC
		redefine
			subcode
		end;

feature -- Properties

	subcode: INTEGER is 3;

end -- class VGCC31
