indexing

	description: 
		"The target of a creation instruction can only be an attribute, %
		%a local variable of a Result.";
	date: "$Date$";
	revision: "$Revision $"

class VGCC7 obsolete "NOT IN THE BOOK"

inherit

	VGCC
		redefine
			subcode
		end;

feature -- Properties

	subcode: INTEGER is 7;

end -- class VGCC7
