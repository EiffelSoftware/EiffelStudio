indexing

	description: 
		"A tasking manager.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	TASK_X 

inherit

	LINKED_LIST [COMMAND_EXEC]
		rename
			make as ll_make
		export
			{NONE} all
		end;

	TASK_I;

	INPUT_EVENT_X

creation

	make

feature {NONE} -- Initialization

	make is
		do
			ll_make;	
			compare_objects
		end;

feature -- Element change

	add_action (a_command: COMMAND; an_argument: ANY) is
			-- Add `a_command' with `argument' to the list of action to execute 
			-- while the system is waiting for user events.
		local
			command_info: COMMAND_EXEC;
			ac: like application_context;
		do
			if not is_call_back_set then
				ac := application_context;
				ac.set_work_proc_callback (Current, Void);
				identifier := ac.last_id;
			end;
			!! command_info.make (a_command, an_argument);
			extend (command_info);
		end;

feature -- Removal

	remove_action (a_command: COMMAND; an_argument: ANY) is
			-- Remove `a_command' with `argument' to the list of action to
			-- execute while the system is waiting for user events.
		local
			command_info: COMMAND_EXEC;
		do
			!! command_info.make (a_command, an_argument);
			start;
			search (command_info);
			if not after then
				remove;
			end;
			if empty and is_call_back_set then
				set_no_call_back;
			end;
		end;

feature {NONE} -- Execution

	execute (arg: ANY) is
			-- Call the command.
		do
			from
				start
			until
				after
			loop
				item.execute (Void);
				if not after then
					forth;
				end;
			end;
		end;

end -- TASK_X

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
