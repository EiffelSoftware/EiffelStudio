indexing
	description:
		"All shared attributes specific to the project tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROJECT_TOOL_DATA

feature -- Access

	Project_Resources: EB_PROJECT_PARAMETERS is
			-- Project tool specific parameters
		once
			create Result.make
		end

end -- class EB_PROJECT_TOOL_DATA
