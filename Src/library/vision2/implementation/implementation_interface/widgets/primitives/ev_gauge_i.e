indexing
	description: "Eiffel Vision gauge. Implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_GAUGE_I

inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end

feature -- Access

	value: INTEGER is
			-- Current value of the gauge.
		deferred
		end

	step: INTEGER is
			-- Value by which `value' is increased after `step_forward'.
		deferred
		end

	leap: INTEGER is
			-- Value by which `value' is increased after `leap_forward'.
		deferred
		end

	minimum: INTEGER is
			-- Lowest value of the gauge.
		deferred
		end

	maximum: INTEGER is
			-- Highest value of the gauge.
		deferred
		end

	range: INTEGER_INTERVAL is
			-- Get `minimum' and `maximum' as interval.
		deferred
		end

feature -- Status setting

	step_forward is
			-- Increment `value' by `step' if possible.
		deferred
		ensure
			incremented: value = old value + step
				or else value = maximum
		end

	step_backward is
			-- Decrement `value' by `step' if possible.
		deferred
		ensure
			decremented: value = old value - step
				or else value = minimum
		end

	leap_forward is
			-- Increment `value' by `leap' if possible.
		deferred
		ensure
			incremented: value = old value + leap
				or else value = maximum
		end

	leap_backward is
			-- Decrement `value' by `leap' if possible.
		deferred
		ensure
			decremented: value = old value - leap
				or else value = minimum
		end

feature -- Element change

	set_value (a_value: INTEGER) is
			-- Set `value' to `a_value'.
		require
			a_value_within_bounds: a_value >= minimum
				and then a_value <= maximum
		deferred
		ensure
			assigned: value = a_value
		end

	set_step (a_step: INTEGER) is
			-- Set `step' to `a_step'.
		require
			a_step_positive: a_step > 0
		deferred
		ensure
			assigned: step = a_step
		end

	set_leap (a_leap: INTEGER) is
			-- Set `leap' to `a_leap'.
		require
			a_leap_non_negative: a_leap > 0
		deferred
		ensure
			assigned: leap = a_leap
		end

	set_minimum (a_minimum: INTEGER) is
			-- Set `minimum' to `a_minimum'.
		require
			a_minimum_not_greater_than_maximum:
				a_minimum <= maximum
			a_minimum_not_smaller_than_value:
				a_minimum <= value			
		deferred
		ensure
			assigned: minimum = a_minimum
		end

	set_maximum (a_maximum: INTEGER) is
			-- Set `maximum' to `a_maximum'.
		require
			a_maximum_not_smaller_than_maximum:
				a_maximum >= minimum
			a_maximum_not_smaller_than_value:
				a_maximum >= value			
		deferred
		ensure
			assigned: maximum = a_maximum
		end

	set_range (a_range: INTEGER_INTERVAL) is
			-- Set `range' to `a_range'.
		require
			a_range_upper_greater_than_or_equal_to_a_range_lower:
				a_range.upper >= a_range.lower
			value_within_bounds:
				value >= a_range.lower and then value <= a_range.upper
		deferred
		ensure
			minimum_assigned: minimum = a_range.lower
			maximum_assigned: maximum = a_range.upper
			assigned: range.is_equal (a_range)
		end

	reset_with_range (a_range: INTEGER_INTERVAL) is
			-- Set `range' to `a_range'.
			-- Set `value' to `a_range.lower'.
		require
			a_range_upper_greater_than_or_equal_to_a_range_lower:
				a_range.upper >= a_range.lower
		deferred
		ensure
			value_assigned: value = a_range.lower
			minimum_assigned: minimum = a_range.lower
			maximum_assigned: maximum = a_range.upper
			assigned: range.is_equal (a_range)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_GAUGE

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
--| Revision 1.6  2000/02/15 16:44:11  brendel
--| Moved implementating of feature `range' to _IMP.
--|
--| Revision 1.5  2000/02/14 22:19:51  brendel
--| Changed range instead of taking two integers to take an INTEGER_INTERVAL.
--| This is to take advantage of the newly introduced operator |..|.
--|
--| Revision 1.4  2000/02/14 11:40:38  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.8  2000/02/04 04:10:28  oconnor
--| released
--|
--| Revision 1.3.6.7  2000/02/02 00:59:34  brendel
--| Revised to comply with revised interface.
--|
--| Revision 1.3.6.6  2000/01/30 20:58:59  brendel
--| Added `reset_with_range'. Fixed bug in `make_with_range'.
--|
--| Revision 1.3.6.5  2000/01/29 02:43:38  brendel
--| Changed to comply with new interface.
--|
--| Revision 1.3.6.4  2000/01/27 19:30:03  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.3  2000/01/06 20:41:57  rogers
--| fixed to work with major new vision2 changes. Make with range no longer takes a parent. redefined interface.
--|
--| Revision 1.3.6.2  1999/12/09 03:15:06  oconnor
--| commented out make_with_* features, these should be in interface only
--|
--| Revision 1.3.6.1  1999/11/24 17:30:12  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.3  1999/11/04 23:10:44  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.3.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
