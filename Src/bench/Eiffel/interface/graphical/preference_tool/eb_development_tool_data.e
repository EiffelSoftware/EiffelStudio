indexing
	description: "All shared attributes specific to the class tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEVELOPMENT_TOOL_DATA

feature -- Access

	Class_resources: CLASS_CATEGORY is
			-- Class tool specific parameters
		once
			create Result.make
		end

	Feature_resources: ROUTINE_CATEGORY is
			-- Feature tool specific parameters
		once
			create Result.make
		end

end -- class EB_DEVELOPMENT_TOOL_DATA
