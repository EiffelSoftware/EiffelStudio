indexing

	description: 
		"Error when the argument number rule for redefinition is violated.";
	date: "$Date$";
	revision: "$Revision $"

class VDRD52 

inherit

	VDRD5
		redefine
			subcode
		end;

feature -- Properties

	subcode: INTEGER is 2;

end -- class VDRD52
