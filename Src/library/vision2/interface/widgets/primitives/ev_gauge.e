indexing
	description:
		" Any EiffelVision gauge can be used to retrieve%
		% a value in a given range. This value can be either%
		% an integer or a real."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_GAUGE

inherit
	EV_PRIMITIVE
		redefine
			implementation
		end

feature {NONE} -- Initialization

	make_with_range (par: EV_CONTAINER; min: INTEGER; max: INTEGER) is
			-- Create a spin-button with `min' as minimum, `max' as maximum
			-- and `par' as parent.
		require
			valid_range: min <= max
		deferred
		end

feature -- Access

	value: INTEGER is
			-- Current value of the gauge
		require
			exists: not destroyed
		do
			Result := implementation.value
		ensure
			position_large_enough: value >= minimum
			position_small_enough: value <= maximum
		end

	step: INTEGER is
			-- Step of the scrolling
			-- ie : the user clicks on an arrow
		require
			exists: not destroyed
		do
			Result := implementation.step
		ensure
			positive_result: Result >= 0
		end

	minimum: INTEGER is
			-- Minimum position
		require
			exists: not destroyed
		do
			Result := implementation.minimum
		ensure
			small_minimum: Result <= maximum
		end

	maximum: INTEGER is
			-- Maximum position
		require
			exists: not destroyed
		do
			Result := implementation.maximum
		ensure
			large_maximum: Result >= minimum
		end

feature -- Status setting

	step_forward is
			-- Increase the current value of one step.
		require
			exists: not destroyed
		do
			implementation.step_forward
		end

	step_backward is
			-- Decrease the current value of one step.
		require
			exists: not destroyed
		do
			implementation.step_backward
		end

feature -- Element change

	set_value (val: INTEGER) is
			-- Make `val' the new current value.
		require
			exists: not destroyed
			val_large_enough: val >= minimum
			val_small_enough: val <= maximum
		do
			implementation.set_value (val)
		ensure
			value_set: value = val
		end

	set_step (val: INTEGER) is
			-- Make `val' the new step.
		require
			exists: not destroyed
			positive_val: val >= 0
		do
			implementation.set_step (val)
		ensure
			val_set: step = val
		end

	set_minimum (val: INTEGER) is
			-- Make `val' the new minimum.
		require
			exists: not destroyed
		do
			implementation.set_minimum (val)
		ensure
			minimum_set: minimum = val
		end

	set_maximum (val: INTEGER) is
			-- Make `val' the new maximum.
		require
			exists: not destroyed
		do
			implementation.set_maximum (val)
		ensure
			maximum_set: maximum = val
		end

	set_range (min, max: INTEGER) is
			-- Make `min' the new minimum and `max' the new maximum.
		require
			exists: not destroyed
			valid_range: min <= max
		do
			implementation.set_range (min, max)
		ensure
			minimum_set: minimum = min
			maximum_set: maximum = max
		end

feature -- Event - command association
	
	add_change_value_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be executed 
			-- when the user is about to change
			-- the value of the gauge.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_change_value_command (cmd, arg)
		end

feature -- Event -- removing command association

	remove_change_value_commands is
			-- Empty the list of commands to be executed
			-- when the user is about to change
			-- the value of the gauge.
		require
			exists: not destroyed
		do
			implementation.remove_change_value_commands
		end

feature {NONE} -- Implementation

	implementation: EV_GAUGE_I
			-- Platform dependant access.

end -- class EV_GAUGE

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
