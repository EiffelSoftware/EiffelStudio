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

	make (c: COMPOSITE; a_text_window: PROJECT_TEXT) is
			-- Initialize the command, and set an action.
		do
			init (c, a_text_window);
			set_action ("!c<Btn1Down>", Current, Format_and_run)
		end;

feature -- Execution

	execute (argument: ANY) is
			-- Execute the command.
		do
			if argument /= get_in and argument /= get_out then
				if last_warner /= Void then
					last_warner.popdown
				end
			end;
			if argument = get_in then
				text_window.tool.tell_type (command_name)
			elseif argument = get_out then
				text_window.tool.clean_type
			else
				format (Void);
				if argument = Format_and_run then
					text_window.tool.debug_run_command.execute (Void)
				end;
				text_window.set_last_format (Current)
			end
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
