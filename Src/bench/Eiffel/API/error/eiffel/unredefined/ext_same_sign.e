indexing

	description: 
		"Error for specifying an external feature with a %
		%different signature (wrong number of argument/result).";
	date: "$Date$";
	revision: "$Revision $"

class EXT_SAME_SIGN 

inherit

	FEATURE_ERROR

feature -- Properties

	code: STRING is "EXT_SAME_SIGN";
			-- Error code

end -- class EXT_SAME_SIGN
