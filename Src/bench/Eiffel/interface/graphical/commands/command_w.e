indexing

	description:	
		"Ancestor of all workbench commands.";
	date: "$Date$";
	revision: "$Revision$"

deferred class COMMAND_W 

inherit

	WINDOWS;
	EB_CONSTANTS;
	GRAPHICS;
	COMMAND

feature -- Execution

	execute (argument: ANY) is
			-- Set cursor to watch shape, call `work' and restore cursor.
		local
			mp: MOUSE_PTR
		do
			create mp.set_watch_cursor;
			work (argument);
			mp.restore;
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
		deferred
		end;

end -- class COMMAND_W
