indexing
	description: ""
	date: "$Date$"
	revision: "$Revision $"

class
	ALL_SD

inherit
	OPT_VAL_SD
		redefine
			is_all
		end

feature -- Properties

	is_all: BOOLEAN is True
			-- Is the option value `all' ?

end -- class ALL_SD
