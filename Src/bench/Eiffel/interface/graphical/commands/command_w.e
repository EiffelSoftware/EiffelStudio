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
	COMMAND;
	WARNING_MESSAGES

feature -- Execution

	execute (argument: ANY) is
			-- Set cursor to watch shape, call `work' and restore cursor.
		local
			mp: MOUSE_PTR
		do
			!! mp.set_watch_cursor;
			work (argument);
			mp.restore;
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
		deferred
		end;

end -- class COMMAND_W
