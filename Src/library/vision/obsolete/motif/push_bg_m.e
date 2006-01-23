indexing

	description: 
		"EiffelVision implementation of Motif gadget push button."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 
	PUSH_BG_M 

inherit

	PUSH_BG_I;

	BUTTON_G_M
		undefine
			create_callback_struct
		end;

	FONTABLE_IMP;

	MEL_PUSH_BUTTON_GADGET
		rename
			make as mel_pb_make,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			is_shown as shown
		select
			mel_pb_make, shown
		end

create

	make

feature {NONE} -- Initialization

	make (a_push_bg: PUSH_BG; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif push button gadget.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_pb_make (a_push_bg.identifier, mc, man);
			a_push_bg.set_font_imp (Current);
			set_mnemonic_from_text (a_push_bg.identifier, False)
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

	set_accelerator_action (a_translation: STRING) is
			-- Set the accerlator action (modifiers and key to use as a shortcut
			-- in selecting a button) to `a_translation'.
			-- `a_translation' must be specified with the X toolkit conventions.
		do
		end

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




end -- class PUSH_BG_M

