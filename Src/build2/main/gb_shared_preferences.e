indexing
	description: "Objects that provide global resources"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHARED_PREFERENCES

feature -- Access

	preferences: GB_PREFERENCES is
			-- `Result' is history of the building process.
		once
			create Result
		end

end -- class GB_SHARED_RESOURCES
