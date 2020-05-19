note
	description: "Facility routines to check the validity of a DATE_TIME_CODE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_VALIDITY_CHECKER

feature -- Preconditions

	is_code (s: READABLE_STRING): BOOLEAN
			-- Is the string a code?
		require
			s_exists: s /= Void
		do
			Result := is_colon (s) or
			is_comma (s) or is_day (s) or
			is_day0 (s) or is_day_text (s) or
			is_dot (s) or is_fractional_second (s) or
			is_hour (s) or is_hour0 (s) or is_hour12 (s) or
			is_hour12_0 (s) or is_meridiem (s) or
			is_minus (s) or is_minute (s) or
			is_minute0 (s) or is_month (s) or
			is_month0 (s) or is_month_text (s) or
			is_second (s) or is_second0 (s) or
			is_slash (s) or is_space (s) or
			is_year2 (s) or is_year4 (s)
		end

	is_day (s: READABLE_STRING): BOOLEAN
			-- Is the code a day-numeric?
		require
			s_exists: s /= Void
		do
			Result := s.same_string ("dd")
		ensure
			definition: Result = s.same_string ("dd")
		end

	is_day0 (s: READABLE_STRING): BOOLEAN
			-- Is the code a day-numeric
			-- Padded with zero?
		require
			s_exists: s /= Void
		do
			Result := s.same_string ("[0]dd")
		ensure
			definition: Result = s.same_string ("[0]dd")
		end

	is_day_text (s: READABLE_STRING): BOOLEAN
			-- Is the code a day-text?
		require
			s_exists: s /= Void
		do
			Result := s.same_string ("ddd")
		ensure
			definition: Result = s.same_string ("ddd")
		end

	is_year4 (s: READABLE_STRING): BOOLEAN
			-- Is the code a year-numeric
			-- On 4 figures?
		require
			s_exists: s /= Void
		do
			Result := s.same_string ("yyyy")
		ensure
			definition: Result = s.same_string ("yyyy")
		end

	is_year2 (s: READABLE_STRING): BOOLEAN
			-- Is the code a year-numeric
			-- On 2 figures?
		require
			s_exists: s /= Void
		do
			Result := s.same_string ("yy")
		ensure
			definition: Result = s.same_string ("yy")
		end

	is_month (s: READABLE_STRING): BOOLEAN
			-- Is the code a month-numeric?
		require
			s_exists: s /= Void
		do
			Result := s.same_string ("mm")
		ensure
			definition: Result = s.same_string ("mm")
		end

	is_month0 (s: READABLE_STRING): BOOLEAN
			-- Is the code a month-numeric
			-- Padded with zero?
		require
			s_exists: s /= Void
		do
			Result := s.same_string ("[0]mm")
		ensure
			definition: Result = s.same_string ("[0]mm")
		end

	is_month_text (s: READABLE_STRING): BOOLEAN
			-- Is the code a month-text?
		require
			s_exists: s /= Void
		do
			Result := s.same_string ("mmm")
		ensure
			definition: Result = s.same_string ("mmm")
		end

	is_hour (s: READABLE_STRING): BOOLEAN
			-- Is the code a 24-hour-clock-scale?
		require
			s_exists: s /= Void
		do
			Result := s.same_string ("hh")
		ensure
			definition: Result = s.same_string ("hh")
		end

	is_hour0 (s: READABLE_STRING): BOOLEAN
			-- Is the code a 24-hour-clock-scale
			-- Padded with zero?
		require
			s_exists: s /= Void
		do
			Result := s.same_string ("[0]hh")
		ensure
			definition: Result = s.same_string ("[0]hh")
		end

	is_hour12 (s: READABLE_STRING): BOOLEAN
			-- Is the code a 12-hour-clock-scale?
		require
			s_exists: s /= Void
		do
			Result := s.same_string ("hh12")
		ensure
			definition: Result = s.same_string ("hh12")
		end

	is_hour12_0 (s: READABLE_STRING): BOOLEAN
			-- Is the code a 12-hour-clock-scale padded with zero?
		require
			s_exists: s /= Void
		do
			Result := s.same_string ("[0]hh12")
		ensure
			definition: Result = s.same_string ("[0]hh12")
		end

	is_minute (s: READABLE_STRING): BOOLEAN
			-- Is the code a minute-numeric?
		require
			s_exists: s /= Void
		do
			Result := s.same_string ("mi")
		ensure
			definition: Result = s.same_string ("mi")
		end

	is_minute0 (s: READABLE_STRING): BOOLEAN
			-- Is the code a minute-numeric
			-- Padded with zero?
		require
			s_exists: s /= Void
		do
			Result := s.same_string ("[0]mi")
		ensure
			definition: Result = s.same_string ("[0]mi")
		end

	is_second (s: READABLE_STRING): BOOLEAN
			-- Is the code a second-numeric?
		require
			s_exists: s /= Void
		do
			Result := s.same_string ("ss")
		ensure
			definition: Result = s.same_string ("ss")
		end

	is_second0 (s: READABLE_STRING): BOOLEAN
			-- Is the code a second-numeric
			-- Padded with zero?
		require
			s_exists: s /= Void
		do
			Result := s.same_string ("[0]ss")
		ensure
			definition: Result = s.same_string ("[0]ss")
		end

	is_fractional_second (s: READABLE_STRING): BOOLEAN
			-- Is the code a fractional-second
			-- With precision to n figures?
		require
			s_exists: s /= Void
		do
			if s.count > 2 then
				Result := s.substring (1, 2).same_string ("ff") and s.substring (3, s.count).is_integer
			end
		ensure
			definition: Result = (s.count > 2 and then (s.substring (1, 2).same_string ("ff") and
									s.substring (3, s.count).is_integer))
		end

	is_colon (s: READABLE_STRING): BOOLEAN
			-- Is the code a separator-colomn?
		require
			s_exists: s /= Void
		do
			Result := s.same_string (":")
		ensure
			definition: Result = s.same_string (":")
		end

	is_slash (s: READABLE_STRING): BOOLEAN
			-- Is the code a separator-slash?
		require
			s_exists: s /= Void
		do
			Result := s.same_string ("/")
		ensure
			definition: Result = s.same_string ("/")
		end

	is_minus (s: READABLE_STRING): BOOLEAN
			-- Is the code a separator-minus?
		require
			s_exists: s /= Void
		do
			Result := s.same_string ("-")
		ensure
			definition: Result = s.same_string ("-")
		end

	is_comma (s: READABLE_STRING): BOOLEAN
			-- Is the code a separator-coma?
		require
			s_exists: s /= Void
		do
			Result := s.same_string (",")
		ensure
			definition: Result = s.same_string (",")
		end

	is_space (s: READABLE_STRING): BOOLEAN
			-- Is the code a separator-space?
		require
			s_exists: s /= Void
		do
			Result := s.same_string (" ")
		ensure
			definition: Result = s.same_string (" ")
		end

	is_dot (s: READABLE_STRING): BOOLEAN
			-- Is the code a separator-dot?
		require
			s_exists: s /= Void
		do
			Result := s.same_string (".")
		ensure
			definition: Result = s.same_string (".")
		end

	is_separator (s: READABLE_STRING): BOOLEAN
			-- Is the code a separator?
		require
			s_exists: s /= Void
		do
			Result := is_slash (s) or else is_colon (s) or else
				is_minus (s) or else is_comma (s) or else is_space (s) or else
				is_dot (s)
		ensure
			definition: Result = is_slash (s) or else is_colon (s) or else
						is_minus (s) or else is_comma (s) or else
						is_space (s) or else is_dot (s)
		end

	is_meridiem (s: READABLE_STRING): BOOLEAN
			-- Is the code a meridiem notation?
		require
			s_exists: s /= Void
		do
			Result := s.is_case_insensitive_equal ("AM") or s.is_case_insensitive_equal ("PM")
		ensure
			definition: Result = s.is_case_insensitive_equal ("AM") or
								s.is_case_insensitive_equal ("PM")
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
