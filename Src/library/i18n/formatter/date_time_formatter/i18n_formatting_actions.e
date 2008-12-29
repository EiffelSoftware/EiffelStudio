note
	description: "Actions used by the various 'formatting' elements"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_FORMATTING_ACTIONS

inherit
	ANY

	SHARED_I18N_FORMATTING_UTILITY
		export
			{NONE} all
		end

feature -- Time related actions

	hour_12_padded_action (a_time: TIME): STRING_32
			-- Returns  Hours with leading zeros for
			-- single-digit hours (12-hour clock).
			-- associated to formatting character `hour_12_padded'
		require
			a_time_exists: a_time /= Void
		do
			if a_time.hour > 12 then
				Result :=  fu.pad_with_0_left (a_time.hour-12, 2)
			else
				Result :=  fu.pad_with_0_left (a_time.hour, 2)
			end
		ensure
			result_exists: Result /= Void
		end

	hour_12_action (a_time: TIME): STRING_32
			-- Returns Hours without leading zeros
			-- for single-digit hours (12-hour clock).
			-- associated to formatting character `hour_12'
		require
			a_time_exists: a_time /= Void
		do
			if a_time.hour > 12 then
				Result :=  (a_time.hour-12).out
			else
				Result :=  a_time.hour.out
			end
		ensure
			result_exists: Result /= Void
		end

	hour_24_action (a_time: TIME): STRING_32
			-- Returns Hours without leading zeros
			-- for single-digit hours (24-hour clock)
			-- associated to formatting character `hour_24'
		require
			a_time_exists: a_time /= Void
		do
			Result := a_time.hour.out
		ensure
			result_exists: Result /= Void
		end

	hour_24_padded_action (a_time: TIME): STRING_32
			-- Returns Hours with leading zeros
			-- for single-digit hours (24-hour clock)
			-- associated to `'
			-- associated to formatting character `hour_24_padded'
		require
			a_time_exists: a_time /= Void
		do
			Result :=  fu.pad_with_0_left (a_time.hour, 2)
		ensure
			result_exists: Result /= Void
		end

	minutes_action (a_time: TIME): STRING_32
			-- Returns  Minutes without leading
			-- zeros for single-digit minutes.
			-- associated to formatting character `minutes'
		require
			a_time_exists: a_time /= Void
		do
			Result := a_time.minute.out
		ensure
			result_exists: Result /= Void
		end

	minutes_padded_action (a_time: TIME): STRING_32
			-- Returns the minute as a decimal number
			-- with leading zeros for single-digit minutes.
			-- associated to formatting character `minutes_padded'
		require
			a_time_exists: a_time /= Void
		do
			Result :=  fu.pad_with_0_left (a_time.minute, 2)
		ensure
			result_exists: Result /= Void
		end

	seconds_action (a_time: TIME): STRING_32
			-- Returns seconds without leading zeros for single-digit seconds.
			-- associated to formatting character `seconds'
		require
			a_time_exists: a_time /= Void
		do
			Result := a_time.second.out
		ensure
			result_exists: Result /= Void
		end

	seconds_padded_action (a_time: TIME): STRING_32
			-- Returns seconds with leading zeros for single-digit seconds.
			-- associated to formatting character `seconds_padded'
		require
			a_time_exists: a_time /= Void
		do
			Result :=  fu.pad_with_0_left (a_time.second, 2)
		ensure
			result_exists: Result /= Void
		end

	am_pm_1_action (a_time: TIME): STRING_32
			-- Returns one-character time marker string. (Am/pm -> a/p)
			-- associated to formatting character `am_pm_1'
		require
			a_time_exists: a_time /= Void
		do
			if a_time.hour > 12 then
				Result :=  "p"
			else
				Result :=  "m"
			end
		ensure
			result_exists: Result /= Void
			correct_result: (a_time.hour <= 12 implies Result.is_equal ("a")) xor
							(a_time.hour > 12 implies Result.is_equal ("p"))
		end

	am_pm_lowercase_action (a_time: TIME; a_locale_info: I18N_LOCALE_INFO): STRING_32
			-- Returns multi-character time marker string  Lowercase
			-- associated to formatting character `am_pm_lowercase'
		require
			a_time_exists: a_time /= Void
			a_locale_info_exists: a_locale_info /= Void
		do
			if a_time.hour > 12 then
				Result :=  a_locale_info.pm_suffix
			else
				Result :=  a_locale_info.am_suffix
			end
			if Result.is_valid_as_string_8 then
				Result.to_lower
			end
		ensure
			result_exists: Result /= Void
			is_lower: Result.is_valid_as_string_8 implies Result.as_lower.is_equal (Result)
		end

	am_pm_uppercase_action (a_time: TIME; a_locale_info: I18N_LOCALE_INFO): STRING_32
			-- Returns multi-character time marker string (Uppercase)
			-- associated to formatting character `am_pm_uppercase'
		require
			a_time_exists: a_time /= Void
			a_locale_info_exists: a_locale_info /= Void
		do
			if a_time.hour > 12 then
				Result :=  a_locale_info.pm_suffix
			else
				Result :=  a_locale_info.am_suffix
			end
			if Result.is_valid_as_string_8 then
				Result.to_upper
			end
		ensure
			result_exists: Result /= Void
			is_upper: Result.is_valid_as_string_8 implies Result.as_upper.is_equal (Result)
		end

feature -- Date related actions

	day_of_month_action (a_date: DATE): STRING_32
			-- Returns day of the month as digits without
			-- leading zeros for single digit days.
			-- associated to formatting character `day_of_month'
		require
			a_date_exists: a_date /= Void
		do
			Result := a_date.day.out
		ensure
			result_exists: Result /= Void
		end

	day_of_month_padded_action (a_date: DATE): STRING_32
			-- Returns the day of the month as a decimal number (range 01 to 31)
			-- associated to formatting character `day_of_month_padded'
		require
			a_date_exists: a_date /= Void
		do
			Result := fu.pad_with_0_left (a_date.day, 2)
		ensure
			result_exists: Result /= Void
		end

	abbreviated_day_name_action (a_date: DATE; a_locale_info: I18N_LOCALE_INFO): STRING_32
			-- Returns the abbreviated day name
			-- associated to formatting character `abbreviated_day_name'
		require
			a_date_exists: a_date /= Void
			a_locale_info_exists: a_locale_info /= Void
		do
			Result := a_locale_info.abbreviated_day_names.item (a_date.day_of_the_week)
		ensure
			result_exists: Result /= Void
		end

	day_name_action (a_date: DATE; a_locale_info: I18N_LOCALE_INFO): STRING_32
			-- Returns the abbreviated day name
			-- associated to formatting character `day_name'
		require
			a_date_exists: a_date /= Void
			a_locale_info_exists: a_locale_info /= Void
		do
			Result := a_locale_info.day_names.item (a_date.day_of_the_week)
		ensure
			result_exists: Result /= Void
		end

	day_of_year_action (a_date: DATE): STRING_32
			-- Returns the day of the year as a decimal number (range 001 366)
			-- associated to formatting character `day_of_year'
		require
			a_date_exists: a_date /= Void
		do
			Result := fu.pad_with_0_left(a_date.year_day,3)
		ensure
			result_exists: Result /= Void
		end

	day_of_week_action (a_date: DATE): STRING_32
			-- Retunr the fay of the weel as a decimal number,
			-- range 1 to 7, Monday being 1
			-- associated to formatting character `day_of_week'
		require
			a_date_exists: a_date /= Void
		do
			Result := (a_date.day_of_the_week+1).out
		ensure
			result_exists: Result /= Void
		end

	day_of_week_0_action (a_date: DATE): STRING_32
			-- Returns the day of the week as a decimal,
			-- range 0 to 6, Sunday being 0.
			-- associated to formatting character `day_of_week_0'
		require
			a_date_exists: a_date /= Void
		do
			Result := a_date.day_of_the_week.out
		ensure
			result_exists: Result /= Void
		end

	month_action (a_date: DATE): STRING_32
			-- Returns month as digits without leading zeros for single digit months.
			-- associated to formatting character `month'
		require
			a_date_exists: a_date /= Void
		do
			Result := a_date.month.out
		ensure
			result_exists: Result /= Void
		end

	month_padded_action (a_date: DATE): STRING_32
			-- Returns the month as a decimal number (range 01 to 12).
			-- associated to formatting character `month_padded'
		require
			a_date_exists: a_date /= Void
		do
			Result := fu.pad_with_0_left(a_date.month,2)
		ensure
			result_exists: Result /= Void
		end

	abbreviated_month_name_action (a_date: DATE; a_locale_info: I18N_LOCALE_INFO): STRING_32
			-- Returns the abbreviated month name
			-- associated to formatting character `abbreviated_month_name'
		require
			a_date_exists: a_date /= Void
			a_locale_info_exists: a_locale_info /= Void
		do
			Result := a_locale_info.abbreviated_month_names.item (a_date.month)
		ensure
			result_exists: Result /= Void
		end

	month_name_action (a_date: DATE; a_locale_info: I18N_LOCALE_INFO): STRING_32
			-- Returns the full month name
			-- associated to formatting character `month_name'
		require
			a_date_exists: a_date /= Void
			a_locale_info_exists: a_locale_info /= Void
		do
			Result := a_locale_info.month_names.item (a_date.month)
		ensure
			result_exists: Result /= Void
		end

	century_number_action (a_date: DATE): STRING_32
			-- Returns the century number (year/100) as a 2-digit integer
			-- associated to formatting character `century_number'
		require
			a_date_exists: a_date /= Void
		do
			Result := (a_date.year // 100).out
		ensure
			result_exists: Result /= Void
		end

	week_number_iso_action (a_date: DATE): STRING_32
			-- Returns the ISO 8601:1988 week number of the current year as a decimal number,
			-- range 01 to 53, where week 1 is the first
			-- associated to formatting character `week_number_iso'
		require
			a_date_exists: a_date /= Void
		do
			Result := fu.pad_with_0_left (a_date.week_of_year+1, 2)
		ensure
			result_exists: Result /= Void
		end

	week_number_sunday_as_first_action (a_date: DATE): STRING_32
			-- Returns the week number of the current year as a decimal number, range 00 to 53,
			-- starting with the first Monday as the first day of week 01
			-- associated to formatting character `week_number_sunday'
		require
			a_date_exists: a_date /= Void
		do
			Result := fu.pad_with_0_left (a_date.week_of_year, 2)
		ensure
			result_exists: Result /= Void
		end

	week_number_monday_as_first_action (a_date: DATE): STRING_32
			-- Not supported, result is the same as `week_number_sunday_as_first_action'
			-- associated to formatting character `week_number_monday'
		require
			a_date_exists: a_date /= Void
		do
			Result := fu.pad_with_0_left (a_date.week_of_year, 2)
		ensure
			result_exists: Result /= Void
		end

	iso_year_with_century_action (a_date: DATE): STRING_32
			-- Same result as Year_4_action
			-- associated to formatting character `iso_year_with_century'
		require
			a_date_exists: a_date /= Void
		do
			Result := a_date.year.out
		ensure
			result_exists: Result /= Void
		end

	iso_year_without_century_action (a_date: DATE): STRING_32
			-- Same result as Year_2_action
			-- associated to formatting character `iso_year_without_century'
		require
			a_date_exists: a_date /= Void
		do
			Result := fu.pad_with_0_left (a_date.year \\ 100,2)
		ensure
			result_exists: Result /= Void
		end

	year_1_action (a_date: DATE): STRING_32
			--  Year represented only by the last digit.
			-- associated to formatting character `year_1'
		require
			a_date_exists: a_date /= Void
		do
			Result := fu.pad_with_0_left (a_date.year \\ 10,1)
		ensure
			result_exists: Result /= Void
			correct_lenght: Result.count = 1
		end

	year_2_action (a_date: DATE): STRING_32
			--  Returns the year as a decimal number without a century (range 00 to 99).
			-- associated to formatting character `year_2'
		require
			a_date_exists: a_date /= Void
		do
			Result := fu.pad_with_0_left (a_date.year \\ 100,2)
		ensure
			result_exists: Result /= Void
			correct_lenght: Result.count = 2
		end

	year_4_action (a_date: DATE): STRING_32
			-- Returns the Year represented by full four or five digits, depending on the calendar used.
			-- associated to formatting character `year_4'
		require
			a_date_exists: a_date /= Void
		do
			Result := a_date.year.out
		ensure
			result_exists: Result /= Void
		end

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
