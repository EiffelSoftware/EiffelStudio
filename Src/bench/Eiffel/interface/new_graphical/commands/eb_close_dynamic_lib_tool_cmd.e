indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLOSE_DYNAMIC_LIB_TOOL_CMD

inherit
	EB_CLOSE_EDITOR_CMD
		redefine
			tool, execute
		end
feature

	tool: EB_DYNAMIC_LIB_TOOL

feature {NONE} -- Implementation

	execute is
			-- Quit cautiously a file.
		local
			csd: EB_CONFIRM_SAVE_DIALOG
			cmd: EV_ROUTINE_COMMAND
		do
			if tool.Eiffel_dynamic_lib.modified then
				create csd.make_and_launch (tool, Current, argument)
				user_warned := True
			else
				exit_anyway
			end
		end

end -- class EB_CLOSE_DYNAMIC_LIB_TOOL_CMD
