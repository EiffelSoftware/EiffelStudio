indexing

	description: 
		"Error for a rename clause where the old name appears %
		%more than once in rename clauses.";
	date: "$Date$";
	revision: "$Revision $"

class VHRC2 

inherit

	VHRC
		redefine
			subcode
		end;

feature -- Properties

	subcode:INTEGER is 2;

end -- class VHRC2
