--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- TOGGLE_BG_M:

indexing

	date: "$Date$";
	revision: "$Revision$"

class TOGGLE_BG_M 

inherit

	TOGGLE_R_M
		export
            {NONE} all
        end;

	TOGGLE_BG_I
		export
			{NONE} all
		end;

	BUTTON_M
		redefine
			set_action, remove_action,
			set_background_color,
			set_foreground
		end;

	FONTABLE_M
		rename
			resource_name as MfontList
		end

creation

	make

feature -- Creation

	make (a_toggle_bg: TOGGLE_BG) is
			-- Create a motif toggle button gadget.
		local
			ext_name: ANY
		do
			ext_name := a_toggle_bg.identifier.to_c;
			screen_object := create_toggle_b_gadget ($ext_name,
					a_toggle_bg.parent.implementation.screen_object);
			a_toggle_bg.set_font_imp (Current)
		end;

feature {NONE}

	arm is
			-- Assign True to `state'.
		do
			xm_toggle_button_gadget_set_state  (screen_object, True, True)
		ensure then
			state_is_true: state
		end;

	disarm is
			-- Assign False to `state'.
		do
			xm_toggle_button_gadget_set_state (screen_object, False, True)
		ensure then
			state_is_false: not state
		end;

feature 

	add_arm_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current toggle button is armed.
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
			-- current toggle button is released.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (release_actions = Void) then
				!! release_actions.make (screen_object,
						Mdisarm, widget_oui)
			end;
			release_actions.add (a_command, argument)
		end;

	add_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when value
			-- is changed.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (value_changed_actions = Void) then
				!! value_changed_actions.make (screen_object,
						MvalueChanged, widget_oui)
			end;
			value_changed_actions.add (a_command, argument)
		end;

feature {NONE}

	arm_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when current toggle
			-- button is armed

	release_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when current toggle
			-- button is released

	value_changed_actions: EVENT_HAND_M
			-- An event handler to manage call-backs when value is changed

feature

	remove_arm_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current toggle button is armed.
		require else
			not_a_command_void: not (a_command = Void)
		do
			arm_actions.remove (a_command, argument)
		end;

	remove_release_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current toggle button is released.
		require else
			not_a_command_void: not (a_command = Void)
		do
			release_actions.remove (a_command, argument)
		end;

	remove_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- value is changed.
		require else
			not_a_command_void: not (a_command = Void)
		do
			value_changed_actions.remove (a_command, argument)
		end;

	remove_action (a_translation: STRING) is
			-- Remove the command executed when `a_translation' occurs.
			-- Do nothing if no command has been specified.
		require else
			no_translation_on_gadgets: false
		do
		end;

	set_action (a_translation: STRING; a_command: COMMAND; argument: ANY) is
			-- Set `a_command' to be executed when `a_translation' occurs.
			-- `a_translation' is specified with Xtoolkit convention.
		require else
			no_translation_on_gadgets: false
		do
		end;

	set_background_color (new_color: COLOR) is
			-- Set background color to `new_color'.
		require else
			argument_not_void: not (new_color = Void)
		do
		end;

	set_foreground (new_color: COLOR) is
			-- Set foreground color to `new_color'.
		require else
			color_not_void: not (new_color = Void)
		do
		end;

feature {NONE}

	state: BOOLEAN is
			-- State of current toggle button.
		do
			Result := xm_toggle_button_gadget_get_state (screen_object)
		end

feature {NONE} -- External features

	xm_toggle_button_gadget_set_state (scr_obj: POINTER; value1, value2: BOOLEAN) is
		external
			"C"
		end;

	xm_toggle_button_gadget_get_state (scr_obj: POINTER): BOOLEAN is
		external
			"C"
		end;

	create_toggle_b_gadget (t_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

end

