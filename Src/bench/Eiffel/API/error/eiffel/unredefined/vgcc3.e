indexing

	description: 
		"Error when the creation type of a creation instruction %
		%is an expanded type, a none type or a simple type.";
	date: "$Date$";
	revision: "$Revision $"

class VGCC3 

inherit

	VGCC
		redefine
			subcode
		end;

feature -- Properties

	subcode: INTEGER is 3

end -- class VGCC3
