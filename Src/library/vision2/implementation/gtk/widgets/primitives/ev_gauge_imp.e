indexing
	description:
		" Any EiffelVision gauge can be used to retrieve%
		% a value in a given range. This value can be either%
		% an integer or a real. Gtk implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_GAUGE_IMP

inherit
	EV_GAUGE_I

	EV_PRIMITIVE_IMP

feature {NONE} -- Initialization

	make_with_range (min: INTEGER; max: INTEGER) is
			-- Create a gauge with `min' as minimum, `max' as maximum
			-- and `par' as parent.
		deferred
		end

feature -- Access

	value: INTEGER is
			-- Current value of the gauge
		deferred
		end

	step: INTEGER is
			-- Step of the scrolling
			-- ie : the user clicks on an arrow
		deferred
		end

	minimum: INTEGER is
			-- Minimum value
		deferred
		end

	maximum: INTEGER is
			-- Maximum value
		deferred
		end

feature -- Status setting

	step_forward is
			-- Increase the current value of one step.
		do
			set_value (value + step)
		end

	step_backward is
			-- Decrease the current value of one step.
		do
			set_value (value - step)
		end

feature -- Element change

	set_value (val: INTEGER) is
			-- Make `val' the new current value.
		deferred
		end

	set_step (val: INTEGER) is
			-- Make `val' the new step.
		deferred
		end

	set_minimum (val: INTEGER) is
			-- Make `val' the new minimum.
		deferred
		end

	set_maximum (val: INTEGER) is
			-- Make `val' the new maximum.
		deferred
		end

	set_range (min, max: INTEGER) is
			-- Make `min' the new minimum and `max' the new maximum.
		do
			set_minimum (min)
			set_maximum (max)
		end

feature -- Event - command association
	
	add_change_value_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be executed 
			-- when the user is about to change
			-- the value of the gauge.
		do
			add_command (adjustment_widget, "value_changed", cmd, arg, default_pointer)
		end

feature -- Event -- removing command association

	remove_change_value_commands is
			-- Empty the list of commands to be executed
			-- when the user is about to change
			-- the value of the gauge.
		do
			remove_commands (adjustment_widget, value_changed_id)
		end

feature -- Implementation - External

	adjustment_widget: POINTER is
			-- Pointer to the GtkAdjustment of the gauge
			-- We need it to catch event.
		do
			Result := gtk_range_get_adjustment (widget)
		end

end -- class EV_GAUGE_I

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
