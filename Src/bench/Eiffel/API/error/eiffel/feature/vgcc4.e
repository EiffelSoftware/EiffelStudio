indexing

	description: 
		"Error when there a is a creation call when there are %
		%feature in the creation clause in the class of the %
		%instance to create";
	date: "$Date$";
	revision: "$Revision $"

class VGCC4

inherit

	VGCC
		redefine
			subcode
		end;

feature -- Properties

	subcode: INTEGER is 5;

end -- class VGCC4
