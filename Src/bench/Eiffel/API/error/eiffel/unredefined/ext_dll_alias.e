indexing
	description: "Error for specifying a DLL32 without an integer alias.";
	date: "$Date$";
	revision: "$Revision $"

class EXT_DLL_ALIAS 

inherit
	FEATURE_ERROR

feature -- Properties

	code: STRING is "EXT_DLL_ALIAS";
			-- Error code

end -- class EXT_DLL_ALIAS
