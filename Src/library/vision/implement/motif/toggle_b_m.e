indexing

	description:
		"EiffelVision implementation of a Motif toggle button.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	TOGGLE_B_M

inherit

	TOGGLE_B_I;

	BUTTON_M
		undefine
			create_callback_struct
		end;

	FONTABLE_M;

	MEL_TOGGLE_BUTTON
		rename
			make as mel_toggle_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			screen as mel_screen
		select
			mel_toggle_make
		end

creation

	make

feature {NONE} -- Creation

	make (a_toggle_b: TOGGLE_B; man: BOOLEAN) is
			-- Create a motif toggle button.
		do
			widget_index := widget_manager.last_inserted_position;
			mel_toggle_make (a_toggle_b.identifier,
					mel_parent (a_toggle_b, widget_index),
					man);
			a_toggle_b.set_font_imp (Current)
		end;

feature -- Element change

	add_arm_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when current
			-- toggle button is armed.
		do
			add_arm_callback (mel_vision_callback (a_command), argument)
		end;

	add_release_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when current
			-- toggle button is released.
		do
			add_disarm_callback (mel_vision_callback (a_command), argument)
		end;

	add_activate_action, add_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when value
			-- is changed.
		do
			add_value_changed_callback (mel_vision_callback (a_command), argument)
		end;

feature -- Removal

	remove_arm_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current toggle button is armed.
		do
			remove_arm_callback (mel_vision_callback (a_command), argument)
		end;

	remove_release_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current toggle button is released.
		do
			remove_disarm_callback (mel_vision_callback (a_command), argument)
		end;

	remove_activate_action, remove_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- value is changed.
		do
			remove_value_changed_callback (mel_vision_callback (a_command), argument)
		end;

end -- class TOGGLE_B_M

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
