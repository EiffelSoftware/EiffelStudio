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
			value_range.change_actions.extend (~set_range)
			real_signal_connect (
				adjustment,
				"value-changed",
				~value_changed_handler,
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

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.16  2001/06/07 23:08:07  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.5.2.9  2000/11/10 21:37:09  king
--| Corrected integer interval problems
--|
--| Revision 1.5.2.8  2000/10/27 16:54:43  manus
--| Removed undefinition of `set_default_colors' since now the one from EV_COLORIZABLE_IMP is
--| deferred.
--| However, there might be a problem with the definition of `set_default_colors' in the following
--| classes:
--| - EV_TITLED_WINDOW_IMP
--| - EV_WINDOW_IMP
--| - EV_TEXT_COMPONENT_IMP
--| - EV_LIST_ITEM_LIST_IMP
--| - EV_SPIN_BUTTON_IMP
--|
--| Revision 1.5.2.7  2000/09/13 17:18:07  oconnor
--| updated for modified EV_GAUGE
--|
--| Revision 1.5.2.6  2000/08/08 00:03:15  oconnor
--| Redefined set_default_colors to do nothing in EV_COLORIZABLE_IMP.
--|
--| Revision 1.5.2.5  2000/08/03 22:07:44  king
--| Now using internal action sequence
--|
--| Revision 1.5.2.4  2000/07/24 21:36:10  oconnor
--| inherit action sequences _IMP class
--|
--| Revision 1.5.2.3  2000/06/22 20:20:27  king
--| Passing value to change_actions
--|
--| Revision 1.5.2.2  2000/06/06 22:56:23  king
--| Fixed adjustment signal connection
--|
--| Revision 1.5.2.1  2000/05/03 19:08:50  oconnor
--| mergred from HEAD
--|
--| Revision 1.14  2000/05/02 18:55:30  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.13  2000/04/13 18:46:51  brendel
--| Changed default value.
--|
--| Revision 1.12  2000/04/04 20:54:08  oconnor
--| updated signal connection for new marshaling scheme
--|
--| Revision 1.11  2000/02/22 18:39:39  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.10  2000/02/16 04:01:01  brendel
--| 1: Now provides `make' which creates default adjustment that satisfies
--| is_in_default_state and initializes page_size to 0.
--| 2: The "value-changed" signal is now handled indirectly to avoid multiple
--| calls in case the rounded value of `value' did not change.
--| 3: Now internally the maximum is set higher by `page_size' which is useful
--| for EV_SCROLL_BAR_IMP.
--| 4: Provided workaround for bug/feature in GTK. See `set_minimum'.
--|
--| Revision 1.9  2000/02/15 16:44:11  brendel
--| Moved implementating of feature `range' to _IMP.
--|
--| Revision 1.8  2000/02/15 00:43:40  brendel
--| Removed connection to "changed" signal, since we only want the
--| "value-changed".
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
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
