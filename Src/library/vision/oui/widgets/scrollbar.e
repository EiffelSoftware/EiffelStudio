--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.	  --
--|	270 Storke Road, Suite 7 Goleta, California 93117		--
--|				   (805) 685-1006							--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Rectangle with two arrows placed at each end and a slider.

indexing

	date: "$Date$";
	revision: "$Revision$"

class SCROLLBAR 

inherit

	PRIMITIVE
		redefine
			implementation
		end

creation

	make

feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a scrollbar with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			Valid_name: a_name /= Void;
			Valid_parent: a_parent /= Void
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= a_name.duplicate;
			implementation:= toolkit.scrollbar (Current);
			set_default
		ensure
			Parent_set: parent = a_parent;
			Identifier_set: identifier.is_equal (a_name)
		end;

feature -- Callbacks (adding)

	add_move_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when the
			--  slider is moved.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			Valid_command: a_command /= Void
		do
			implementation.add_move_action (a_command, argument)
		end;

	add_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when value
			-- is changed.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			Valid_command: a_command /= Void
		do
			implementation.add_value_changed_action (a_command, argument)
		end;

feature -- Callbacks (removing)

	remove_move_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to be executed when
			-- slide is moved.
		require
			Valid_command: a_command /= Void
		do
			implementation.remove_move_action (a_command, argument)
		end; 

	remove_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to be executed when
			-- value is changed.
		require
			Valid_command: a_command /= Void
		do
			implementation.remove_value_changed_action (a_command, argument)
		end; 

feature -- Slider setup (max, min., gran, ...)

	granularity: INTEGER is
			-- Value of the amount to move the slider of the current
			-- scrollbar when a move action occurs
		do
			Result := implementation.granularity
		ensure
			granularity_large_enough: Result >= 1;
			granularity_small_enough: Result <= (maximum - minimum)
		end;

	maximum: INTEGER is
			-- Maximum value of slider value
		do
			Result := implementation.maximum
		ensure
			maximum_greater_than_mini: Result > minimum
		end; 

	minimum: INTEGER is
			-- Minimum value of slider value
		do
			Result := implementation.minimum
		ensure
			minimum_smaller_than_maxi: Result < maximum
		end; 

	set_granularity (new_granularity: INTEGER) is
			-- Set amount to move the slider when a move action 
			-- occurs to `new_granularity'.
		require
			granularity_large_enough: new_granularity >= 1;
			granularity_small_enough: new_granularity <= (maximum - minimum)
		do
			implementation.set_granularity (new_granularity)
		ensure
			granularity = new_granularity
		end; 

	set_maximum (new_maximum: INTEGER) is
			-- Set maximum value of slider value to `new_maximum'.
		require
			maximum_greater_than_mini: new_maximum > minimum
		do
			implementation.set_maximum (new_maximum)
		ensure
			maximum = new_maximum
		end; 

	set_minimum (new_minimum: INTEGER) is
			-- Set minimum value of slider value to `new_minimum'.
		require
			minimum_smaller_than_maxi: new_minimum < maximum
		do
			implementation.set_minimum (new_minimum)
		ensure
			minimum = new_minimum
		end;

feature -- Delay

	initial_delay: INTEGER is
			-- Amount of time to wait (milliseconds) before starting
			-- continuous slider movement
		do
			Result := implementation.initial_delay
		ensure
			positive_value: Result > 0
		end;

	repeat_delay: INTEGER is
			-- Amount of time to wait (milliseconds) between subsequent
			-- slider movements after the initial delay
		do
			Result := implementation.repeat_delay
		ensure
			positive_delay: Result > 0
		end;
	
	set_repeat_delay (new_delay: INTEGER) is
			-- Set the amount of time to wait (milliseconds) between
			-- subsequent movements after the initial delay to 'new_delay'.
		require
			positive_delay: new_delay > 0
		do
			implementation.set_repeat_delay (new_delay)
		ensure
			repeat_delay = new_delay
		end;

	set_initial_delay (new_delay: INTEGER) is
			-- Set the amount of time to wait (milliseconds) before
			-- starting continuous slider movement to `new_delay'.
		require
			positive_delay: new_delay > 0
		do
			implementation.set_initial_delay (new_delay)
		ensure
			initial_delay = new_delay
		end;

feature -- Orientation

	is_horizontal: BOOLEAN is
			-- Is scrollbar oriented horizontal?
		do
			Result := implementation.is_horizontal
		end;

	set_horizontal (flag: BOOLEAN) is
			-- Set orientation of the scale to horizontal if `flag',
			-- to vertical otherwise.
			do
				implementation.set_horizontal (flag)
			ensure
				value_correctly_set: is_horizontal = flag
			end;

feature -- Slider value 

	value: INTEGER is
			-- Slider value
		do
			Result := implementation.position
		ensure
			value_large_enough: Result >= minimum;
			value_small_enough: Result <= maximum
		end;

	set_value (new_value: INTEGER) is
			-- Set slider value to `new_value'.
		require
			value_small_enough: new_value <= maximum;
			value_large_enough: new_value >= minimum
		do
			implementation.set_position (new_value)
		ensure
			value = new_value
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: SCROLLBAR_I;
			-- Implementation of scrollbar

feature {NONE}

	set_default is
			-- Set default values tu current scrollbar.
		do
		end;

end
