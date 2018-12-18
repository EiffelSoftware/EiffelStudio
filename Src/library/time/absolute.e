note
	description: "Absolute temporal values"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	access: date, time

deferred class
	ABSOLUTE

inherit
	COMPARABLE

feature -- Access

	origin: like Current
			-- Place of start for recording objects.
		deferred
		ensure
			result_exists: Result /= Void
		end

feature -- Measurement

	duration: DURATION
			-- Length of the interval of time since `origin'.
		deferred
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is the current object before `other'?
		do
			Result := duration < other.duration
		end

feature -- Basic operations

	minus alias "-" (other: like Current): INTERVAL [like Current]
			-- Interval between current object and `other'.
		require
			other_exists: other /= Void
			other_smaller_than_current: other <= Current
		do
			create Result.make (other, Current)
		ensure
			result_exists: Result /= Void
			result_set: Result.start_bound.is_equal (other) and then
					Result.end_bound.is_equal (Current)
		end

	relative_duration (other: like Current): DURATION
			-- Relative duration from `Current' to `other'.
		require
			other_exists: other /= Void
		deferred
		ensure
			Result_exists: Result /= Void
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
