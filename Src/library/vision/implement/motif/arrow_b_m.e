--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Button drawn on screen with an arrow.

indexing

	date: "$Date$";
	revision: "$Revision$"

class ARROW_B_M 

inherit

	ARROW_B_I;

	ARROW_B_R_M
		export
			{NONE} all
		end;

	BUTTON_M
		export
			{NONE} all
		redefine
            text, set_text, 
			set_left_alignment, set_center_alignment
		end

creation

	make

feature {NONE}

	activate_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when current arrow button
			-- is activated

feature 

	add_activate_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when current
			-- arrow button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (activate_actions = Void) then
				!! activate_actions.make (screen_object, Mactivate, widget_oui)
			end;
			activate_actions.add (a_command, argument)
		end;

	add_arm_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when current
			-- arrow button is armed.
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
			-- arrow button is released.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (release_actions = Void) then
				!! release_actions.make (screen_object, Mdisarm, widget_oui)
			end;
			release_actions.add (a_command, argument)
		end;

feature {NONE}

	arm_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when current arrow button
			-- is armed

feature 

	make (an_arrow_b: ARROW_B) is
			-- Create a motif arrow button.
		local
			ext_name_arrow: ANY
		do
			ext_name_arrow := an_arrow_b.identifier.to_c;
			screen_object := create_arrow_b ($ext_name_arrow, an_arrow_b.parent.implementation.screen_object)
		end;

	down: BOOLEAN is
			-- Is the arrow direction down ?
		do
			Result := ARROW_DOWN = xt_unsigned_char (screen_object, MArrowDirection)
		end;

	left: BOOLEAN is
			-- Is the arrow direction left ?
		do
			Result := ARROW_LEFT = xt_unsigned_char (screen_object, MArrowDirection)
		end;

feature -- Text (do nothing) {NONE}

	font: FONT is
			-- Font of arrow button
		require else
			font_non_supported_for_arrow_button: false
		do
		end;

	set_font (f: FONT) is
			-- Font of arrow button
		require else
			set_font_non_supported_for_arrow_button: false
		do
		end;

	text: STRING is
			-- Text of current button
		require else
			text_non_supported_for_arrow_button: false
		do
		end;

	set_text (a_text: STRING) is
			-- Set current button text to `a_text'.
		require else
			text_non_supported_for_arrow_button: false
		do
		end;

	set_left_alignment is
			--	Set text alignment to left. 
		require else
			left_alignment_supported_for_arrow_button: false
		do
		end; -- set_text

	set_center_alignment is
			--	Set text alignment to center. 
		require else
			center_alignment_supported_for_arrow_button: false
		do
		end; -- set_text

feature {NONE}

	release_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when current arrow button
			-- is released

feature 

	remove_activate_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current arrow button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			activate_actions.remove (a_command, argument)
		end; -- remove_activate_action

	remove_arm_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current arrow button is armed.
		require else
			not_a_command_void: not (a_command = Void)
		do
			arm_actions.remove (a_command, argument)
		end; -- remove_arm_action

	remove_release_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current arrow button is released.
		require else
			not_a_command_void: not (a_command = Void)
		do
			release_actions.remove (a_command, argument)
		end; -- remove_release_action

	right: BOOLEAN is
			-- Is the arrow direction right ?
		do
			Result := ARROW_RIGHT = xt_unsigned_char (screen_object, MArrowDirection)
		end; -- right

	set_down is
			-- Set the arrow direction to down.
		do
			set_xt_unsigned_char (screen_object, ARROW_DOWN, MarrowDirection)
		end; -- set_down

	set_left is
			-- Set the arrow direction to left.
		do
			set_xt_unsigned_char (screen_object, ARROW_LEFT, MarrowDirection)
		end; -- set_left

	set_right is
			-- Set the arrow direction to right.
		do
			set_xt_unsigned_char (screen_object, ARROW_RIGHT, MarrowDirection)
		end; -- set_right

	set_up is
			-- Set the arrow direction to up.
		do
			set_xt_unsigned_char (screen_object, ARROW_UP, MarrowDirection)
		end; -- set_up

	up: BOOLEAN is
			-- Is the arrow direction up ?
		do
			Result := ARROW_UP = xt_unsigned_char (screen_object, MArrowDirection)
		end;

feature {NONE} -- External features

	create_arrow_b (a_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

end

