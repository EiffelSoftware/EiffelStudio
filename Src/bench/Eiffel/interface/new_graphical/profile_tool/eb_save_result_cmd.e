indexing

	description:
		"Command to save the query and options %
		%currently displayed in a PROFILE_QUERY_WINDOW"
	date: "$Date$"
	revision: "$Revision$"

class EB_SAVE_RESULT_CMD

inherit
--	COMMAND_W
-- command_w a refaire dans la nouvelle version
	EV_COMMAND

creation
	make

feature {NONE} -- Initialization

	make (a_tool: EB_PROFILE_QUERY_WINDOW) is
			-- Create Current and set `tool' to `a_tool'.
		require
			a_tool_not_void: a_tool /= Void
		do
			tool := a_tool
		ensure
			tool_set: tool.is_equal (a_tool)
		end

feature {NONE} -- Command Execution

	execute (arg: EV_ARGUMENT1 [ANY]; data EV_DATA_EVENT) is
			-- Execute Current
		local
--			nc: NAME_CHOOSER_W
--			file_name: STRING
		do
--			if arg = Void then
--				nc := name_chooser (query_window)
--				nc.set_save_file
--				nc.call (Current)
--			else
--				file_name := clone (last_name_chooser.selected_file)
--				query_window.save_in (file_name)
--			end
		end

feature {NONE} -- Attributes

	query_window: EB_PROFILE_QUERY_WINDOW

end -- class EB_SAVE_RESULT_CMD
