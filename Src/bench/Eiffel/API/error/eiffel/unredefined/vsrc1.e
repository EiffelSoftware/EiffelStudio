indexing

	description: 
		"Error for generic root class.";
	date: "$Date$";
	revision: "$Revision $"

class VSRC1 

inherit

	EIFFEL_ERROR
		redefine
			subcode
		end;

feature -- Properties

	code: STRING is "VSRC";
			-- Error code

	subcode: INTEGER is 1;

end -- class VSRC1
