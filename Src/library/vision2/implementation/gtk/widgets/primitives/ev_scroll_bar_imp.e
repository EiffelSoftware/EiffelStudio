indexing
	description:
		" EiffelVision scrollbarbar. A gauge usely used to %
		% scrollbar an area. Gtk implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SCROLL_BAR_IMP

inherit
	EV_SCROLL_BAR_I

	EV_GAUGE_IMP
		redefine
			adjustment_widget
		end

feature -- Access

	value: INTEGER is
			-- Current value of the gauge
		do
			Result := c_gtk_scrollbar_value (widget)
		end

	step: INTEGER is
			-- Step of the scrollbar
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
			-- Leap of the scrollbar.
			-- ie : the user clicks on the scrollbar bar
		do
			Result := c_gtk_range_leap (widget)
		end

	adjustment_widget: POINTER is
			-- Pointer to the widgets asjustment struct
		do
			Result := c_gtk_range_adjustment (widget)
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
			c_gtk_scrollbar_set_value (widget, val)
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

	set_page_size (val: INTEGER) is
			-- Set the size of a page.
			-- To be done on Windows before it can be available
			-- to the user.
		do
			c_gtk_scrollbar_set_page_size (widget, value)
		end

end -- class EV_SCROLL_BAR_IMP

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
