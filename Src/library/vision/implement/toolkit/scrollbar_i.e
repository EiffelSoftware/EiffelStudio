indexing

	description: "Deferred implementation of scrollbar";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class SCROLLBAR_I 

inherit

	PRIMITIVE_I
	
feature 

	add_move_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when slide
			-- is moved.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- add_move_action

	add_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when value
			-- is changed.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- add_value_changed_action

	granularity: INTEGER is
			-- Value of the amount to move the slider and modifie the
			-- slide position value when a move action occurs
		deferred
		ensure
			granularity_large_enough: Result >= 1;
			granularity_small_enough: Result <= (maximum - minimum)
		end; -- granularity

	initial_delay: INTEGER is
			-- Amount of time to wait (milliseconds) before starting
			-- continuous slider movement
		deferred
		ensure
			positive_value: Result > 0
		end; -- initial_delay

	is_horizontal: BOOLEAN is
			-- Is scrollbar oriented horizontal?
		deferred
		end; -- is_horizontal

	is_maximum_right_bottom: BOOLEAN is
			-- Is maximum value on the right side when orientation
			-- is horizontal or on the bottom side when orientation
			-- is vertical?
		deferred
		end; -- is_maximum_right_bottom

	maximum: INTEGER is
			-- Maximum value of slider position
		deferred
		ensure
			maximum_greater_than_mini: Result > minimum
		end; -- maximum

	minimum: INTEGER is
			-- Minimum value of slider position
		deferred
		ensure
			minimum_smaller_than_maxi: Result < maximum
		end; -- minimum

	position: INTEGER is
			-- Slider position
		deferred
		ensure
			position_large_enough: Result >= minimum;
			position_small_enough: Result <= maximum
		end; -- position

	remove_move_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- slide is moved.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- remove_value_changed_action

	remove_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- value is changed.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- remove_value_changed_action

	repeat_delay: INTEGER is
			-- Amount of time to wait (milliseconds) between subsequent
			-- slider movements after the initial delay
		deferred
		ensure
			positive_delay: Result > 0
		end; -- repeat_delay

	set_granularity (new_granularity: INTEGER) is
			-- Set amount to move the slider and modifie the slide
			-- position value when a move action occurs to `new_granularity'.
		require
			granularity_large_enough: new_granularity >= 1;
			granularity_small_enough: new_granularity <= (maximum - minimum)
		deferred
		ensure
			granularity = new_granularity
		end; -- set_granularity

	set_horizontal (flag: BOOLEAN) is
            -- Set orientation of the scale to horizontal if `flag',
            -- to vertical otherwise.
        deferred
        ensure
            value_correctly_set: is_horizontal = flag
        end; -- set_horizontal

	set_initial_delay (new_delay: INTEGER) is
			-- Set the amount of time to wait (milliseconds) before
			-- starting continuous slider movement to `new_delay'.
		require
			positive_delay: new_delay > 0
		deferred
		ensure
			initial_delay = new_delay
		end; -- set_initial_delay

	set_maximum (new_maximum: INTEGER) is
			-- Set maximum value of slider position to `new_maximum'.
		require
			maximum_greater_than_mini: new_maximum > minimum
		deferred
		ensure
			maximum = new_maximum
		end; -- set_maximum

	set_maximum_right_bottom (flag: BOOLEAN) is
            -- Set maximum value on the right side when orientation
            -- is horizontal or on the bottom side when orientation
            -- is vertical if `flag', and at the opposite side otherwise.
        deferred
        ensure
            maximum_value_on_right_bottom: is_maximum_right_bottom = flag
        end;

	set_minimum (new_minimum: INTEGER) is
			-- Set minimum value of slider position to `new_minimum'.
		require
			minimum_smaller_than_maxi: new_minimum < maximum
		deferred
		ensure
			minimum = new_minimum
		end;

	set_position (new_position: INTEGER) is
			-- Set slider position to `new_position'.
		require
			position_small_enough: new_position <= maximum;
			position_large_enough: new_position >= minimum
		deferred
		ensure
			position = new_position
		end;

	set_repeat_delay (new_delay: INTEGER) is
			-- Set the amount of time to wait (milliseconds) between
			-- subsequent movements after the initial delay to 'new_delay'.
		require
			positive_delay: new_delay > 0
		deferred
		ensure
			repeat_delay = new_delay
		end; -- set_repeat_delay

	set_slider_size (new_size: INTEGER) is
			-- Set size of slider to 'new_size'.
		require
			new_size_small_enough: new_size <= (maximum - minimum);
			new_size_large_enough: new_size >= 0
		deferred
		ensure
			slider_size = new_size
		end; -- set_slider_size

	slider_size: INTEGER is
			-- Size of slider.
		deferred
		ensure
			slider_size_small_enough: Result <= (maximum - minimum);
			slider_size_large_enough: Result >= 0
		end -- slider_size

end --class SCROLLBAR


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
