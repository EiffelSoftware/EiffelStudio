indexing
	description: "Eiffel Vision gauge. GTK+ implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_GAUGE_IMP

inherit
	EV_GAUGE_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			initialize
		end

	EV_GAUGE_ACTION_SEQUENCES_IMP

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the horizontal scroll bar.
		do
			base_make (an_interface)
			adjustment := C.gtk_adjustment_new (0, 0, 100, 1, 10, 0)
		end

	initialize is
		do
			Precursor
			ev_gauge_imp_initialize
		end

	ev_gauge_imp_initialize is
			-- Initialize without calling precursor.
			--| Separate function so it can be called from
			--| widgets that inherit twice from EV_WIDGET_IMP,
			--| so initialize does not have to be called again.
		do
			create value_range.make (0, 100)
			value_range.change_actions.extend (agent set_range)
			real_signal_connect (
				adjustment,
				"value-changed",
				agent value_changed_handler,
				Void
			)
		end

feature -- Access

	value: INTEGER is
			-- Current value of the gauge.
		do
			Result := C.gtk_adjustment_struct_value (adjustment).rounded
		end

	step: INTEGER is
			-- Value by which `value' is increased after `step_forward'.
		do
			Result := C.gtk_adjustment_struct_step_increment (
				adjustment
			).rounded
		end

	leap: INTEGER is
			-- Value by which `value' is increased after `leap_forward'.
		do
			Result := C.gtk_adjustment_struct_page_increment (
				adjustment
			).rounded
		end

	page_size: INTEGER is
			-- Size of slider.
			--| We define it here to add to the internal maximum. 
			--| Value should be zero for ranges but not for scrollbars.
		do
			Result := C.gtk_adjustment_struct_page_size (adjustment).rounded
		end

feature -- Status setting

	step_forward is
			-- Increment `value' by `step' if possible.
		do
			set_value (value_range.upper.min (value + step))
		end

	step_backward is
			-- Decrement `value' by `step' if possible.
		do
			set_value (value_range.lower.max (value - step))
		end

	leap_forward is
			-- Increment `value' by `leap' if possible.
		do
			set_value (value_range.upper.min (value + leap))
		end

	leap_backward is
			-- Decrement `value' by `leap' if possible.
		do
			set_value (value_range.lower.max (value - leap))
		end

feature -- Element change

	set_value (a_value: INTEGER) is
			-- Set `value' to `a_value'.
		do
			if value /= a_value then
				C.gtk_adjustment_set_value (adjustment, a_value)
			end
		ensure then
			step_same: step = old step
			leap_same: leap = old leap
			range_same: value_range.is_equal (old value_range)
		end

	set_step (a_step: INTEGER) is
			-- Set `step' to `a_step'.
		do
			if step /= a_step then
				C.set_gtk_adjustment_struct_step_increment (adjustment, a_step)
				C.gtk_adjustment_changed (adjustment)
			end
		ensure then
			value_same: value = old value
			leap_same: leap = old leap
			range_same: value_range.is_equal (old value_range)
		end

	set_leap (a_leap: INTEGER) is
			-- Set `leap' to `a_leap'.
		do
			if leap /= a_leap then
				C.set_gtk_adjustment_struct_upper (adjustment, value_range.upper + a_leap)
				C.set_gtk_adjustment_struct_page_increment (adjustment, a_leap)
				C.gtk_adjustment_changed (adjustment)
			end
		end

--|	set_minimum (a_minimum: INTEGER) is
--|			-- Set `minimum' to `a_minimum'.
--|		do
--|			if minimum /= a_minimum then
--|				if minimum = maximum then
--|					--| VB 02/15/2000 Bug/feature in GTK:
--|					--| When lower equals upper, and minimum is decreased
--|					--| value is decreased as well. This is evil, but
--|					--| can be worked around by temporarily increasing
--|					--| the maximum.
--|					C.set_gtk_adjustment_struct_upper (
--|						adjustment,
--|						maximum + page_size + 1
--|					)
--|					C.gtk_adjustment_changed (adjustment)
--|					C.set_gtk_adjustment_struct_upper (
--|						adjustment,
--|						maximum + page_size - 1
--|					)
--|				end
--|				C.set_gtk_adjustment_struct_lower (adjustment, a_minimum)
--|				C.gtk_adjustment_changed (adjustment)
--|			end
--|		ensure then
--|			value_same: value = old value
--|			maximum_same: maximum = old maximum
--|		end
--|
--|	set_maximum (a_maximum: INTEGER) is
--|			-- Set `maximum' to `a_maximum'.
--|		do
--|			if maximum /= a_maximum then
--|				C.set_gtk_adjustment_struct_upper (
--|					adjustment,
--|					a_maximum + page_size
--|				)
--|				C.gtk_adjustment_changed (adjustment)
--|			end
--|		end

	set_range is
			-- Update widget range from `value_range'
			--| FIXME this should be an inline agent.
		local
			temp_value: INTEGER
		do
			temp_value := value
			if temp_value > value_range.upper then
				temp_value := value_range.upper
			elseif temp_value < value_range.lower then
				temp_value := value_range.lower
			end
			C.set_gtk_adjustment_struct_lower (adjustment, value_range.lower)
			C.set_gtk_adjustment_struct_upper (
				adjustment,
				value_range.upper + page_size
			)
			C.gtk_adjustment_changed (adjustment)
			set_value (temp_value)
		ensure
			value_range_upper_consistent: value_range.upper =
				C.gtk_adjustment_struct_upper (adjustment).rounded - page_size
			value_range_lower_consistent: value_range.lower =
				C.gtk_adjustment_struct_lower (adjustment).rounded
		end

feature {NONE} -- Implementation

	interface: EV_GAUGE

	adjustment: POINTER
			-- Pointer to GtkAdjustment of gauge.

	old_value: INTEGER
			-- Value of `value' when last "value-changed" signal occurred.

	value_changed_handler is
			-- Called when `value' changes.
			--| We need this intermediate step because internally
			--| GtkAdjustment uses real values and therefore the rounded
			--| value may not have changed.
		do
			if value /= old_value then
				if change_actions_internal /= Void then
					change_actions_internal.call ([value])
				end
				old_value := value
			end
		end

invariant
	adjustment_not_void: adjustment /= NULL

end -- class EV_GAUGE_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

