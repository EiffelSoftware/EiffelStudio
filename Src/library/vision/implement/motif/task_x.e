
-- A tasking manager.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class TASK_X 

inherit

	LINKED_LIST [COMMAND_EXEC]
		rename
			make as linked_list_make
		export
			{NONE} all;
			{ANY} empty
		end;

	TASK_I;

	EVENT_HDL;

creation

	make

feature 

	add_action (a_command: COMMAND; an_argument: ANY) is
			-- Add `a_command' with `argument' to the list of action to execute 
			-- while the system is waiting for user events.
		local
			command_info: COMMAND_EXEC;
		do
			if not is_call_back_set then
				c_task_set_call_back (c_data);
			end;
			!! command_info.make (a_command, an_argument);
			extend (command_info);
		ensure then
			not empty;
			is_call_back_set;
		end;

feature {NONE}

	c_data: POINTER;
			-- Address of datas for C routines

	call_back is
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

	
feature 

	make (a_task: TASK; an_application_context: POINTER) is
			-- Create a openlook task.
		require
			a_task_exists: not (a_task = Void);
		do
			linked_list_make;
			c_data := c_task_create (an_application_context, Current, $call_back);
			if false then
				call_back
			end;
		end; 

	
feature 

	is_call_back_set: BOOLEAN is
			-- Is a call back already set ?
		do		
			Result := c_task_is_call_back_set (c_data);
		end; 

	
feature 

	remove_action (a_command: COMMAND; an_argument: ANY) is
			-- Remove `a_command' with `argument' to the list of action to
			-- execute while the system is waiting for user events.
		require else
			not_a_command_void: not (a_command = Void);
			is_call_back_set;
		
		local
			command_info: COMMAND_EXEC;
			is_removed: BOOLEAN;
		do
			!! command_info.make (a_command, an_argument);
			start;
			compare_objects;
			search (command_info);
			compare_references;
			if not off then
				remove;
				is_removed := true;
			end;
			if empty and is_call_back_set then
				c_task_set_no_call_back (c_data);
			end;
		ensure then
			empty /= is_call_back_set;
		end;

	destroy is
			-- Free `c_data' C structure.
		local
			null_pointer: POINTER
		do
			check
				not_freed: null_pointer /= c_data
			end;
			c_free_task (c_data);
			c_data := null_pointer;
		ensure then
			is_data_freed: is_data_freed
		end
		
	is_data_freed: BOOLEAN is
			-- Is `c_data' freed ?
		local
			null_pointer: POINTER
		do
			Result := null_pointer = c_data
		end;
	
feature {NONE} -- External features

	c_free_task (data: POINTER) is
		external
			"C"
		end;

	c_task_set_call_back (data: POINTER) is
		external
			"C"
		end;

	c_task_set_no_call_back (data: POINTER) is
		external
			"C"
		end;

	c_task_is_call_back_set (data: POINTER): BOOLEAN is
		external
			"C"
		end; 

	c_task_create (context: POINTER; obj: G_ANY_I; cb: POINTER): POINTER is
		external
			"C"
		end; 

end


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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
