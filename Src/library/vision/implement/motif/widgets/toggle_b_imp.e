indexing

	description:
		"EiffelVision implementation of a Motif toggle button.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	TOGGLE_B_IMP

inherit

	TOGGLE_B_I
		rename
			set_accelerator_action as set_accelerator
		end;

	BUTTON_IMP
		undefine
			create_callback_struct
		end;

	FONTABLE_IMP;

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
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			is_shown as shown
		select
			mel_toggle_make
		end

creation

	make

feature {NONE} -- Creation

	make (a_toggle_b: TOGGLE_B; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif toggle button.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_toggle_make (a_toggle_b.identifier, mc, man);
			a_toggle_b.set_font_imp (Current);	
			set_mnemonic_from_text (a_toggle_b.identifier, False)
		end;

feature -- Element change

	add_arm_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when current
			-- toggle button is armed.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (arm_command);
			if list = Void then
				!! list.make;
				set_arm_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

	add_release_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when current
			-- toggle button is released.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (disarm_command);
			if list = Void then
				!! list.make;
				set_disarm_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

	add_activate_action, add_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when value
			-- is changed.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (value_changed_command);
			if list = Void then
				!! list.make;
				set_value_changed_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

feature -- Removal

	remove_arm_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current toggle button is armed.
		do
			remove_command (arm_command, a_command, argument)
		end;

	remove_release_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current toggle button is released.
		do
			remove_command (disarm_command, a_command, argument)
		end;

	remove_activate_action, remove_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- value is changed.
		do
			remove_command (value_changed_command, a_command, argument)
		end;

	remove_accelerator_action is
			-- Remove the accelerator action.
		do
			set_accelerator (Void)
		end;

end -- class TOGGLE_B_IMP


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

