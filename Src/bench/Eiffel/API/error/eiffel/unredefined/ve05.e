indexing

	description: 
		"Error for invalid assertion: %
		%`require else' or `ensure then' is used in a routine without precursors";
	date: "$Date$";
	revision: "$Revision $"

class VE05 obsolete "NOT DEFINED IN THE BOOK"

inherit

	FEATURE_ERROR

feature -- Properties

	code: STRING is "VE05";
			-- Error code

end -- class VE05
