indexing
	description: ""
	date: "$Date$"
	revision: "$Revision $"

class
	NO_SD

inherit
	YES_OR_NO_SD
		redefine
			is_no
		end

feature -- Properties

	is_no: BOOLEAN is True
			-- is the option value `no' ?

end -- class NO_SD
