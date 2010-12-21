note

	description: "General definitions for drawable elments"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	DRAWING 

feature -- Status report

	destroyed: BOOLEAN
			-- Is current dash destroyed?
		deferred
		end;

feature -- Status setting

	clear
			-- Clear the entire area.
		require
			exists: not destroyed
		do
			implementation.clear
		end;

feature -- Access

	implementation: DRAWING_I
			-- Implementation
		deferred
		end;

feature -- Comparison

	same (other: like Current): BOOLEAN
			-- Does the current drawing and `other' share the same object
			-- on screen ?
		require
			other_exists: other /= Void
		deferred
		end;

feature -- Status setting

	set_clip (a_clip: CLIP)
			-- Set a clip area.
		require
			exists: not destroyed;
			a_clip_exists: a_clip /= Void
		do
			implementation.set_clip (a_clip)
		end;

	set_no_clip
			-- Remove all clip area.
		require
			exists: not destroyed
		do
			implementation.set_no_clip
		end;

feature -- Element change

	add_expose_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when
			-- current area is exposed.
		require
			exists: not destroyed
			not_a_command_void: a_command /= Void
		do
			implementation.add_expose_action (a_command, argument)
		end;

feature -- Removal

	remove_expose_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of action to execute when
			-- current area is exposed.
		require
			exists: not destroyed
			not_a_command_void: a_command /= Void
		do
			implementation.remove_expose_action (a_command, argument)
		end;

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




end -- class DRAWING

