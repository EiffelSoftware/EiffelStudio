
-- Button drawn on screen with an arrow.

indexing

	status: "See notice at end of class";
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
		rename
			clean_up as button_clean_up
		export
			{NONE} all
		redefine
			text, set_text, 
			set_left_alignment, set_center_alignment
		end

	BUTTON_M
		export
			{NONE} all
		redefine
			text, set_text, clean_up,
			set_left_alignment, set_center_alignment
		select
			clean_up
		end
creation

	make

feature {NONE} -- Creation

	make (an_arrow_b: ARROW_B; man: BOOLEAN) is
			-- Create a motif arrow button.
		local
			ext_name_arrow: ANY
		do
			widget_index := widget_manager.last_inserted_position;
			ext_name_arrow := an_arrow_b.identifier.to_c;
			screen_object := create_arrow_b ($ext_name_arrow, 
					parent_screen_object (an_arrow_b, widget_index),
					man);
		end;

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

feature 

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

	arm_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when current arrow button
			-- is armed

	activate_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when current arrow button
			-- is activated

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

	create_arrow_b (a_name: POINTER; scr_obj: POINTER; 
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
