indexing

	description: 
		"Error for a rename clause an infix is renamed as a prefix %
		%or the opposite.";
	date: "$Date$";
	revision: "$Revision $"

class VHRC5

inherit

	VHRC
		redefine
			subcode
		end;

feature -- Properties

	subcode:INTEGER is 5;

end -- class VHRC5
