--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

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
