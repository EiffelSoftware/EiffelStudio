indexing

	description: 
		"Error for a rename clause an infix is renamed as a prefix %
		%or the opposite.";
	date: "$Date$";
	revision: "$Revision $"

class VHRC4

inherit

	VHRC
		redefine
			subcode
		end;

feature -- Properties

	subcode:INTEGER is 4;

end -- class VHRC4
