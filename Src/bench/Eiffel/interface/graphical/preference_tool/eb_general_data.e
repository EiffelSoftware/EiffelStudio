indexing
	description: "All shared general attributes"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GENERAL_DATA

feature -- Access

	General_Resources: GENERAL_CATEGORY is
			-- Class tool specific parameters
		once
			create Result.make
		end

end -- class EB_GENERAL_DATA