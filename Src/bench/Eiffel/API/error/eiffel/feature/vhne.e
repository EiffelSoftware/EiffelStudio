indexing

	description: 
		"There is no exported feature to NONE.";
	date: "$Date$";
	revision: "$Revision $"

class VHNE obsolete "NOT IN THE BOOK"

inherit

	FEATURE_ERROR
		redefine
			subcode
		end;

feature -- Properties

	code: STRING is "VUEX";
			-- Error code

	subcode: INTEGER is 2;

end -- class VHNE
