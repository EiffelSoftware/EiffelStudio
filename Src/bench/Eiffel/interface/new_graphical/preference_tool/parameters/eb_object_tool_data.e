indexing
	description: "All shared attributes specific to the object tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OBJECT_TOOL_DATA

feature -- Access

	Object_Resources: EB_OBJECT_PARAMETERS is
			-- Object tool specific parameters
		once
			create Result.make
		end

end -- class EB_OBJECT_TOOL_DATA
