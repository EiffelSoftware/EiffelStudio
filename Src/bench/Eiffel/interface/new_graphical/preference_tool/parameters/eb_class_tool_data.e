indexing
	description: "All shared attributes specific to the class tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_TOOL_DATA

feature -- Access

	Class_Resources: EB_CLASS_PARAMETERS is
			-- Class tool specific parameters
		once
			create Result.make
		end

end -- class EB_CLASS_TOOL_DATA
