indexing

	description:	
		"Set execution format.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	
	EXEC_FORMAT

inherit

	FORMATTER
		redefine
			format, execute, text_window
		end;
	SHARED_APPLICATION_EXECUTION;
	EXEC_MODES

feature -- Standard Initialization

	make (a_text_window: PROJECT_TEXT) is
			-- Initialize the command, and set an action.
		do
			init (a_text_window);
		end;

feature -- Execution

	execute (argument: ANY) is
			-- Execute the command.
		do
			if last_warner /= Void then
				last_warner.popdown
			end
			format (Void);
			if argument = Format_and_run then
				text_window.tool.debug_run_cmd_holder.associated_command.execute (Void)
			end;
			text_window.set_last_format (holder)
		end;

feature -- Formatting

	format (stone: STONE) is
			-- Set the execution format to `stone'.
		do
			Application.set_execution_mode (execution_mode)
		end;

feature -- Properties

	text_window: PROJECT_TEXT;
			-- Text to be displayed in the project tool.

feature {NONE} -- Attributes

	execution_mode: INTEGER is
			-- Mode of execution.
		deferred
		end;

	display_info (s: STONE) is
			-- Useless here.
		do
			-- Do Nothing
		end;

	title_part: STRING is
			-- Part of the title of the window.
		do
			Result := ""
		end;

end -- class EXEC_FORMAT
