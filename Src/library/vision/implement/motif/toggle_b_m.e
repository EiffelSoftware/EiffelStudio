
indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class TOGGLE_B_M

inherit

	TOGGLE_R_M
		export
			{NONE} all
		end;

	TOGGLE_B_I
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

	make (a_toggle_b: TOGGLE_B) is
            -- Create a motif toggle button.
        local
            ext_name: ANY
        do
            ext_name := a_toggle_b.identifier.to_c;
            screen_object := create_toggle_b ($ext_name,
				a_toggle_b.parent.implementation.screen_object);
            a_toggle_b.set_font_imp (Current)
        end;

feature 

	add_arm_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when current
			-- toggle button is armed.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (arm_actions = Void) then
				!! arm_actions.make (screen_object, Marm, widget_oui)
			end;
			arm_actions.add (a_command, argument)
		end;

	add_release_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when current
			-- toggle button is released.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (release_actions = Void) then
				!! release_actions.make (screen_object, Mdisarm, widget_oui)
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
				!! value_changed_actions.make (screen_object, MvalueChanged, widget_oui)
			end;
			value_changed_actions.add (a_command, argument)
		end;

feature {NONE}

	arm_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when current toggle button
			-- is armed

	release_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when current toggle button
			-- is released

    value_changed_actions: EVENT_HAND_M;
            -- An event handler to manage call-backs when value is changed

feature

    set_toggle_on is
            -- Set Current toggle on and set
            -- state to True.
        do
            xm_toggle_button_set_state (screen_object, True, False)
        end;

    set_toggle_off is
            -- Set Current toggle off and set
            -- state to False.
        do
            xm_toggle_button_set_state (screen_object, False, False)
        end;

    arm is
            -- Set `state' to True and call
            -- callback (if set).
        do
            xm_toggle_button_set_state (screen_object, True, True)
        ensure then
            state_is_true: state
        end;

    disarm is
            -- Set `state' to False and call
            -- callback (if set).
        do
            xm_toggle_button_set_state (screen_object, False,
					True)
        ensure then
            state_is_false: not state
        end;

    state: BOOLEAN is
            -- State of current toggle button.
        do
            Result := xm_toggle_button_get_state (screen_object)
        end;

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

feature {NONE} -- External features

    xm_toggle_button_set_state (scr_obj: POINTER; value1, value2: BOOLEAN) is
       external
            "C"
        end;

    xm_toggle_button_get_state (scr_obj: POINTER): BOOLEAN is
        external
            "C"
        end;

    create_toggle_b (t_name: ANY; scr_obj: POINTER): POINTER is
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
