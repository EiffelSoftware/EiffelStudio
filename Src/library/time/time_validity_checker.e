note
	description: "Facility routines to check the validity of TIMEs"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TIME_VALIDITY_CHECKER

inherit
	TIME_CONSTANTS
		export
			{NONE} all
		end

	TIME_VALUE
		export
			{NONE} all
		end

	ANY

feature -- Preconditions

	time_valid (s: READABLE_STRING; code_string: READABLE_STRING): BOOLEAN
			-- Is the code_string enough precise
			-- to create an instance of type TIME?
			-- And does the string `s' correspond to `code_string'?
		require
			s_exists: s /= Void
			code_exists: code_string /= Void
		local
			code: DATE_TIME_CODE_STRING
		do
			create code.make (code_string)
			Result := code.precise_time and code.correspond (s) and then
				code.is_time (s)
		end

	compact_time_valid (c_t: INTEGER): BOOLEAN
			-- Is compact time `c_t' valid?
		local
			h, m, s: INTEGER
			l_c_t: like compact_time
		do
			l_c_t := compact_time
			compact_time := c_t
			h := hour
			m := minute
			s := second
			compact_time := l_c_t
			Result := h >= 0 and h < Hours_in_day and
				m >= 0 and m < Minutes_in_hour and
				s >= 0 and s < Seconds_in_minute
		end

	is_correct_time (h, m: INTEGER; s: DOUBLE;
					 twelve_hour_scale: BOOLEAN): BOOLEAN
			-- Is time represented by `h', `m', `code', and `s' correct?
			-- `twelve_hour_scale' specifies if the hour range is 1 - 12
			-- (if True) or 0 - 23 (if False).
		local
			min_hour: INTEGER
			max_hour: INTEGER
		do
			if twelve_hour_scale then
				min_hour := 1
				max_hour := 12
			else
				min_hour := 0
				max_hour := Hours_in_day - 1
			end

			Result := h >= min_hour and h <= max_hour and then
				m >= 0 and m < Minutes_in_hour and then s >= 0 and
				s < Seconds_in_minute
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
