indexing
	description: "Parameters for the system tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SYSTEM_PARAMETERS

inherit
	EB_PARAMETERS

creation
	make

feature {TTY_RESOURCES} -- Initialization

	initialize (rt: RESOURCE_TABLE) is
			-- Initialize all resources valid for Current.
		do
			create tool_width.make ("system_tool_width", rt, 440)
			create tool_height.make ("system_tool_height", rt, 500)
			create command_bar.make ("system_tool_bar", rt, true)
			create parse_ace_after_saving.make ("parse_ace_after_saving", rt, True)
			-- create hidden_clusters.make ("hidden_clusters", rt, <<>>)
		end

feature -- Access

	tool_width: EB_INTEGER_RESOURCE
	tool_height: EB_INTEGER_RESOURCE
	command_bar: EB_BOOLEAN_RESOURCE
	parse_ace_after_saving: EB_BOOLEAN_RESOURCE
	
end -- class EB_SYSTEM_PARAMETERS
