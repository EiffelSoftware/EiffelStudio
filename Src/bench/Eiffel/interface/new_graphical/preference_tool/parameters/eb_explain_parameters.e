indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXPLAIN_PARAMETERS

inherit
	EB_PARAMETERS

creation

	make

feature {TTY_RESOURCES} -- Initialization

	initialize (rt: RESOURCE_TABLE) is
			-- Initialize all resources valid for Current.
		do
			create tool_width.make ("explain_tool_width", rt, 440)
			create tool_height.make ("explain_tool_height", rt, 500)
			create command_bar.make ("explain_tool_bar", rt, True)
		end

feature -- Access

	tool_width: EB_INTEGER_RESOURCE
	tool_height: EB_INTEGER_RESOURCE
	command_bar: EB_BOOLEAN_RESOURCE

end -- class EB_EXPLAIN_PARAMETERS
