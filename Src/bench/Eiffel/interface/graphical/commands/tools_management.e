indexing

	description:
		"Command to close all open tools.";
	date: "$Date$";
	revision: "$Revision$"

class CLOSE_ALL_CMD

inherit
	TOOL_COMMAND
		rename
			init as make
		end

creation
	make

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
