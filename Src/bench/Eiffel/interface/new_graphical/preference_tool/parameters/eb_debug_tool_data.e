indexing
	description: "All shared attributes specific to the debugger"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUG_TOOL_DATA

feature -- Access

	Debug_Resources: EB_DEBUG_PARAMETERS is
			-- Debugger specific parameters
		once
			create Result.make
		end

end -- class EB_DEBUG_TOOL_DATA
