indexing

	description:	
		"Ancestor of all workbench commands.";
	date: "$Date$";
	revision: "$Revision$"

deferred class COMMAND_W 

inherit

	WINDOWS;
	INTERFACE_W;
	GRAPHICS;
	CURSOR_W;
	COMMAND;
	WARNING_MESSAGES

feature -- Execution

	execute (argument: ANY) is
			-- Set cursor to watch shape, call `work' and restore cursor.
		do
			set_global_cursor (watch_cursor);
			work (argument);
			restore_cursors
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
		deferred
		end;

end -- class COMMAND_W
