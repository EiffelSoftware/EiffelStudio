indexing 
	description: "EiffelVision scale. Gtk implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RANGE_IMP

inherit
	EV_RANGE_I

	EV_GAUGE_IMP
		redefine
			adjustment_widget
		end

feature -- Access

	adjustment_widget: POINTER is
			-- Pointer th the widget adjustment struct
		do
			Result := c_gtk_range_adjustment (widget)
		end

	value: INTEGER is
			-- Current value of the gauge
		do
			Result := c_gtk_scale_value (widget)
		end

	step: INTEGER is
			-- Step of the scrolling
			-- ie : the user clicks on an arrow
		do
			Result := c_gtk_range_step (widget)
		end

	minimum: INTEGER is
			-- Minimum value
		do
			Result := c_gtk_range_minimum (widget)
		end

	maximum: INTEGER is
			-- Maximum value
		do
			Result := c_gtk_range_maximum (widget)
		end

	leap: INTEGER is
			-- Leap of the scrolling
			-- ie : the user clicks on the scroll bar
		do
			Result := c_gtk_range_leap (widget)
		end

feature -- Status setting

	leap_forward is
			-- Increase the current value of one leap.
		do
			set_value (value + step)
		end

	leap_backward is
			-- Decrease the current value of one leap.
		do
			set_value (value - step)
		end

feature -- Element change

	set_value (val: INTEGER) is
			-- Make `val' the new current value.
		do
			gtk_scale_set_value_pos (widget, val)
		end

	set_step (val: INTEGER) is
			-- Make `val' the new step.
		do
			c_gtk_range_set_step (widget, val)
		end

	set_minimum (val: INTEGER) is
			-- Make `val' the new minimum.
		do
			c_gtk_range_set_minimum (widget, val)
		end

	set_maximum (val: INTEGER) is
			-- Make `val' the new maximum.
		do
			c_gtk_range_set_maximum (widget, val)
		end

	set_leap (val: INTEGER) is
			-- Make `val' the new leap.
		do
			c_gtk_range_set_leap (widget, val)
		end

end -- class EV_RANGE_IMP

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
