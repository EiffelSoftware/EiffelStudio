indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OBJECT_PARAMETERS

inherit
	EB_PARAMETERS

creation

	make

feature {TTY_RESOURCES} -- Initialization

	initialize (rt: RESOURCE_TABLE) is
			-- Initialize all resources valid for Current.
		do
			create tool_width.make ("object_tool_width", rt, 440)
			create tool_height.make ("object_tool_height", rt, 500)
			create command_bar.make ("object_tool_bar", rt, True)
		end

feature -- Access

	tool_width: EB_INTEGER_RESOURCE
	tool_height: EB_INTEGER_RESOURCE
	command_bar: EB_BOOLEAN_RESOURCE

end -- class EB_OBJECT_PARAMETERS
