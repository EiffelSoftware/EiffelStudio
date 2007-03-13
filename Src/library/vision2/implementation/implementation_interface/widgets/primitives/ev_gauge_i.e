indexing
	description: "Eiffel Vision gauge. Implementation interface."
	legal: "See notice at end of class."
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

	EV_GAUGE_ACTION_SEQUENCES_I

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

	value_range: ACTIVE_INTEGER_INTERVAL
			-- Range of `value'.

feature -- Status report

	proportion: REAL is
			-- Relative position of `value' in `range'. Range: [0, 1].
		local
			u, l: INTEGER
		do
			u := value_range.upper
			l := value_range.lower
			if u /= l then
				Result := (value - l) / (u - l)
			else
				--| By definition:
				Result := 0.0
			end
		end

feature -- Status setting

	step_forward is
			-- Increment `value' by `step' if possible.
		deferred
		ensure
			incremented: value = old value + step
				or else value = value_range.upper
		end

	step_backward is
			-- Decrement `value' by `step' if possible.
		deferred
		ensure
			decremented: value = old value - step
				or else value = value_range.lower
		end

	leap_forward is
			-- Increment `value' by `leap' if possible.
		deferred
		ensure
			incremented: value = old value + leap
				or else value = value_range.upper
		end

	leap_backward is
			-- Decrement `value' by `leap' if possible.
		deferred
		ensure
			decremented: value = old value - leap
				or else value = value_range.lower
		end

feature -- Element change

	set_value (a_value: INTEGER) is
			-- Set `value' to `a_value'.
		require
			value_in_range: value_range.has (a_value)
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

feature -- Status setting

	set_proportion (a_proportion: REAL) is
			-- Move `value' to `a_proportion' within `range'.
		require
			a_proportion_within_range: a_proportion >= 0 and a_proportion <= 1
		local
			u, l: INTEGER
		do
			u := value_range.upper
			l := value_range.lower
			if u /= l then
				set_value (((u - l).to_real * a_proportion).rounded + l)
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_GAUGE

invariant

	value_range_not_void: is_usable implies value_range /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_GAUGE_I

