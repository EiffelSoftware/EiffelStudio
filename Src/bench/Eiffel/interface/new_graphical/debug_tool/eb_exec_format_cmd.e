indexing

	description:	
		"Set execution format."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_EXEC_FORMAT_CMD

inherit
	EB_TOOL_COMMAND
		redefine
			tool
		end
	
	EXEC_MODES

	NEW_EB_CONSTANTS

	SHARED_APPLICATION_EXECUTION


feature -- Formatting

	execute (argument: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the execution format to `stone'.
		do
			Application.set_execution_mode (execution_mode)
			tool.debug_run_cmd.execute (Void, Void)
		end

feature -- Properties

	tool: EB_DEBUG_TOOL
			-- Debug tool

feature {NONE} -- Attributes

	execution_mode: INTEGER is
			-- Mode of execution.
		deferred
		end

	display_info (s: STONE) is
			-- Useless here.
		do
			-- Do Nothing
		end

	title_part: STRING is
			-- Part of the title of the window.
		do
			Result := ""
		end

end -- class EB_EXEC_FORMAT_CMD
