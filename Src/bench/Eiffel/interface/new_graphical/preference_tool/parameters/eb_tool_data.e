indexing
	description: "All attributes shared by all tools"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TOOL_DATA

feature -- Access

	Tool_Resources: EB_TOOL_PARAMETERS is
			-- Tool specific parameters
		once
			create Result.make
		end

end -- class EB_TOOL_DATA
