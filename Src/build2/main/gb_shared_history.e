indexing
	description: "Objects that provide common access to global history"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHARED_HISTORY


feature -- Access

	history: GB_GLOBAL_HISTORY is
			-- `Result' is history of the building process.
		once
			create Result
		end
		

end -- class GB_ACCESSIBLE_HISTORY
