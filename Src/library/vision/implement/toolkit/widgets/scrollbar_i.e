indexing

	description: "Deferred implementation of scrollbar";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	
	SCROLLBAR_I 

inherit

	PRIMITIVE_I
	
feature -- Access

	initial_delay: INTEGER is
			-- Amount of time to wait (milliseconds) before starting
			-- continuous slider movement
		deferred
		ensure
			positive_value: Result > 0
		end;

	line_increment: INTEGER is
			-- Distance (amount) to scroll on arrows
		deferred
		ensure
			increment_large_enough: Result >= 1;
			increment_small_enough: Result <= (maximum - minimum)
		end;

	page_increment: INTEGER is
			-- Distance (amount) to scroll on page down or up
		deferred
		ensure
			increment_large_enough: Result >= 1;
			increment_small_enough: Result <= (maximum - minimum)
		end;		


	maximum: INTEGER is
			-- Maximum value of slider position
		deferred
		ensure
			maximum_greater_than_mini: Result > minimum
		end;

	minimum: INTEGER is
			-- Minimum value of slider position
		deferred
		ensure
			minimum_smaller_than_maxi: Result < maximum
		end;

	position: INTEGER is
			-- Slider position
		deferred
		ensure
			position_large_enough: Result >= minimum;
			position_small_enough: Result <= maximum
		end;

	repeat_delay: INTEGER is
			-- Amount of time to wait (milliseconds) between subsequent
			-- slider movements after the initial delay
		deferred
		ensure
			positive_delay: Result > 0
		end;

	slider_size: INTEGER is
			-- Size of slider.
		deferred
		ensure
			slider_size_small_enough: Result <= (maximum - minimum);
			slider_size_large_enough: Result >= 0
		end

feature -- Status report

	is_horizontal: BOOLEAN is
			-- Is scrollbar oriented horizontaly?
		deferred
		end;

	is_maximum_right_bottom: BOOLEAN is
			-- Is maximum value on the right side when orientation
			-- is horizontal or on the bottom side when orientation
			-- is vertical?
		deferred
		end;

feature -- Status setting

	set_horizontal (flag: BOOLEAN) is
			-- Set orientation of the scale to horizontal if `flag',
			-- to vertical otherwise.
		deferred
		ensure
			value_correctly_set: is_horizontal = flag
		end;

feature -- Element change

	set_maximum_right_bottom (flag: BOOLEAN) is
			-- Set maximum value on the right side when orientation
			-- is horizontal or on the bottom side when orientation
			-- is vertical if `flag', and at the opposite side otherwise.
		deferred
		ensure
			maximum_value_on_right_bottom: is_maximum_right_bottom = flag
		end;

feature -- Element change

	set_line_increment (inc: INTEGER) is
			-- Set amount (distance) to scroll when on arrows
		require
			increment_large_enough: inc >= 1;
			increment_small_enough: inc <= (maximum - minimum)
		deferred
		ensure
			line_increment = inc
		end;

	set_page_increment (inc: INTEGER) is
			-- Set amount (distance) to move on page up or down
		require
			increment_large_enough: inc >= 1;
			increment_small_enough: inc <= (maximum - minimum)
		deferred
		ensure
			page_increment = inc
		end;

	add_move_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when slide
			-- is moved.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	add_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when value
			-- is changed.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	set_initial_delay (new_delay: INTEGER) is
			-- Set the amount of time to wait (milliseconds) before
			-- starting continuous slider movement to `new_delay'.
		require
			positive_delay: new_delay > 0
		deferred
		ensure
			set: initial_delay = new_delay
		end;

	set_maximum (new_maximum: INTEGER) is
			-- Set maximum value of slider position to `new_maximum'.
		require
			maximum_greater_than_mini: new_maximum > minimum
		deferred
		ensure
			set: maximum = new_maximum
		end;

	set_minimum (new_minimum: INTEGER) is
			-- Set minimum value of slider position to `new_minimum'.
		require
			minimum_smaller_than_maxi: new_minimum < maximum
		deferred
		ensure
			set: minimum = new_minimum
		end;

	set_position (new_position: INTEGER) is
			-- Set slider position to `new_position'.
		require
			position_small_enough: new_position <= maximum;
			position_large_enough: new_position >= minimum
		deferred
		ensure
			set: position = new_position
		end;

	set_repeat_delay (new_delay: INTEGER) is
			-- Set the amount of time to wait (milliseconds) between
			-- subsequent movements after the initial delay to 'new_delay'.
		require
			positive_delay: new_delay > 0
		deferred
		ensure
			set: repeat_delay = new_delay
		end;

	set_slider_size (new_size: INTEGER) is
			-- Set size of slider to 'new_size'.
		require
			new_size_small_enough: new_size <= (maximum - minimum);
			new_size_large_enough: new_size >= 0
		deferred
		ensure
			set: slider_size = new_size
		end;

feature -- Removal

	remove_move_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- slide is moved.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- value is changed.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

end --class SCROLLBAR



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

