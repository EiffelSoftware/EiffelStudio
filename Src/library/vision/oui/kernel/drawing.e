
-- General definitions for drawable elments.

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class DRAWING 

feature 

	same (other: like Current): BOOLEAN is
            -- Does the current drawing and `other' share the same object
            -- on screen ?
        require
            other_exists: not (other = Void)
        deferred
        end;

	add_expose_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current area is exposed.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.add_expose_action (a_command, argument)
		end;

	clear is
			-- Clear the entire area.
		do
			implementation.clear
		end;

	implementation: DRAWING_I is
			-- Implementation
		deferred
		end;

	remove_expose_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current area is exposed.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.remove_expose_action (a_command, argument)
		end;

	set_clip (a_clip: CLIP) is
			-- Set a clip area.
		require
			a_clip_exists: not (a_clip = Void)
		do
			implementation.set_clip (a_clip)
		end;

	set_no_clip is
			-- Remove all clip area.
		do
			implementation.set_no_clip
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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
