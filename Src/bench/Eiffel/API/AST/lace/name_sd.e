indexing
	description: ""
	date: "$Date$"
	revision: "$Revision $"

class
	NAME_SD

inherit
	OPT_VAL_SD
		redefine
			is_name
		end

feature -- Properties

	is_name: BOOLEAN is True
			-- is the option value a name option ?

end -- class NAME_SD
