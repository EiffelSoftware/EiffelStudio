indexing

	description: 
		"EiffelVision implementation of a Motif push button.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	PUSH_B_IMP

inherit

	PUSH_B_I
		rename
			set_accelerator_action as set_accelerator
		end;

	BUTTON_IMP
		undefine
			create_callback_struct
		end;

	FONTABLE_IMP;

	MEL_PUSH_BUTTON
		rename
			make as mel_pb_make,
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
			mel_pb_make
		end

create

	make

feature {NONE} -- Initialization

	make (a_push_b: PUSH_B; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif push button.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_pb_make (a_push_b.identifier, mc, man);
			a_push_b.set_font_imp (Current);	
			set_mnemonic_from_text (a_push_b.identifier, False)
		end;

feature -- Element change

	add_activate_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current push button is activated.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (activate_command);
			if list = Void then
				create list.make;
				set_activate_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

	add_arm_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current push button is armed.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (arm_command);
			if list = Void then
				create list.make;
				set_arm_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

	add_release_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current push button is released.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (disarm_command);
			if list = Void then
				create list.make;
				set_disarm_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

feature -- Removal

	remove_activate_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current push button is activated.
		do
			remove_command (activate_command, a_command, argument)
		end;

	remove_arm_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current push button is armed.
		do
			remove_command (arm_command, a_command, argument)
		end;

	remove_release_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current push button is released.
		do
			remove_command (disarm_command, a_command, argument)
		end;

	remove_accelerator_action is
			-- Remove the accelerator action.
		do
			set_accelerator (Void)
		end;

end -- class PUSH_B_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

