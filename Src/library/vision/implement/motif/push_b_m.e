--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                      (805) 685-1006                                --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- PUSH_B_M: implementation of push button.

indexing

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

	BUTTON_M;

	FONTABLE_M
		rename
			resource_name as MfontList
		end

creation

	make

feature -- Creation

	make (a_push_b: PUSH_B) is
			-- Create a motif push button.
		local
			ext_name: ANY
		do
			ext_name := a_push_b.identifier.to_c;
			screen_object := create_push_b ($ext_name, a_push_b.parent.implementation.screen_object);
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

feature {NONE} -- External features

	create_push_b (p_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

end

