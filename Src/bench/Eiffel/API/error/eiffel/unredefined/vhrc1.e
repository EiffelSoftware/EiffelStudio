indexing

	description: 
		"Error for invalid renaming.";
	date: "$Date$";
	revision: "$Revision $"

class VHRC1 

inherit

	VHRC
		redefine
			subcode
		end;

feature -- Properties

	subcode: INTEGER is 1;

end -- class VHRC1
