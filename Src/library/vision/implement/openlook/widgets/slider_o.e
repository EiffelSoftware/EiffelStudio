indexing

	description: "Implementation superclass of a scale and a scrollbar";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SLIDER_O 

inherit

	SLIDER_R_O
		export
			{NONE} all
		end;

	PRIMITIVE_O
		export
			{NONE} all
		end;
	
feature {NONE}

	update_event_handlers is
		local
			new_button_press_actions: BUT_HAND_X;
			new_button_release_actions: BUT_HAND_X;
			new_enter_actions: ENTER_HAND_X;
			new_button_motion_actions: BUTMT_HAND_X;
			new_destroy_actions: EVENT_HAND_O;
			new_key_press_actions: KEY_HAND_X;
			new_key_release_actions: KEY_HAND_X;
			new_leave_actions: LEAVE_HAND_X;
			new_pointer_motion_actions: MOT_HAND_X;
			new_move_actions: EVENT_HAND_O;
			new_value_changed_actions: EVENT_HAND_O;
		do
                      	if not (button_press_actions = Void) then
                              	!!new_button_press_actions.make (action_target, true, widget_oui);
				new_button_press_actions.copy (button_press_actions);
				button_press_actions := new_button_press_actions;	
                       	end;
                       	if not (enter_actions = Void) then
                              	!!new_enter_actions.make (action_target, widget_oui);
				new_enter_actions.copy (enter_actions);
				enter_actions := new_enter_actions;	
                     	end;
			if not (button_motion_actions = Void) then
				!!new_button_motion_actions.make (action_target, widget_oui);
				new_button_motion_actions.copy (button_motion_actions);
				button_motion_actions := new_button_motion_actions;	
			end;
			if not (button_release_actions = Void) then
				!!new_button_release_actions.make (action_target, false, widget_oui);
				new_button_release_actions.copy (button_release_actions);
				button_release_actions := new_button_release_actions;	
			end;
			if not (destroy_actions = Void) then
				!!new_destroy_actions.make (action_target, Odestroy, widget_oui);
				new_destroy_actions.copy (destroy_actions);
				destroy_actions := new_destroy_actions;	
			end;
			if not (key_press_actions = Void) then
				!!new_key_press_actions.make (action_target, true, widget_oui);
				new_key_press_actions.copy (key_press_actions);
				key_press_actions := new_key_press_actions;	
			end;
			if not (key_release_actions = Void) then
				!!new_key_release_actions.make (action_target, false, widget_oui);
				new_key_release_actions.copy (key_release_actions);
				key_release_actions := new_key_release_actions;	
			end;
			if not (leave_actions = Void) then
				!!new_leave_actions.make (action_target, widget_oui);
				new_leave_actions.copy (leave_actions);
				leave_actions := new_leave_actions;	
			end;
			if not (pointer_motion_actions = Void) then
				!!new_pointer_motion_actions.make (action_target, widget_oui);
				new_pointer_motion_actions.copy (pointer_motion_actions);
				pointer_motion_actions := new_pointer_motion_actions;	
			end;
			if not (move_actions = Void) then
				!!new_move_actions.make (screen_object, Odrag, widget_oui);
				new_move_actions.copy (move_actions);
				move_actions := new_move_actions;	
			end;
			if not (value_changed_actions = Void) then
				!!new_value_changed_actions.make (screen_object, Odrag, widget_oui);
				new_value_changed_actions.copy (value_changed_actions);
				value_changed_actions := new_value_changed_actions;	
			end;
 		end;

	add_move_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when slide
			-- is moved.
		require
			not_a_command_void: not (a_command = Void)
		do
			if (move_actions = Void) then
				!!move_actions.make (screen_object, Odrag, widget_oui)
			end;
			move_actions.add (a_command, argument)
		end; 

	add_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when value
			-- is changed.
		require
			not_a_command_void: not (a_command = Void)
		do
			if (value_changed_actions = Void) then
				!!value_changed_actions.make (screen_object, Odrag, widget_oui)
			end;
			value_changed_actions.add (a_command, argument)
		end;

	granularity: INTEGER is
			-- Value of the amount to move the slider and modifie the
			-- slide position value when a move action occurs
		do
			Result := xt_int (screen_object, Ogranularity)
		ensure
			granularity_large_enough: Result >= 1;
			granularity_small_enough: Result <= (maximum - minimum)
		end;

	is_horizontal: BOOLEAN;
			-- Is scale orientation horizontal?

	is_maximum_right_bottom: BOOLEAN is
			-- Is maximum value on the right side when orientation
			-- is horizontal or on the bottom side when orientation
			-- is vertical?
		local
			side: INTEGER
		do
		end;

	is_output_only: BOOLEAN is
			-- Is scale mode output only mode?
		
		do
			Result := xt_is_sensitive (screen_object)
		end;

	is_value_shown: BOOLEAN is
			-- Is value shown on the screen?
		do
		end; 

	maximum: INTEGER is
			-- Maximum value of the slider
		do
			Result := xt_int (screen_object, Omaximum)
		ensure
			maximum_greater_than_minimum: Result > minimum
		end; 

	minimum: INTEGER is
			-- Minimum value of the slider
		do
			Result := xt_int (screen_object, Ominimum)
		ensure
			minimum_smaller_than_maximum: Result < maximum
		end; 

	move_actions: EVENT_HAND_O;
			-- An event handler to manage call-backs when slide is moved

	remove_move_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- slide is moved.
		require
			not_a_command_void: not (a_command = Void)
		do
			move_actions.remove (a_command, argument)
		end; 

	remove_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- value is changed.
		require
			not_a_command_void: not (a_command = Void)
		do
			value_changed_actions.remove (a_command, argument)
		end;

	set_granularity (new_granularity: INTEGER) is
			-- Set amount to move the slider and modifie value when
			-- when a move action occurs to `new_granularity'.
		require
			granularity_large_enough: new_granularity >= 1;
			granularity_small_enough: new_granularity <= (maximum - minimum)
		do
			set_xt_int (screen_object, new_granularity, Ogranularity);
		ensure
			granularity = new_granularity
		end;

	set_maximum (new_maximum: INTEGER) is
			-- Set maximum value of the slider to `new_maximum'.
		require
			maximum_greater_than_minimum: new_maximum > minimum
		do
			set_xt_int (screen_object, new_maximum, Omaximum)
		ensure
			maximum = new_maximum
		end;

	set_maximum_right_bottom (flag: BOOLEAN) is
			-- Set maximum value on the right side when orientation
			-- is horizontal or on the bottom side when orientation
			-- is vertical if `flag', and at the opposite side otherwise.
		do
		end; 

	set_minimum (new_minimum: INTEGER) is
			-- Set minimum value of the slider to `new_minimum'.
		require
			minimum_smaller_than_maximum: new_minimum < maximum
		do
			set_xt_int (screen_object, new_minimum, Ominimum)
		ensure
			minimum = new_minimum
		end;

	set_output_only (flag: BOOLEAN) is
            		-- Set scale mode to output only if `flag' and to input/output
            		-- otherwise.
		
        	do
			if flag then
				xt_set_sensitive (screen_object, False)
			else
				xt_set_sensitive (screen_object, True)
			end
        	ensure
            		output_only: is_output_only = flag
        	end;

	set_text (a_text: STRING) is
			-- Set scale text to `a_text'.
		require
			not_text_void: not (a_text = Void)
		do
			set_xt_string (screen_object, a_text, OminLabel);
		ensure
			text.is_equal (a_text)
		end;

	set_value (new_value: INTEGER) is
			-- Set value to `new_value'.
		require
			value_small_enough: new_value <= maximum;
			value_large_enough: new_value >= minimum
		do
			set_xt_int (screen_object, new_value, Ovalue);
			if not (value_changed_actions = Void) then 
				value_changed_actions.call_back (widget_oui)
			end
		ensure
			value = new_value
		end;

	show_value (flag: BOOLEAN) is
            		-- Show scale value on the screen if `flag', hide it otherwise.
        	do
        	end; 

	text: STRING is
			-- Scale text
		do
			Result := xt_string (screen_object, OminLabel)
		end;

	value: INTEGER is
			-- Value of the current slider position along the scale
		do
			Result := xt_int (screen_object, Ovalue)
		ensure
			value_large_enough: Result >= minimum;
			value_small_enough: Result <= maximum
		end;

	value_changed_actions: EVENT_HAND_O;
			-- An event handler to manage call-backs when value is changed

    font: FONT;
    		-- Font name of label

  	set_font (a_font: FONT) is
           	-- Set font label to `a_font'.
		do
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
