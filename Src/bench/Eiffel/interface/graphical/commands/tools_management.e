indexing

	description:
		"Command to close all open tools.";
	date: "$Date$";
	revision: "$Revision$"

class CLOSE_ALL_CMD

inherit
	TOOL_COMMAND

creation
	make

feature {NONE} -- Initialization

	make (a_tool: PROJECT_W) is
			-- Initialize Current with `a_tool'
			-- as `tool'.
		do
			init_from_tool (a_tool)
		end

feature -- Properties

	name: STRING is "Close all tools"
			-- Current's name
			-- FIXME: Should be in INTERFACE_W

feature {NONE} -- Execution

	work (arg: ANY) is
		do
			window_manager.close_all_editors
		end

end -- class CLOSE_ALL_CMD
