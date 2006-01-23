indexing

	description: "A tasking manager"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	TASK_I 

inherit

	G_ANY_I
		export
			{NONE} all
		end;
	
feature -- Status report

	empty: BOOLEAN is
		deferred
		end;

feature -- Status setting

	destroy is
		deferred
		end;

feature -- Element change

	add_action (a_command: COMMAND; an_argument: ANY) is
			-- Add `a_command' with `argument' to the list of action to execute-- while the system is waiting for user events.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

feature -- Removal

	remove_action (a_command: COMMAND; an_argument: ANY) is
			-- Remove `a_command' with `argument' to the list of action to
			-- execute while the system is waiting for user events.
		require
			not_a_command_void: a_command /= Void
			not empty
		deferred
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class TASK_I

