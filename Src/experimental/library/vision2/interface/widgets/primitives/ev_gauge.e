note
	description:
		"[
			Base class for widgets that display `value' within a `value_range'.
			See EV_RANGE, EV_SCROLL_BAR, EV_SPIN_BUTTON and EV_PROGRESS_BAR.
		]"
	legal: "See notice at end of class."
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
			is_in_default_state
		end

	EV_GAUGE_ACTION_SEQUENCES
		redefine
			implementation
		end

feature {NONE} -- Initialization

	make_with_value_range (a_value_range: INTEGER_INTERVAL)
			-- Create and assign `a_value_range' to `value_range'.
		require
			a_value_range_not_void: a_value_range /= Void
			a_value_range_not_empty: not a_value_range.is_empty
		do
			default_create
			value_range.resize_exactly (a_value_range.lower, a_value_range.upper)
		end

feature -- Access

	value: INTEGER
			-- Current position within `value_range'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.value
		ensure
			bridge_ok: Result = implementation.value
		end

	step: INTEGER
			-- Size of change made by `step_forward' or `step_backward'.
			-- Default: 1
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.step
		ensure
			bridge_ok: Result = implementation.step
		end

	leap: INTEGER
			-- Size of change made by `leap_forward' or `leap_backward'.
			-- Default: 10
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.leap
		ensure
			bridge_ok: Result = implementation.leap
		end

	value_range: INTEGER_INTERVAL
			-- Range of `value'.
			-- Default: 0 |..| 100
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.value_range
		ensure
			bridge_ok: Result /= Void and then
				Result.is_equal (implementation.value_range)
		end

feature -- Status report

	proportion: REAL
			-- Relative position of `value' in `value_range'.
			-- Range: [0, 1]. Default: 0.0
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.proportion
		ensure
			bridge_ok: Result = implementation.proportion
		end

feature -- Status setting

	step_forward
			-- Increment `value' by `step' if within `value_range'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.step_forward
		ensure
			incremented: value = value_range.upper.min (old value + step)
		end

	step_backward
			-- Decrement `value' by `step' if within `value_range'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.step_backward
		ensure
			decremented: value = value_range.lower.max (old value - step)
		end

	leap_forward
			-- Increment `value' by `leap' if within `value_range'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.leap_forward
		ensure
			incremented: value = value_range.upper.min (old value + leap)
		end

	leap_backward
			-- Decrement `value' by `leap' if within `value_range'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.leap_backward
		ensure
			decremented: value = value_range.lower.max (old value - leap)
		end

	set_proportion (a_proportion: REAL)
			-- Move `value' to `a_proportion' within `value_range'.
		require
			not_destroyed: not is_destroyed
			a_proportion_within_range: a_proportion >= 0 and a_proportion <= 1
		do
			implementation.set_proportion (a_proportion)
		end

feature -- Element change

	set_value (a_value: INTEGER)
			-- Assign `a_value' to `value'.
		require
			not_destroyed: not is_destroyed
			value_in_range: value_range.has (a_value)
		do
			implementation.set_value (a_value)
		ensure
			a_value_assigned: value = a_value
		end

	set_step (a_step: INTEGER)
			-- Assign `a_step' to `step'.
		require
			not_destroyed: not is_destroyed
			a_step_positive: a_step > 0
		do
			implementation.set_step (a_step)
		ensure
			a_step_assigned: step = a_step
		end

	set_leap (a_leap: INTEGER)
			-- Assign `a_leap' to `leap'.
		require
			not_destroyed: not is_destroyed
			a_leap_positive: a_leap > 0
		do
			implementation.set_leap (a_leap)
		ensure
			a_leap_assigned: leap = a_leap
		end

feature {EV_ANY} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_PRIMITIVE} and then
				value_range.is_equal (0 |..| 100) and then
				value = 0 and then
				step = 1 and then
				leap = 10 and then
				proportion = 0
		end

	delta: REAL
			-- Amount by which `proportion' can differ from expected value
			-- and still be considered correct.
		do
			Result := ((value_range.upper - value_range.lower) / (step * 10000)).truncated_to_real
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_GAUGE_I
			-- Responsible for interaction with native graphics toolkit.

invariant
	range_not_void: is_usable implies value_range /= Void
	range_not_empty: is_usable implies not value_range.is_empty
	value_in_range: is_usable implies value_range.has (value)
	step_positive: is_usable implies step > 0
	leap_positive: is_usable implies leap > 0
	change_actions_not_void: is_usable implies
		change_actions /= Void
	proportion_within_range: is_usable implies
		proportion >= 0.0 and proportion <= 1.0
	proportion_definition: is_usable implies
		(value_range.upper = value_range.lower implies proportion = 0.0)
	proportion_correct_value: (is_usable and value_range.upper /= value_range.lower) implies
		((value - value_range.lower) / (value_range.upper - value_range.lower)).abs
		- proportion < delta

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_GAUGE

