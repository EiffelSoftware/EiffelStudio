indexing
	description:
		"Eiffel Vision gauge. Widgets that describe a range, like %N%
		%spin buttons and progress bars."
	status: "See notice at end of class."
	keywords: "value, step, increment, range"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_GAUGE

inherit
	EV_PRIMITIVE
		redefine
			implementation,
			create_action_sequences
		end

feature {NONE} -- Initialization

	make_with_range (a_range: INTEGER_INTERVAL) is
			-- Initialize with `a_maximum' and `a_minimum'.
			-- Initialize `value' with `a_minimum'.
		require
			a_range_not_void: a_range /= Void
			a_range_upper_greater_than_or_equal_to_a_range_lower:
				a_range.upper >= a_range.lower
		do
			default_create
			reset_with_range (a_range)
		end

feature -- Events

	change_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions performed when `value' changes.

feature -- Access

	value: INTEGER is
			-- Current value of the gauge.
		do
			Result := implementation.value
		ensure
			bridge_ok: Result = implementation.value
		end

	step: INTEGER is
			-- Value by which `value' changes.
		do
			Result := implementation.step
		ensure
			bridge_ok: Result = implementation.step
		end

	leap: INTEGER is
			-- Size of page.
		do
			Result := implementation.leap
		ensure
			bridge_ok: Result = implementation.leap
		end

	minimum: INTEGER is
			-- Lowest value of the gauge.
		do
			Result := implementation.minimum
		ensure
			bridge_ok: Result = implementation.minimum
		end

	maximum: INTEGER is
			-- Highest value of the gauge.
		do
			Result := implementation.maximum
		ensure
			bridge_ok: Result = implementation.maximum
		end

	range: INTEGER_INTERVAL is
			-- Get `minimum' and `maximum' as interval.
		do
			Result := implementation.range
		ensure
			bridge_ok: Result /= Void and then
				Result.is_equal (implementation.range)
		end

feature -- Status setting

	step_forward is
			-- Increment `value' by `step' if possible.
		do
			implementation.step_forward
		ensure
			incremented: value = maximum.min (old value + step)
		end

	step_backward is
			-- Decrement `value' by `step' if possible.
		do
			implementation.step_backward
		ensure
			decremented: value = minimum.max (old value - step)
		end

	leap_forward is
			-- Increment `value' by `leap' if possible.
		do
			implementation.leap_forward
		ensure
			incremented: value = maximum.min (old value + leap)
		end

	leap_backward is
			-- Decrement `value' by `leap' if possible.
		do
			implementation.leap_backward
		ensure
			decremented: value = minimum.max (old value - leap)
		end

feature -- Element change

	set_value (a_value: INTEGER) is
			-- Set `value' to `a_value'.
		require
			a_value_within_bounds: a_value >= minimum
				and then a_value <= maximum
		do
			implementation.set_value (a_value)
		ensure
			assigned: value = a_value
		end

	set_step (a_step: INTEGER) is
			-- Set `step' to `a_step'.
		require
			a_step_positive: a_step > 0
		do
			implementation.set_step (a_step)
		ensure
			assigned: step = a_step
		end

	set_leap (a_leap: INTEGER) is
			-- Set `leap' to `a_leap'.
		require
			a_leap_positive: a_leap > 0
		do
			implementation.set_leap (a_leap)
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
		do
			implementation.set_minimum (a_minimum)
		ensure
			assigned: minimum = a_minimum
		end

	set_maximum (a_maximum: INTEGER) is
			-- Set `maximum' to `a_maximum'.
		require
			a_maximum_not_smaller_than_minimum:
				a_maximum >= minimum
			a_maximum_not_smaller_than_value:
				a_maximum >= value			
		do
			implementation.set_maximum (a_maximum)
		ensure
			assigned: maximum = a_maximum
		end

	set_range (a_range: INTEGER_INTERVAL) is
			-- Set `range' to `a_range'.
		require
			a_range_not_void: a_range /= Void
			a_range_not_empty: not a_range.empty
			a_range_has_value: a_range.has (value)
		do
			implementation.set_range (a_range)
		ensure
			minimum_assigned: minimum = a_range.lower
			maximum_assigned: maximum = a_range.upper
			assigned: range.is_equal (a_range)
		end

	reset_with_range (a_range: INTEGER_INTERVAL) is
			-- Set `range' to `a_range'.
			-- Set `value' to `a_range.lower'.
		require
			a_range_not_void: a_range /= Void
			a_range_not_empty: not a_range.empty
		do
			implementation.reset_with_range (a_range)
		ensure
			value_assigned: value = a_range.lower
			minimum_assigned: minimum = a_range.lower
			maximum_assigned: maximum = a_range.upper
			assigned: range.is_equal (a_range)
		end

feature {NONE} -- Implementation

	implementation: EV_GAUGE_I

	create_action_sequences is
		do
			Precursor
			create change_actions
		end

invariant
	range_not_void: is_useable implies range /= Void
	maximum_greater_than_or_equal_to_minimum: is_useable implies maximum >= minimum
	value_within_bounds: is_useable implies value >= minimum and then value <= maximum
	step_positive: is_useable implies step > 0
	leap_positive: is_useable implies leap > 0
	change_actions_not_void: is_useable implies change_actions /= Void

end -- class EV_GAUGE

--!-----------------------------------------------------------------------------
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.7  2000/02/15 01:56:50  brendel
--| Removed commented out part of invariant. There is a bug in INTEGER_INTERVAL
--| and we cannot wait for it to be fixed.
--|
--| Revision 1.5  2000/02/14 23:57:31  brendel
--| Strengthened contracts using INTEGER_INTERVAL.
--|
--| Revision 1.4  2000/02/14 22:19:51  brendel
--| Changed range instead of taking two integers to take an INTEGER_INTERVAL.
--| This is to take advantage of the newly introduced operator |..|.
--|
--| Revision 1.3  2000/02/14 11:40:52  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.6.11  2000/02/14 11:06:37  oconnor
--| added is_useable to invariant
--|
--| Revision 1.2.6.10  2000/02/10 19:39:54  rogers
--| The comment on ev_gauge now corerctly reads: Actions performed when `value' changes.
--|
--| Revision 1.2.6.9  2000/02/02 00:55:29  brendel
--| Added features for leaping (or scrolling by page), since they were first
--| defined in scrollbar and range, but could as well be defined for spinbutton and
--| progress bar. If not, they can be undefined there.
--|
--| Revision 1.2.6.8  2000/02/01 01:30:26  brendel
--| Fixed bug in `make_with_range'.
--| Improved contracts.
--|
--| Revision 1.2.6.7  2000/01/30 20:58:59  brendel
--| Added `reset_with_range'. Fixed bug in `make_with_range'.
--|
--| Revision 1.2.6.6  2000/01/29 02:42:58  brendel
--| Improved contracts.
--|
--| Revision 1.2.6.5  2000/01/28 22:24:24  oconnor
--| released
--|
--| Revision 1.2.6.4  2000/01/27 19:30:54  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.6.3  2000/01/19 18:10:01  oconnor
--| formatting
--|
--| Revision 1.2.6.2  2000/01/06 20:31:51  rogers
--| make_with_range no longer takes a parent.
--|
--| Revision 1.2.6.1  1999/11/24 17:30:53  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.2.3  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.2.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
