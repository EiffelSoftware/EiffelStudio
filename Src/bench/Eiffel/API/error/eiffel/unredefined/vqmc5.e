indexing

	description: 
		"Error when a constant value type doesn't match the constant type.";
	date: "$Date$";
	revision: "$Revision $"

class VQMC5 

inherit

	VQMC
		redefine
			subcode
		end;

feature -- Properties

	subcode: INTEGER is 5;

end -- class VQMC5
