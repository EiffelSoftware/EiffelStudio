indexing
	description:
		" EiffelVision spin button. A single line edit that%
		% displays only numbers. The user can increase or%
		% decrease this number by clicking on up or down%
		% arrow buttons. Gtk implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SPIN_BUTTON_IMP

inherit
	EV_SPIN_BUTTON_I

	EV_GAUGE_IMP
		undefine
			set_default_options,
			set_default_colors
		redefine
			make_with_range,
			adjustment_widget
		end

	EV_TEXT_FIELD_IMP
		redefine
			make
		end

create
	make,
	make_with_range

feature {NONE} -- Initialization

	make is
			-- Create a spin-button with 0 as minimum,
			-- 100 as maximum and `par' as parent.
		do
			-- Parameters are:
			-- value, lower, upper, step_increment, page_increment.
			widget := c_gtk_spin_button_new (0, 0, 100, 1, 5)
			gtk_object_ref (widget)
		end

	make_with_range (min: INTEGER; max: INTEGER) is
			-- Create a spin-button with `min' as minimum, `max' as maximum
			-- and `par' as parent.
		do
			-- Parameters are:
			-- value, lower, upper, step_increment, page_increment.
			widget := c_gtk_spin_button_new (min, min, max, 1, 5)
			gtk_object_ref (widget)
		end

feature -- Access

	value: INTEGER is
			-- Current value of the gauge
		do
			Result := gtk_spin_button_get_value_as_int (widget)
		end

	step: INTEGER is
			-- Step of the scrolling
			-- ie : the user clicks on an arrow
		do
			Result := c_gtk_spin_button_step (widget)
		end

	minimum: INTEGER is
			-- Minimum value
		do
			Result := c_gtk_spin_button_minimum (widget)
		end

	maximum: INTEGER is
			-- Maximum value
		do
			Result := c_gtk_spin_button_maximum (widget)
		end

	adjustment_widget: POINTER is
			-- Pointer to adjustment widget
		do
			Result := gtk_spin_button_get_adjustment (widget)
		end

feature -- Element change

	set_value (val: INTEGER) is
			-- Make `val' the new current value.
		do
			gtk_spin_button_set_value (widget, val)
		end

	set_step (val: INTEGER) is
			-- Make `val' the new step.
		do
			c_gtk_spin_button_set_step (widget, val)
		end

	set_minimum (val: INTEGER) is
			-- Make `val' the new minimum.
		do
			c_gtk_spin_button_set_minimum (widget, val)
		end

	set_maximum (val: INTEGER) is
			-- Make `val' the new maximum.
		do
			c_gtk_spin_button_set_maximum (widget, val)
		end

end -- class EV_SPIN_BUTTON_IMP

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
