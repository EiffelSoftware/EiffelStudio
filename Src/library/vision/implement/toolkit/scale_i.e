indexing

	description: "General scale implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class SCALE_I 

inherit

	FONTABLE_I;

	PRIMITIVE_I;
	
feature 

	add_move_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when slide
			-- is moved.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end;

	add_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when value
			-- is changed.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end;

	granularity: INTEGER is
			-- Value of the amount to move the slider and modifie value
			-- when a move action occurs
		deferred
		ensure
			granularity_large_enough: Result >=1;
			granularity_small_enough: Result <= (maximum - minimum)
		end;

	is_horizontal: BOOLEAN is
			-- Is scale oriented horizontal?
		deferred
		end;

	is_maximum_right_bottom: BOOLEAN is
			-- Is maximum value on the right side when orientation
			-- is horizontal or on the bottom side when orientation
			-- is vertical?
		deferred
		end;

	is_output_only: BOOLEAN is
			-- Is scale mode output only?
		deferred
		end;

	is_value_shown: BOOLEAN is
			-- Is value shown on the screen?
		deferred
		end;

	maximum: INTEGER is
			-- Maximum value of the slider
		deferred
		ensure
			maximum_greater_than_minimum: Result >= minimum
		end;

	minimum: INTEGER is
			-- Minimum value of the slider
		deferred
		ensure
			minimum_smaller_than_maximum: Result <= maximum
		end;

	remove_move_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- slide is moved.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end;

	remove_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- value is changed.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end;

	set_granularity (new_granularity: INTEGER) is
			-- Set amount to move the slider and modifie value when
			-- when a move action occurs to `new_granularity'.
		require
			granularity_large_enough: new_granularity >= 1;
			granularity_small_enough: new_granularity <= (maximum - minimum)
		deferred
		ensure
			granularity = new_granularity
		end;

	set_horizontal (flag: BOOLEAN) is
			-- Set orientation of the scale to horizontal if `flag',
			-- to vertical otherwise.
		deferred
		ensure
			value_correctly_set: is_horizontal = flag
		end;

	set_maximum (new_maximum: INTEGER) is
			-- Set maximum value of the slider to `new_maximum'.
		require
			maximum_greater_than_minimum: new_maximum > minimum
		deferred
		ensure
			maximum = new_maximum
		end;

	set_maximum_right_bottom (flag: BOOLEAN) is
			-- Set maximum value on the right side when orientation
			-- is horizontal or on the bottom side when orientation
			-- is vertical if `flag', and at the opposite side otherwise.
		deferred
		ensure
			maximum_value_on_right_bottom: is_maximum_right_bottom = flag
		end;

	set_minimum (new_minimum: INTEGER) is
			-- Set minimum value of the slider to `new_minimum'.
		require
			minimum_smaller_than_maximum: new_minimum < maximum
		deferred
		ensure
			minimum = new_minimum
		end;

	set_output_only (flag: BOOLEAN) is
			-- Set scale mode to output only if `flag' and to input/output
			-- otherwise.
		deferred
		ensure
			output_only: is_output_only = flag
		end;

	set_text (a_text: STRING) is
			-- Set scale text to `a_text'.
		require
			not_text_void: not (a_text = Void)
		deferred
		ensure
			text.is_equal (a_text)
		end;

	set_value (new_value: INTEGER) is
			-- Set value to `new_value'.
		require
			value_small_enough: new_value <= maximum;
			value_large_enough: new_value >= minimum
		deferred
		ensure
			value = new_value
		end;

	set_value_shown (b: BOOLEAN) is
			-- Show scale value on the screen if `b', hide it otherwise.
		deferred
		ensure
			value_is_shown: is_value_shown = b
		end;

	text: STRING is
			-- Scale text
		deferred
		end;

	value: INTEGER is
			-- Value of the current slider position along the scale
		deferred
		ensure
			value_large_enough: Result >= minimum;
			value_small_enough: Result <= maximum
		end

end -- class SCALE_I


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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
