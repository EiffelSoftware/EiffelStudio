indexing
	description: "All shared attributes specific to the system tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SYSTEM_TOOL_DATA

feature -- Access

	System_Resources: EB_SYSTEM_PARAMETERS is
			-- System tool specific parameters
		once
			create Result.make
		end

end -- class EB_SYSTEM_TOOL_DATA
