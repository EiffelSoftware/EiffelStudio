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

feature {NONE} -- Initialization

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
			real_signal_connect (adjustment, "value-changed",
				(interface.change_actions)~call)
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
			Result := C.gtk_adjustment_struct_step_increment (adjustment).rounded
		end

	leap: INTEGER is
			-- Value by which `value' is increased after `leap_forward'.
		do
			Result := C.gtk_adjustment_struct_page_increment (adjustment).rounded
		end

	minimum: INTEGER is
			-- Lowest value of the gauge.
		do
			Result := C.gtk_adjustment_struct_lower (adjustment).rounded
		end

	maximum: INTEGER is
			-- Highest value of the gauge.
		do
			Result := C.gtk_adjustment_struct_upper (adjustment).rounded
		end

feature -- Status setting

	step_forward is
			-- Increment `value' by `step' if possible.
		do
			set_value (maximum.min (value + step))
		end

	step_backward is
			-- Decrement `value' by `step' if possible.
		do
			set_value (minimum.max (value - step))
		end

	leap_forward is
			-- Increment `value' by `leap' if possible.
		do
			set_value (maximum.min (value + leap))
		end

	leap_backward is
			-- Decrement `value' by `leap' if possible.
		do
			set_value (minimum.max (value - leap))
		end

feature -- Element change

	set_value (a_value: INTEGER) is
			-- Set `value' to `a_value'.
		do
			if value /= a_value then
				C.gtk_adjustment_set_value (adjustment, a_value)
			end
		end

	set_step (a_step: INTEGER) is
			-- Set `step' to `a_step'.
		do
			if step /= a_step then
				C.set_gtk_adjustment_struct_step_increment (adjustment, a_step)
				C.gtk_adjustment_changed (adjustment)
			end
		end

	set_leap (a_leap: INTEGER) is
			-- Set `leap' to `a_leap'.
		do
			if leap /= a_leap then
				C.set_gtk_adjustment_struct_page_increment (adjustment, a_leap)
				C.gtk_adjustment_changed (adjustment)
			end
		end

	set_minimum (a_minimum: INTEGER) is
			-- Set `minimum' to `a_minimum'.
		do
			if minimum /= a_minimum then
				C.set_gtk_adjustment_struct_lower (adjustment, a_minimum)
				C.gtk_adjustment_changed (adjustment)
			end
		end

	set_maximum (a_maximum: INTEGER) is
			-- Set `maximum' to `a_maximum'.
		do
			if maximum /= a_maximum then
				C.set_gtk_adjustment_struct_upper (adjustment, a_maximum)
				C.gtk_adjustment_changed (adjustment)
			end
		end

	set_range (a_range: INTEGER_INTERVAL) is
			-- Set `range' to `a_range'.
		do
			if minimum /= a_range.lower or else maximum /= a_range.upper then
				C.set_gtk_adjustment_struct_lower (adjustment, a_range.lower)
				C.set_gtk_adjustment_struct_upper (adjustment, a_range.upper)
				C.gtk_adjustment_changed (adjustment)
			end
		end

	reset_with_range (a_range: INTEGER_INTERVAL) is
			-- Set `range' to `a_range'.
			-- Set `value' to `a_range.lower'.
		do
			C.set_gtk_adjustment_struct_lower (adjustment, a_range.lower)
			C.set_gtk_adjustment_struct_upper (adjustment, a_range.upper)
			C.gtk_adjustment_set_value (adjustment, a_range.lower)
			C.gtk_adjustment_value_changed (adjustment)
		end

feature {NONE} -- Implementation

	interface: EV_GAUGE

	adjustment: POINTER
			-- Pointer to GtkAdjustment of gauge.

invariant
	adjustment_not_void: adjustment /= Default_pointer

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.8  2000/02/15 00:43:40  brendel
--| Removed connection to "changed" signal, since we only want the "value-changed".
--|
--| Revision 1.7  2000/02/14 22:19:51  brendel
--| Changed range instead of taking two integers to take an INTEGER_INTERVAL.
--| This is to take advantage of the newly introduced operator |..|.
--|
--| Revision 1.6  2000/02/14 11:40:32  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.4.12  2000/02/04 04:25:38  oconnor
--| released
--|
--| Revision 1.5.4.11  2000/02/02 01:19:43  brendel
--| Fixed bug where initialize of EV_WIDGET_IMP was called more than once.
--|
--| Revision 1.5.4.10  2000/02/02 01:00:50  brendel
--| Added implementation of leap-features.
--|
--| Revision 1.5.4.9  2000/02/01 01:43:08  brendel
--| Corrected error in reset_with_range.
--|
--| Revision 1.5.4.8  2000/02/01 01:21:35  brendel
--| Improved implementation.
--|
--| Revision 1.5.4.7  2000/01/31 21:32:53  brendel
--| Changed `adjustment' from function to attribute.
--|
--| Revision 1.5.4.6  2000/01/30 21:23:01  brendel
--| Corrected error in initialize.
--|
--| Revision 1.5.4.4  2000/01/29 02:44:44  brendel
--| Implemented all features by accessing GtkAdjustment that all descendants
--| must have in their c_object.
--|
--| Revision 1.5.4.3  2000/01/27 19:29:46  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.4.2  2000/01/14 21:46:06  king
--| Removed make_with_range, added interface feature
--|
--| Revision 1.5.4.1  1999/11/24 17:29:56  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
