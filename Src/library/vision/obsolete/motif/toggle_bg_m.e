indexing

	description:
		"EiffelVision implementation of a Motif gadget toggle button.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class TOGGLE_BG_M 

inherit

	TOGGLE_BG_I;

	BUTTON_G_M
		undefine
			create_callback_struct
		end;

	FONTABLE_M;

	MEL_TOGGLE_BUTTON_GADGET
		rename
			make as mel_toggle_make,
			destroy as mel_destroy,
			screen as mel_screen
		select
			mel_toggle_make
		end


creation

	make

feature {NONE} -- Initialization

	make (a_toggle_bg: TOGGLE_BG; man: BOOLEAN) is
			-- Create a motif toggle button gadget.
		do
			widget_index := widget_manager.last_inserted_position;
			mel_toggle_make (a_toggle_bg.identifier,
					mel_parent (a_toggle_bg, widget_index),
					man);
			a_toggle_bg.set_font_imp (Current)
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

end -- class TOGGLE_BG_M

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
