
-- General button.

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class BUTTON 

inherit

	FONTABLE
		rename
			implementation as font_implementation
		end;

	PRIMITIVE
		redefine
			implementation, is_fontable
		end

feature -- Callback (adding)

	add_activate_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when current
			-- arrow button is activated.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			Valid_command: a_command /= Void
		do
			implementation.add_activate_action (a_command, argument)
		end;

	add_arm_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when current
			-- arrow button is armed.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			Valid_command: a_command /= Void
		do
			implementation.add_arm_action (a_command, argument)
		end;

	add_release_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when current
			-- arrow button is released.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			Valid_command: a_command /= Void
		do
			implementation.add_release_action (a_command, argument)
		end;

feature -- Callbacks (removing)

	remove_activate_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' with `argument' from the list of action 
			-- to be executed when current arrow button is activated.
		require
			Valid_command: a_command /= Void
		do
			implementation.remove_activate_action (a_command, argument)
		end;

	remove_arm_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' with `argument' from the list of action 
			-- to be executed when current arrow button is armed.
		require
			Valid_command: a_command /= Void
		do
			implementation.remove_arm_action (a_command, argument)
		end;

	remove_release_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' with `argument' from the list of action 
			-- to be executed when current arrow button is released.
		require
			Valid_command: a_command /= Void
		do
			implementation.remove_release_action (a_command, argument)
		end;

feature -- Resizing policies

	allow_recompute_size is
			-- Allow current button to recompute its size according to
			-- changes on its text.
		do
			implementation.allow_recompute_size
		end;

	forbid_recompute_size is
			-- Forbid current button to recompute its size according to
			-- changes on its text.
		do
			implementation.forbid_recompute_size
		end; -- forbid_recompute_size

feature -- Text 

	set_center_alignment is
			-- Set text alignment of current label to center
		do
			implementation.set_center_alignment
		end;
 
	set_left_alignment is
			-- Set text alignment of current label to left.
		do
			implementation.set_left_alignment
		end;

	text: STRING is
			-- Text of current button
		do
			Result:= implementation.text
		end; -- text

	set_text (a_text: STRING) is
			-- Set current button text to `a_text'.
		require
			not_text_void: not (a_text = Void)
		do
			implementation.set_text (a_text)
		ensure
			text.is_equal (a_text)
		end -- set_text

feature {G_ANY, G_ANY_I, WIDGET_I}

	is_fontable: BOOLEAN is true;
			-- Is current widget an heir of FONTABLE ?

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: BUTTON_I;
			-- Implementation of button

end -- class BUTTON


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
