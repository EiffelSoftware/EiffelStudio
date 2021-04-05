note
	description: "Universal constants about dates"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	access: date

class
	DATE_CONSTANTS

inherit
	TIME_UTILITY
		export
			{NONE} mod, div
		end

feature -- Access

	Days_in_week: INTEGER = 7
				-- Number of days in a week

	Max_weeks_in_year: INTEGER = 53
				-- Maximun number of weeks in a year

	Months_in_year: INTEGER = 12
				-- Number of months in year

	Days_in_leap_year: INTEGER = 366
				-- Number of days in a leap year

	Days_in_non_leap_year: INTEGER = 365
				-- Number of days in a non-leap year

	days_in_i_th_month (i, y: INTEGER): INTEGER
			-- Number of days in the `i' th month at year `y'
		require
			i_large_enough: i >= 1;
			i_small_enough: i <= Months_in_year
		do
			Result := Days_in_months [i]
			if i = 2 and then is_leap_year (y) then
				Result := Result + 1
			end
		end;

	date_default_format_string: STRING
			-- Default output format for dates
		do
			Result := date_time_tools.date_default_format_string
		end

	days_text: ARRAY [STRING]
			-- Short text representation of days
		do
			Result := date_time_tools.days_text
		end

	months_text: ARRAY [STRING]
			-- Short text representation of months
		do
			Result := date_time_tools.months_text
		end

	long_days_text: ARRAY [STRING]
			-- Long text representation of days
		do
			Result := date_time_tools.long_days_text
		end

	long_months_text: ARRAY [STRING]
			-- Long text representation of months
		do
			Result := date_time_tools.long_months_text
		end

feature -- Status report

	is_leap_year (y: INTEGER): BOOLEAN
			-- Is year `y' a leap year?
		do
			Result := (mod (y, 4) = 0) and ((mod (y, 100) /= 0) or
				(mod (y, 400) = 0))
		end

feature {NONE} -- Implementation

	Days_in_months: ARRAY [INTEGER]
			-- Array containing number of days for each month of
			-- a non-leap year.
		once
			Result := <<31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31>>
		ensure
			result_exists: Result /= Void
			valid_count: Result.count = Months_in_year
		end

note
	ca_ignore: "CA011", "CA011: too many arguments"
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
