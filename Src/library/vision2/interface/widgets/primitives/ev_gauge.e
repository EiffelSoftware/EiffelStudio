indexing
	description:
		"Base class for widgets that display a `value' within a `range'.%N%
		%See EV_RANGE, EV_SCROLL_BAR, EV_SPIN_BUTTON and EV_PROGRESS_BAR."
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
			create_action_sequences,
			is_in_default_state,
			make_for_test
		end

feature {NONE} -- Initialization

	make_with_range (a_range: INTEGER_INTERVAL) is
			-- Create with `a_range'.
		require
			a_range_not_void: a_range /= Void
			a_range_upper_greater_than_or_equal_to_a_range_lower:
				a_range.upper >= a_range.lower
		do
			default_create
			reset_with_range (a_range)
		end

feature -- Access

	value: INTEGER is
			-- Current position within `range'.
			-- Default: 0
		do
			Result := implementation.value
		ensure
			bridge_ok: Result = implementation.value
		end

	step: INTEGER is
			-- Size of change made by `step_forward' or `step_backward'.
			-- Default: 1
		do
			Result := implementation.step
		ensure
			bridge_ok: Result = implementation.step
		end

	leap: INTEGER is
			-- Size of change made by `leap_forward' or `leap_backward'.
			-- Default: 10
		do
			Result := implementation.leap
		ensure
			bridge_ok: Result = implementation.leap
		end

	maximum: INTEGER is
			-- Top of `range'.
			-- Default: 100
		do
			Result := implementation.maximum
		ensure
			bridge_ok: Result = implementation.maximum
		end

	minimum: INTEGER is
			-- Bottom of `range'.
			-- Default: 0
		do
			Result := implementation.minimum
		ensure
			bridge_ok: Result = implementation.minimum
		end

	range: INTEGER_INTERVAL is
			-- Allowed values of `value'.
			-- Default: 0 |..| 100
		do
			Result := implementation.range
		ensure
			bridge_ok: Result /= Void and then
				Result.is_equal (implementation.range)
		end

feature -- Status report

	proportion: REAL is
			-- Relative position of `value' in `range'.
			-- Range: [0, 1]. Default: 0.0
		do
			Result := implementation.proportion
		ensure
			bridge_ok: Result = implementation.proportion
		end

feature -- Status setting

	step_forward is
			-- Increment `value' by `step' if within `range'.
		do
			implementation.step_forward
		ensure
			incremented: value = maximum.min (old value + step)
		end

	step_backward is
			-- Decrement `value' by `step' if withing `range'.
		do
			implementation.step_backward
		ensure
			decremented: value = minimum.max (old value - step)
		end

	leap_forward is
			-- Increment `value' by `leap' if withing `range'.
		do
			implementation.leap_forward
		ensure
			incremented: value = maximum.min (old value + leap)
		end

	leap_backward is
			-- Decrement `value' by `leap' if withing `range'.
		do
			implementation.leap_backward
		ensure
			decremented: value = minimum.max (old value - leap)
		end

feature -- Element change

	set_value (a_value: INTEGER) is
			-- Assign `a_value' to `value'.
		require
			a_value_within_bounds: range.has (a_value)
		do
			implementation.set_value (a_value)
		ensure
			a_value_assigned: value = a_value
		end

	set_step (a_step: INTEGER) is
			-- Assign `a_step' to `step'.
		require
			a_step_positive: a_step > 0
		do
			implementation.set_step (a_step)
		ensure
			a_step_assigned: step = a_step
		end

	set_leap (a_leap: INTEGER) is
			-- Assign `a_leap' to `leap'.
		require
			a_leap_positive: a_leap > 0
		do
			implementation.set_leap (a_leap)
		ensure
			a_leap_ssigned: leap = a_leap
		end

	set_minimum (a_minimum: INTEGER) is
			-- Assign `a_minimum' to `minimum'.
		require
			a_minimum_not_greater_than_maximum:
				a_minimum <= maximum
			a_minimum_not_greater_than_value:
				a_minimum <= value			
		do
			implementation.set_minimum (a_minimum)
		ensure
			a_minimum_assigned: minimum = a_minimum
		end

	set_maximum (a_maximum: INTEGER) is
			-- Assign `a_maximum' to `maximum'.
		require
			a_maximum_not_smaller_than_minimum:
				a_maximum >= minimum
			a_maximum_not_smaller_than_value:
				a_maximum >= value			
		do
			implementation.set_maximum (a_maximum)
		ensure
			a_maximium_assigned: maximum = a_maximum
		end

	set_range (a_range: INTEGER_INTERVAL) is
			-- Assign `a_range' to `range'.
		require
			a_range_not_void: a_range /= Void
			a_range_not_empty: not a_range.empty
			a_range_has_value: a_range.has (value)
		do
			implementation.set_range (a_range)
		ensure
			a_range_assigned: range.is_equal (a_range)
			minimum_consistent: minimum = a_range.lower
			maximum_consistent: maximum = a_range.upper
		end

	reset_with_range (a_range: INTEGER_INTERVAL) is
			-- Assign `a_range' to `range'.
			-- Set `value' to `a_range'.lower.
		require
			a_range_not_void: a_range /= Void
			a_range_not_empty: not a_range.empty
		do
			implementation.reset_with_range (a_range)
		ensure
			a_range_assigned: range.is_equal (a_range)
			value_assigned: value = a_range.lower
			minimum_consistent: minimum = a_range.lower
			maximum_consistent: maximum = a_range.upper
		end

feature -- Status setting

	set_proportion (a_proportion: REAL) is
			-- Move `value' to `a_proportion' within `range'.
		require
			a_proportion_within_range: a_proportion >= 0 and a_proportion <= 1
		do
			implementation.set_proportion (a_proportion)
		end

feature -- Event handling

	change_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when `value' changes.

feature {NONE} -- Implementation

	implementation: EV_GAUGE_I
			-- Responsible for interaction with the native graphics toolkit.

	create_action_sequences is
			-- See `{EV_ANY}.create_action_sequences'.
		do
			Precursor
			create change_actions
		end

feature {EV_ANY} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state.
		do
			Result := Precursor and then
				maximum = 100 and then
				minimum = 0 and then
				value = 0 and then
				step = 1 and then
				leap = 10 and then
				proportion = 0
		end

	make_for_test is
			-- Create with update timer for testing.
		local
			step_timer: EV_TIMEOUT
			reset_timer: EV_TIMEOUT
		do
			{EV_PRIMITIVE} Precursor
			set_minimum (0)
			set_maximum (10)
			set_step (1)
			create step_timer.make_with_interval (1000)
			step_timer.actions.extend (~step_forward)
			create reset_timer.make_with_interval (10000)
			reset_timer.actions.extend (~set_value (0))
		end

invariant
	range_not_void: is_useable implies range /= Void
	maximum_greater_than_or_equal_to_minimum: is_useable implies
		maximum >= minimum
	value_within_bounds: is_useable implies
		value >= minimum and then value <= maximum
	step_positive: is_useable implies step > 0
	leap_positive: is_useable implies leap > 0
	change_actions_not_void: is_useable implies
		change_actions /= Void
	proportion_within_range: is_useable implies
		proportion >= 0 and proportion <= 1
	proportion_definition: is_useable implies
		maximum = minimum implies proportion = 0.0
	proportion_correct_value: (is_useable and maximum /= minimum) implies
		value / (maximum - minimum) = proportion

	--| FIXME VB 02/14/2000
	--| This should work but it does not for melted code.
	--range_not_empty: is_useable implies not range.empty
	--maximum_consistent: is_useable implies range.upper = maximum
	--minimum_consistent: is_useable implies range.lower = minimum
	--value_in_range: is_useable implies range.has (value)

end -- class EV_GAUGE

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
--| Revision 1.14  2000/04/13 18:01:18  brendel
--| Revised. Added proportion and set_proportion.
--| Default value for minimum is now 0.
--|
--| Revision 1.13  2000/03/21 19:10:39  oconnor
--| comments, formatting
--|
--| Revision 1.12  2000/03/01 20:07:36  king
--| Corrected export clauses for implementation and create_imp/act_seq
--|
--| Revision 1.11  2000/03/01 03:30:06  oconnor
--| added make_for_test
--|
--| Revision 1.10  2000/02/19 20:24:42  brendel
--| Updated copyright to 1986-2000.
--|
--| Revision 1.9  2000/02/15 16:33:52  brendel
--| Added `is_in_default_state'.
--|
--| Revision 1.8  2000/02/15 02:15:39  brendel
--| Put back invariant in commented out form with message that it only works
--| in freezed code.
--|
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
--| The comment on ev_gauge now corerctly reads: Actions performed when `value'
--| changes.
--|
--| Revision 1.2.6.9  2000/02/02 00:55:29  brendel
--| Added features for leaping (or scrolling by page), since they were first
--| defined in scrollbar and range, but could as well be defined for spinbutton
--| and progress bar. If not, they can be undefined there.
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
