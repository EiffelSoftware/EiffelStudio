indexing
	description: "All shared general attributes"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GENERAL_DATA

feature -- Access

	General_Resources: EB_GENERAL_PARAMETERS is
			-- Class tool specific parameters
		once
			create Result.make
		end

end -- class EB_GENERAL_DATA
