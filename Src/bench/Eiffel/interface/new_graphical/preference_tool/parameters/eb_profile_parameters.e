indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROFILE_PARAMETERS

inherit
	EB_PARAMETERS

creation
	make

feature {TTY_RESOURCES} -- Initialization

	initialize (rt: RESOURCE_TABLE) is
			-- Initialize all resources valid for Current.
		do
			create tool_width.make ("profile_tool_width", rt, 450)
			create tool_height.make ("profile_tool_height", rt, 490)
			create query_tool_width.make ("profile_query_tool_width", rt, 500)
			create query_tool_height.make ("profile_query_tool_height", rt, 500)
		end

feature -- Access

	tool_width: EB_INTEGER_RESOURCE
	tool_height: EB_INTEGER_RESOURCE
	query_tool_width: EB_INTEGER_RESOURCE
	query_tool_height: EB_INTEGER_RESOURCE

end -- class EB_PROFILE_PARAMETERS
