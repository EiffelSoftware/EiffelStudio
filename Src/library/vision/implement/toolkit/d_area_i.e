indexing

	description: "General drawing area implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	D_AREA_I 

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

end -- class D_AREA_I

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

