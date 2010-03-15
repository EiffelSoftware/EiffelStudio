note
	description: "Time Measurable Units"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class TIME_MEASUREMENT inherit

	TIME_CONSTANTS

feature -- Access

	hour: INTEGER
		-- Number of hours associated with current object
		deferred
		end


	minute: INTEGER
		-- Number of minutes associated with current object
		deferred
		end

	second: INTEGER
		-- Number of seconds associated with current object.
		deferred
		end

	fine_second: DOUBLE
		-- Number of fine seconds associated with current object
		deferred
		end

feature -- Settings

	set_second (s: INTEGER)
			-- Set `second' to `s'.
		require
			s_large_enough: s >= 0;
			s_small_enough: s < Seconds_in_minute
		deferred
		ensure
			second_set: second = s
		end

	set_fine_second (s: DOUBLE)
			-- Set `fine_second' to `s'
		require
			s_large_enough: s >= 0;
			s_small_enough: s < Seconds_in_minute
		deferred
		ensure
			fine_second_set: fine_second = s
		end

	set_fractionals (f: DOUBLE)
			-- Set `fractional_second' to `f'.
		require
			f_large_enough: f >= 0
			f_small_enough: f < 1
		deferred
		ensure
			second_same: second = old second
		end

	set_minute (m: INTEGER)
			-- Set `minute' to `m'.
		require
			m_large_enough: m >= 0
			m_small_enough: m < Minutes_in_hour
		deferred
		ensure
			minute_set: minute = m
		end

	set_hour (h: INTEGER)
			-- Set `hour' to `h'.
		require
			h_large_enough: h >= 0;
			h_small_enough: h < Hours_in_day
		deferred
		ensure
			hour_set: hour = h
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class TIME_MEASUREMENT


