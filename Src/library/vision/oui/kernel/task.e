indexing

	description:
		"A tasking manager. %
		%This class should be used for executing long tasks whithout interfering %
		%with events system (otherwise the events will be put in a stack and wait %
		%until the task is finished, windows will not be redrawn for instance). %
		%This can be used for background tasks too";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class TASK 

inherit

	G_ANY
		export
			{NONE} all
		end

creation

	make

feature 

	add_action (a_command: COMMAND; an_argument: ANY) is
			-- Add `a_command' with `argument' to the list of action to execute
			-- while the system is waiting for user events.
		require
			exists: not destroyed;
			not_a_command_void: not (a_command = Void)
		do
			implementation.add_action (a_command, an_argument)
		end;

	make is
			-- Create a task.
		do
			implementation := toolkit.task (Current)
		end;

feature {NONE}

	implementation: TASK_I;
			-- Implementation of task

feature 

	remove_action (a_command: COMMAND; an_argument: ANY) is
			-- Remove `a_command' with `argument' to the list of action to
			-- execute while the system is waiting for user events.
		require
			exists: not destroyed;
			not_a_command_void: not (a_command = Void)
		do
			implementation.remove_action (a_command, an_argument)
		end;

	empty: BOOLEAN is
		require
			exists: not destroyed
		do
			Result := implementation.empty
		end;

	destroyed: BOOLEAN is
		do
			Result := implementation = Void
		end;

	destroy is 
			-- Destroy Current.
		require
			exists: not destroyed
		do
			implementation.destroy;
			implementation := Void;
		ensure
			destroyed: implementation = Void
		end

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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
