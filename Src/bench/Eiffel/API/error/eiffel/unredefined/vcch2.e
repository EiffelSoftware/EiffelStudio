indexing

	description: 
		"Error when a decalred deferred class has no deferred features.";
	date: "$Date$";
	revision: "$Revision $"

class VCCH2 

inherit

	EIFFEL_ERROR
		redefine
			subcode
		end;

feature -- Properties

	code: STRING is "VCCH";
			-- Error code

	subcode: INTEGER is 2;

end -- class VCCH2
