indexing
	description: "Objects that provide access to a GB_SYSTEM_STATUS object."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHARED_SYSTEM_STATUS

feature -- Access

	system_status: GB_SYSTEM_STATUS is
			-- `Result' is instance of GB_SYSTEM_STATUS.
		once
			create Result
		end
		

end -- class GB_ACCESSIBLE_SYSTEM_STATUS
