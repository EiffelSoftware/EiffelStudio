indexing

	description: 
		"Error when a constant value type doesn't match the constant type.";
	date: "$Date$";
	revision: "$Revision $"

class VQMC3 

inherit

	VQMC
		redefine
			subcode
		end;

feature -- Properties

	subcode: INTEGER is 3;

end -- class VQMC3
