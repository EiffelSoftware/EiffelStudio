
-- Ancestor of all workbench commands.

deferred class COMMAND_W 

inherit

	WINDOWS;
	INTERFACE_W;
	GRAPHICS;
	CURSOR_W;
	COMMAND;
	WARNING_MESSAGES

feature 

	execute (argument: ANY) is
			-- Set cursor to watch shape, call `work' and restore cursor.
		do
			set_global_cursor (watch_cursor);
			work (argument);
			restore_cursors
		end;

feature {NONE}

	work (argument: ANY) is
		deferred
		end;

end
