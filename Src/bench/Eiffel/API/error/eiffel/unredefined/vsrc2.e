indexing

	description: 
		"Error for deferred root class.";
	date: "$Date$";
	revision: "$Revision $"

class VSRC2

inherit

	EIFFEL_ERROR
		redefine
			subcode
		end;

feature -- Properties

	code: STRING is "VSRC";
			-- Error code

	subcode: INTEGER is 2;

end -- class VSRC2
