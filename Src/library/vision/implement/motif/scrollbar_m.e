
-- Motif implementation of scrollbar.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SCROLLBAR_M 

inherit

	SCROLLBAR_I;

	SCROLLBAR_R_M
		export
			{NONE} all
		end;

	PRIMITIVE_M
		export
			{NONE} all
		end

creation

	make

feature 

	add_move_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when slide
			-- is moved.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (move_actions = Void) then
				!! move_actions.make (screen_object, Mdrag, widget_oui)
			end;
			move_actions.add (a_command, argument)
		end; -- add_move_action

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

	make (a_scrollbar: SCROLLBAR) is
			-- Create a motif scrollbar.
		local
			ext_name: ANY
		do
			ext_name := a_scrollbar.identifier.to_c;
			screen_object := create_scrollbar ($ext_name, 
						a_scrollbar.parent.implementation.screen_object)
		end;

	granularity: INTEGER is
			-- Value of the amount to move the slider and modifie the
			-- slide position value when a move action occurs
		do
			Result := xt_int (screen_object, Mincrement)
		ensure then
			granularity_large_enough: Result >= 1;
			granularity_small_enough: Result <= (maximum - minimum)
		end;

	initial_delay: INTEGER is
			-- Amount of time to wait (milliseconds) before starting
			-- continuous slider movement
		do
			Result := xt_int (screen_object, MinitialDelay)
		ensure then
			positive_value: Result > 0
		end;

	is_horizontal: BOOLEAN is
			-- Is scrollbar orientation horizontal?
		do
			Result := xt_unsigned_char (screen_object, Morientation) = MHORIZONTAL
		end;

	is_maximum_right_bottom: BOOLEAN is
			-- Is maximum value on the right side when orientation
			-- is horizontal or on the bottom side when orientation
			-- is vertical?
		local
			side: INTEGER
		do
			side := xt_unsigned_char (screen_object, MprocessingDirection);
			Result := (side = MMAX_ON_BOTTOM) or (side = MMAX_ON_RIGHT)
		end;

	maximum: INTEGER is
			-- Maximum value of slider position
		do
			Result := xt_int (screen_object, Mmaximum)
		ensure then
			maximum_greater_than_mini: Result > minimum
		end;

	minimum: INTEGER is
			-- Minimum value of slider position
		do
			Result := xt_int (screen_object, Mminimum)
		ensure then
			minimum_smaller_than_maxi: Result < maximum
		end;

feature {NONE}

	move_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when slide is moved

feature 

	position: INTEGER is
			-- Slider position
		do
			Result := xt_int (screen_object, Mvalue)
		ensure then
			position_large_enough: Result >= minimum;
			position_small_enough: Result <= maximum
		end;

	remove_move_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- slide is moved.
		require else
			not_a_command_void: not (a_command = Void)
		do
			move_actions.remove (a_command, argument)
		end;

	remove_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- value is changed.
		require else
			not_a_command_void: not (a_command = Void)
		do
			value_changed_actions.remove (a_command, argument)
		end;

	repeat_delay: INTEGER is
			-- Amount of time to wait (milliseconds) between subsequent
			-- slider movements after the initial delay
		do
			Result := xt_int (screen_object, MrepeatDelay)
		ensure then
			positive_delay: Result > 0
		end;

	set_granularity (new_granularity: INTEGER) is
			-- Set amount to move the slider and modifie the slide
			-- position value when a move action occurs to `new_granularity'.
		require else
			granularity_large_enough: new_granularity >= 1;
			granularity_small_enough: new_granularity <= (maximum - minimum)
		do
			set_xt_int (screen_object, new_granularity, Mincrement)
		ensure then
			granularity = new_granularity
		end;

	set_horizontal (flag: BOOLEAN) is
            -- Set orientation of the scale to horizontal if `flag',
            -- to vertical otherwise.
        do
            if flag then
                set_xt_unsigned_char (screen_object, MHORIZONTAL, Morientation)
            else
                set_xt_unsigned_char (screen_object, MVERTICAL, Morientation)
            end
        ensure then
            value_correctly_set: is_horizontal = flag
        end;

	set_initial_delay (new_delay: INTEGER) is
			-- Set the amount of time to wait (milliseconds) before
			-- starting continuous slider movement to `new_delay'.
		require else
			positive_delay: new_delay > 0
		do
			set_xt_int (screen_object, new_delay, MinitialDelay)
		ensure then
			initial_delay = new_delay
		end;

	set_maximum (new_maximum: INTEGER) is
			-- Set maximum value of slider position to `new_maximum'.
		require else
			maximum_greater_than_mini: new_maximum > minimum
		do
			set_xt_int (screen_object, new_maximum, Mmaximum)
		ensure then
			maximum = new_maximum
		end;

	set_maximum_right_bottom (flag: BOOLEAN) is
            -- Set maximum value on the right side when orientation
            -- is horizontal or on the bottom side when orientation
            -- is vertical if `flag', and at the opposite side otherwise.
        do
            if flag then
                if is_horizontal then
                    set_xt_unsigned_char (screen_object, MMAX_ON_RIGHT, MprocessingDirection)
                else
                    set_xt_unsigned_char (screen_object, MMAX_ON_BOTTOM, MprocessingDirection)
                end
            else
                if is_horizontal then
                    set_xt_unsigned_char (screen_object, MMAX_ON_LEFT, MprocessingDirection)
                else
                    set_xt_unsigned_char (screen_object, MMAX_ON_TOP, MprocessingDirection)                end
            end
        ensure then
            maximum_value_on_right_bottom: is_maximum_right_bottom = flag
        end;

	set_minimum (new_minimum: INTEGER) is
			-- Set minimum value of slider position to `new_minimum'.
		require else
			minimum_smaller_than_maxi: new_minimum < maximum
		do
			set_xt_int (screen_object, new_minimum, Mminimum)
		ensure then
			minimum = new_minimum
		end;

	set_position (new_position: INTEGER) is
			-- Set slider position to `new_position'.
		require else
			position_small_enough: new_position <= maximum;
			position_large_enough: new_position >= minimum
		do
			set_xt_int (screen_object, new_position, Mvalue)
		ensure then
			position = new_position
		end;

	set_repeat_delay (new_delay: INTEGER) is
			-- Set the amount of time to wait (milliseconds) between
			-- subsequent movements after the initial delay to 'new_delay'.
		require else
			positive_delay: new_delay > 0
		do
			set_xt_int (screen_object, new_delay, MrepeatDelay)
		ensure then
			repeat_delay = new_delay
		end;

	set_slider_size (new_size: INTEGER) is
			-- Set size of slider to 'new_size'.
		require else
			new_size_small_enough: new_size <= (maximum - minimum);
			new_size_large_enough: new_size >= 0
		do
			set_xt_int (screen_object, new_size, MsliderSize)
		ensure then
			slider_size = new_size
		end;

	slider_size: INTEGER is
			-- Size of slider.
		do
			Result := xt_int (screen_object, MsliderSize)
		ensure then
			slider_size_small_enough: Result <= (maximum - minimum);
			slider_size_large_enough: Result >= 0
		end;

feature {NONE}

	value_changed_actions: EVENT_HAND_M

feature {NONE} -- External features

	create_scrollbar (s_name: ANY; scr_obj: POINTER): POINTER is
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
