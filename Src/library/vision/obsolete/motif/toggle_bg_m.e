indexing

	description:
		"EiffelVision implementation of a Motif gadget toggle button.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	TOGGLE_BG_M 

inherit

	TOGGLE_BG_I;

	BUTTON_G_M
		rename
			is_shown as shown
		undefine
			create_callback_struct
		end;

	FONTABLE_IMP;

	MEL_TOGGLE_BUTTON_GADGET
		rename
			make as mel_toggle_make,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			is_shown as shown
		select
			mel_toggle_make
		end

creation

	make

feature {NONE} -- Initialization

	make (a_toggle_bg: TOGGLE_BG; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif toggle button gadget.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_toggle_make (a_toggle_bg.identifier, mc, man);
			a_toggle_bg.set_font_imp (Current);
			set_mnemonic_from_text (a_toggle_bg.identifier, False)
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

	set_accelerator_action (a_translation: STRING) is
			-- Set the accerlator action (modifiers and key to use as a shortcut
			-- in selecting a button) to `a_translation'.
			-- `a_translation' must be specified with the X toolkit conventions.
		do
		end

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
		end

end -- class TOGGLE_BG_M


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

