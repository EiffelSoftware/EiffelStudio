indexing
	description: ""
	date: "$Date$"
	revision: "$Revision $"

class
	REQUIRE_SD

inherit
	OPT_VAL_SD
		redefine
			is_require
		end

feature -- Properties

	is_require: BOOLEAN is True
			-- Is the option value `require' ?

end -- class REQUIRE_SD
