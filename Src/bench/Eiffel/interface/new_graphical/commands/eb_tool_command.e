indexing
	description:
		"Abstract notion of a command associated with a tool"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_TOOL_COMMAND

inherit
	EV_COMMAND
		export
			{EB_TOOL_COMMAND} execute
		end

feature {NONE} -- Initialization

	make (a_tool: like tool) is
			-- Initialize Current.
		require
			a_tool_not_void: a_tool /= Void
		do
			tool := a_tool
		ensure
			tool_set: tool.is_equal (a_tool)
		end

feature -- Properties

	tool: EB_TOOL
			-- The tool

end -- class EB_TOOL_COMMAND
