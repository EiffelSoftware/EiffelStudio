indexing
	description: ""
	date: "$Date$"
	revision: "$Revision $"

class
	ENSURE_SD

inherit
	OPT_VAL_SD
		redefine
			is_ensure
		end

feature -- Properties

	is_ensure: BOOLEAN is True
			-- Is the option value `ensure' ?

end -- class ENSURE_SD
