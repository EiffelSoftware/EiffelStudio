indexing
	description: "All shared attributes specific to the profiler"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROFILE_TOOL_DATA

feature -- Access

	Profile_Resources: EB_PROFILE_PARAMETERS is
			-- Profiler specific parameters
		once
			create Result.make
		end

end -- class EB_PROFILE_TOOL_DATA
