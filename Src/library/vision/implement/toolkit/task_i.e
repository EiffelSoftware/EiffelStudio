indexing

	description: "A tasking manager";
	status: "See notice at end of class";
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

end -- class TASK_I

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

