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

