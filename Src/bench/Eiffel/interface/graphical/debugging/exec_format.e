indexing

	description:	
		"Set execution format.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EXEC_FORMAT

inherit
	PIXMAP_COMMAND
		rename
			init as make
		redefine
			execute, tool
		end
	
	EXEC_MODES

	SHARED_APPLICATION_EXECUTION

feature -- Execution

	execute (argument: ANY) is
			-- Execute the command.
		do
			if last_warner /= Void then
				last_warner.popdown
			end;
			work (Void);
		end;

feature -- Formatting

	work (argument: ANY) is
			-- Set the execution format to `stone'.
		do
			Application.set_execution_mode (execution_mode)
			tool.debug_run_hole_holder.associated_command.execute (Current)
		end;

feature -- Properties

	tool: PROJECT_W;
			-- Project tool

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
