indexing

	description:	
		"Command that has a name, menu entry and accelerator. %
		%Current command should be in a menu as well as actions for buttons";
	date: "$Date$";
	revision: "$Revision$"

deferred class ISE_COMMAND

inherit

	COMMAND

feature -- Access

	name: STRING is
			-- Name of the command
		deferred
		end;

	menu_name: STRING is
			-- Name used in menu entry
		deferred
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		deferred
		end

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

	work (argument: ANY) is
		deferred
		end;

feature {ISE_BUTTON, ISE_MENU_ENTRY} -- Implementation

	button_three_action: ANY is
			-- Action to specify that the third button was pressed
		once
			create Result
		end;

end -- class ISE_COMMAND
