indexing
	description: ""
	date: "$Date$"
	revision: "$Revision $"

class
	YES_SD

inherit
	YES_OR_NO_SD
		redefine
			is_yes
		end

feature -- Properties

	is_yes: BOOLEAN is True
			-- Is the option value `yes' ?

end -- class YES_SD 
