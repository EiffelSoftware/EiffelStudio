indexing

	description: "General drawing area implementation"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	DRAWING_AREA_I 

inherit

	PRIMITIVE_I;

	DRAWING_I
	
feature -- Element change

	add_input_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- a key is pressed or when a mouse button is pressed.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	add_resize_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current area is resized.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

feature -- Removal

	remove_input_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- a key is pressed or when a mouse button is pressed.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_resize_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current area is resized.
		require
			not_a_command_void: a_command /= Void
		deferred
		end

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




end -- class DRAWING_AREA_I

