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

class

	TASK 

inherit

	G_ANY
		export
			{NONE} all
		end

create

	make

feature -- Initialization

	make is
			-- Create a task.
		do
			create {TASK_IMP} implementation.make 
		end;

feature -- Status report

	destroyed: BOOLEAN is
		do
			Result := implementation = Void
		end;

	empty: BOOLEAN is
		require
			exists: not destroyed
		do
			Result := implementation.empty
		end;

feature -- Status setting

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

feature -- Element change

	add_action (a_command: COMMAND; an_argument: ANY) is
			-- Add `a_command' with `argument' to the list of action to execute
			-- while the system is waiting for user events.
		require
			exists: not destroyed;
			not_a_command_void: a_command /= Void
		do
			implementation.add_action (a_command, an_argument)
		end;

feature -- Removal

	remove_action (a_command: COMMAND; an_argument: ANY) is
			-- Remove `a_command' with `argument' to the list of action to
			-- execute while the system is waiting for user events.
		require
			exists: not destroyed;
			not_a_command_void: a_command /= Void
		do
			implementation.remove_action (a_command, an_argument)
		end;

feature {NONE} -- Implementation

	implementation: TASK_I;
			-- Implementation of task

end -- class TASK

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

