indexing

	description: 
		"Error when the creation type of an instruction %
		%is a formal generic parameter.";
	date: "$Date$";
	revision: "$Revision $"

class VGCC1 

inherit

	VGCC
		redefine
			subcode
		end;

feature -- Properties

	subcode: INTEGER is 1

end -- class VGCC1
