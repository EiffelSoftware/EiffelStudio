note
	description: "Summary description for {IV_SHARED_TYPES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IV_SHARED_TYPES

feature {NONE} -- Access

	types: IV_TYPES
			-- Shared access to Boogie types.
		once
			create Result
		end

end
