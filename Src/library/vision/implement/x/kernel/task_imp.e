indexing

	description: 
		"A tasking manager.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	TASK_IMP 

inherit

	LINKED_LIST [COMMAND_EXEC]
		rename
			make as ll_make
		export
			{NONE} all
		end;

	TASK_I
		undefine
			copy, is_equal
		end

	INPUT_EVENT_X
		undefine
			copy, is_equal
		end

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

end -- TASK_IMP


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

