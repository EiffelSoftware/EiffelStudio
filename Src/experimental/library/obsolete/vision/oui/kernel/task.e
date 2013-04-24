note

	description:
		"A tasking manager. %
		%This class should be used for executing long tasks whithout interfering %
		%with events system (otherwise the events will be put in a stack and wait %
		%until the task is finished, windows will not be redrawn for instance). %
		%This can be used for background tasks too"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
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

	make
			-- Create a task.
		do
			create {TASK_IMP} implementation.make 
		end;

feature -- Status report

	destroyed: BOOLEAN
		do
			Result := implementation = Void
		end;

	empty: BOOLEAN
		require
			exists: not destroyed
		do
			Result := implementation.empty
		end;

feature -- Status setting

	destroy 
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

	add_action (a_command: COMMAND; an_argument: ANY)
			-- Add `a_command' with `argument' to the list of action to execute
			-- while the system is waiting for user events.
		require
			exists: not destroyed;
			not_a_command_void: a_command /= Void
		do
			implementation.add_action (a_command, an_argument)
		end;

feature -- Removal

	remove_action (a_command: COMMAND; an_argument: ANY)
			-- Remove `a_command' with `argument' to the list of action to
			-- execute while the system is waiting for user events.
		require
			exists: not destroyed;
			not_a_command_void: a_command /= Void
		do
			implementation.remove_action (a_command, an_argument)
		end;

feature {NONE} -- Implementation

	implementation: TASK_I;;
			-- Implementation of task

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class TASK

