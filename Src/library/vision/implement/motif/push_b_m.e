
-- PUSH_B_M: implementation of push button.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class PUSH_B_M 

inherit

	PUSH_B_I
		export
			{NONE} all
		end;

	PUSH_B_R_M
		export
			{NONE} all
		end;

	BUTTON_M
		rename
			clean_up as button_clean_up
		end;

	BUTTON_M
		redefine
			clean_up
		select
			clean_up
		end;

	FONTABLE_M
		rename
			resource_name as MfontList
		end

creation

	make

feature {NONE} -- Creation

	make (a_push_b: PUSH_B; man: BOOLEAN) is
			-- Create a motif push button.
		local
			ext_name: ANY
		do
			widget_index := widget_manager.last_inserted_position;
			ext_name := a_push_b.identifier.to_c;
			screen_object := create_push_b ($ext_name, 
				parent_screen_object (a_push_b, widget_index),
				man);
			a_push_b.set_font_imp (Current)
		end;

feature -- Insertion

	add_activate_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current push button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (activate_actions = Void) then
				!! activate_actions.make (screen_object,
						Mactivate, widget_oui)
			end;
			activate_actions.add (a_command, argument);
		end;

	add_arm_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current push button is armed.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (arm_actions = Void) then
				!! arm_actions.make (screen_object, Marm,
						widget_oui)
			end;
			arm_actions.add (a_command, argument)
		end;

	add_release_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current push button is released.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (release_actions = Void) then
				!! release_actions.make (screen_object,
						Mdisarm, widget_oui)
			end;
			release_actions.add (a_command, argument)
		end;

feature -- Deletion

	remove_activate_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current push button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			activate_actions.remove (a_command, argument)
		end;

	remove_arm_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current push button is armed.
		require else
			not_a_command_void: not (a_command = Void)
		do
			arm_actions.remove (a_command, argument)
		end;

	remove_release_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current push button is released.
		require else
			not_a_command_void: not (a_command = Void)
		do
			release_actions.remove (a_command, argument)
		end;

feature {NONE}

	activate_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when current push
			-- button is activated

	arm_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when current push
			-- button is armed

	release_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when current push
			-- button is released

	clean_up is
		do
			button_clean_up;
			if arm_actions /= Void then
				arm_actions.free_cdfd
			end;
			if release_actions /= Void then
				release_actions.free_cdfd
			end;
			if activate_actions /= Void then
				activate_actions.free_cdfd
			end;
		end

feature {NONE} -- External features

	create_push_b (p_name: POINTER; scr_obj: POINTER; 
				man: BOOLEAN): POINTER is
		external
			"C"
		end;

end



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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
