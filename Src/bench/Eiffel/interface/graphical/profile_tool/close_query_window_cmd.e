indexing

	description:
		"Command to close a PROFILE_QUERY_WINDOW";
	date: "$Date$";
	revision: "$Revision$"

class CLOSE_QUERY_WINDOW_CMD

inherit
	COMMAND

create
	make

feature {NONE} -- Initialization

	make (a_tool: PROFILE_QUERY_WINDOW) is
			-- Create Current and set `tool' to `a_tool'.
		require
			a_tool_not_void: a_tool /= Void
		do
			tool := a_tool
		ensure
			tool_set: tool.is_equal (a_tool)
		end

feature {NONE} -- Command Execution

	execute (arg: ANY) is
			-- Execute Current
		do
			tool.close
		end

feature {NONE} -- Attributes

	tool: PROFILE_QUERY_WINDOW

end -- class CLOSE_QUERY_WINDOW_CMD
