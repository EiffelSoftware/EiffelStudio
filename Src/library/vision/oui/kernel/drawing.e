indexing

	description: "General definitions for drawable elments";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	DRAWING 

feature -- Status report

	destroyed: BOOLEAN is
			-- Is current dash destroyed?
		deferred
		end;

feature -- Status setting

	clear is
			-- Clear the entire area.
		require
			exists: not destroyed
		do
			implementation.clear
		end;

feature -- Access

	implementation: DRAWING_I is
			-- Implementation
		deferred
		end;

feature -- Comparison

	same (other: like Current): BOOLEAN is
			-- Does the current drawing and `other' share the same object
			-- on screen ?
		require
			other_exists: other /= Void
		deferred
		end;

feature -- Status setting

	set_clip (a_clip: CLIP) is
			-- Set a clip area.
		require
			exists: not destroyed;
			a_clip_exists: a_clip /= Void
		do
			implementation.set_clip (a_clip)
		end;

	set_no_clip is
			-- Remove all clip area.
		require
			exists: not destroyed
		do
			implementation.set_no_clip
		end;

feature -- Element change

	add_expose_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current area is exposed.
		require
			exists: not destroyed
			not_a_command_void: a_command /= Void
		do
			implementation.add_expose_action (a_command, argument)
		end;

feature -- Removal

	remove_expose_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current area is exposed.
		require
			exists: not destroyed
			not_a_command_void: a_command /= Void
		do
			implementation.remove_expose_action (a_command, argument)
		end;

end -- class DRAWING



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

