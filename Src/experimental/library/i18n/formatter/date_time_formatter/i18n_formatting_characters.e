note
	description: "[
		Class that contains all formatting caracters
		defined in the POSIX standard, plus others that are
		date_separator, time_separator, Month, Year_1, Era,
		Minutes and Seconds_padded
		you can find them on:
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class I18N_FORMATTING_CHARACTERS

feature -- Constants

	Abbreviated_day_name: CHARACTER_8 = 'a'
			--  Abbreviated day of the week

	Abbreviated_month_name1: CHARACTER_8 = 'b'
			-- Abbreviated month name

	Abbreviated_month_name2: CHARACTER_8 = 'h'
			-- Abbreviated month name

	Am_pm_1: CHARACTER_8 = '8'
			--  One-character time marker string. (Am/pm -> a/p)

	Am_pm_lowercase: CHARACTER_8 = '9'
			--  Multi-character time marker string Lowercase

	Am_pm_time: CHARACTER_8 = 'r'
			--  The time in a.m. or p.m. notation.
			-- In the POSIX locale this is equivalent to `&I:&M:&S &p'

	Am_pm_uppercase: CHARACTER_8 = 'P'
			--  Multi-character time marker string Uppercase

	Century_number: CHARACTER_8 = 'C'
			--  The century number (year/100) as a 2-digit integer

	Day_name: CHARACTER_8 = 'A'
			--  The full weekday name according to the current locale.

	Day_of_month: CHARACTER_8 = 'e'
			--Day of the month as digits without leading zeros for single digit days.

	Day_of_month_padded: CHARACTER_8 = 'd'
			--  The day of the month as a decimal number (range 01 to 31)

	Day_of_week: CHARACTER_8 = 'u'
			-- The day of the week as a decimal, range 1 to 7, Monday being 1.

	Day_of_week_0: CHARACTER_8 = 'w'
			-- The day of the week as a decimal, range 0 to 6, Sunday being 0.

	Day_of_year: CHARACTER_8 = 'j'
			--  The day of the year as a decimal number (range 001 to 366).

	Era: CHARACTER_8 = '3'
			--  Period/era string as specified by the CAL_SERASTRING value.

	Hour_12: CHARACTER_8 = 'I'
			--  Hours without leading zeros for single-digit hours (12-hour clock).

	Hour_12_padded: CHARACTER_8 = 'l'
			--  Hours with leading zeros for single-digit hours (12-hour clock).

	Hour_24: CHARACTER_8 = 'k'
			--  Hours without leading zeros for single-digit hours (24-hour clock).

	Hour_24_padded: CHARACTER_8 = 'H'
			--  Hours with leading zeros for single-digit hours (24-hour clock).

	Iso_date: CHARACTER_8 = 'F'
			--  Equivalent to &Y-&m-&d (the ISO 8601 date format).

	Iso_year_with_century: CHARACTER_8 = 'G'
			--  The ISO 8601 year with century as a decimal number.

	Iso_year_without_century: CHARACTER_8 = 'g'
			--  The ISO 8601 year with century as a decimal number, but without century,
			-- i.e., with a 2-digit year (00-99).

	Local_date: CHARACTER_8 = 'x'
			--  The preferred date representation for the current locale without the time.

	Local_date_time: CHARACTER_8 = 'c'
			--  The preferred date and time representation for the current locale.

	Locale_time: CHARACTER_8 = 'X'
			--  The preferred time representation for the current locale without the date.

	Minutes: CHARACTER_8 = '4'
			--  Minutes without leading zeros for single-digit minutes.

	Minutes_padded: CHARACTER_8 = 'M'
			--  The minute as a decimal number (range 00 to 59)

	Month: CHARACTER_8 = '1'
			--  Month as digits without leading zeros for single digit months.

	Month_name: CHARACTER_8 = 'B'
			--  Month full name

	Month_padded: CHARACTER_8 = 'm'
			--  The month as a decimal number (range 01 to 12).

	New_line: CHARACTER_8 = 'n'
			--  New line character

	Seconds: CHARACTER_8 = 'S'
			--  Seconds without leading zeros for single-digit seconds.

	Seconds_padded: CHARACTER_8 = '5'
			--  The second as a decimal number (range 00 to 60).

	Short_time_24h: CHARACTER_8 = 'R'
			--  The time in 24-hour notation (&H:&M)

	Tab: CHARACTER_8 = 't'
			--  Insert a Tab

	Time_24h: CHARACTER_8 = 'T'
			--  The time in 24-hour notation (&H:&M:&S).

	Time_zone_name: CHARACTER_8 = 'Z'
			--  The time zone or name or abbreviation.

	Time_zone_offset: CHARACTER_8 = 'z'
			--  Time zone as hour offeset from GMT (Required to emit RFC 822-conformant
			-- dates (using "&a, &d &b &Y &H:&M:&S &z"))

	Usa_date: CHARACTER_8 = 'D'
			--  Equivalent to &m/&d/&y. (Yecch  for Americans only.

	Week_number_iso: CHARACTER_8 = 'V'
			--  The ISO 8601:1988 week number of the current year as a decimal number,
			-- range 01 to 53, where week 1 is the first

	Week_number_monday_as_first: CHARACTER_8 = 'W'
			--  The week number of the current year as a decimal number, range 00 to 53,
			-- starting with the first Monday as the first day of week 01

	Week_number_sunday_as_first: CHARACTER_8 = 'U'
			--  The week number of the current year as a decimal number, range 00 to 53,
			-- starting with the first Sunday as the first

	Year_1: CHARACTER_8 = '2'
			--  Year represented only by the last digit.

	Year_2: CHARACTER_8 = 'y'
			--  The year as a decimal number without a century (range 00 to 99).

	Year_4: CHARACTER_8 = 'Y'
			--  Year represented by full four or five digits, depending on the calendar used.

	Time_separator: CHARACTER_8 = ':'
	Date_separator: CHARACTER_8 = '/'

feature -- Modified Characters with &E

	Modified_base_year_name: CHARACTER_8 = 'C'
			-- Replaced by the name of the base year (period) in the locale's alternative representation.

	Modified_base_year_offset: CHARACTER_8 = 'y'
			-- Replaced by the offset from &EC (year only) in the locale's alternative representation.

	Modified_date: CHARACTER_8 = 'x'
			-- Replaced by the locale's alternative date representation.

	Modified_date_time: CHARACTER_8 = 'c'
			-- Replaced by the locale's alternative appropriate date and time representation.

	Modified_time: CHARACTER_8 = 'X'
			-- Replaced by the locale's alternative time representation.

	Modified_year: CHARACTER_8 = 'Y'
			-- Replaced by the full alternative year representation.

	Modifier_character_1: CHARACTER_8 = 'E'

feature -- Modified Characters with &O

	Escape_character: CHARACTER_8 = '&'
			--   escape character (to avoid character interpretation)

	Modified_day_of_month_0_padded: CHARACTER_8 = 'd'
			-- Replaced by the day of the month, using the locale's alternative numeric symbols,
			-- filled as needed with leading zeros if there is any alternative symbol for zero;
			-- otherwise, with leading spaces.

	Modified_day_of_month_space_padded: CHARACTER_8 = 'e'
			-- Replaced by the day of the month, using the locale's alternative numeric symbols,
			-- filled as needed with leading spaces.

	Modified_era: CHARACTER_8 = 'y'
			-- Replaced by the year (offset from &C ) using the locale's alternative numeric symbols.

	Modified_minutes: CHARACTER_8 = 'M'
			-- Replaced by the minutes using the locale's alternative numeric symbols.

	Modified_month: CHARACTER_8 = 'm'
			-- Replaced by the month using the locale's alternative numeric symbols.

	Modified_seconds: CHARACTER_8 = 'S'
			-- Replaced by the seconds using the locale's alternative numeric symbols.

	Modified_time_12h: CHARACTER_8 = 'I'
			-- Replaced by the hour (12-hour clock) using the locale's alternative numeric symbols.

	Modified_time_24h: CHARACTER_8 = 'H'
			-- Replaced by the hour (24-hour clock) using the locale's alternative numeric symbols.

	Modified_week_number: CHARACTER_8 = 'U'
			-- Replaced by the week number of the year
			-- (Sunday as the first day of the week, rules corresponding to &U )
			-- using the locale's alternative numeric symbols.

	Modified_week_number_monday_as_first_1: CHARACTER_8 = 'V'
			-- Replaced by the week number of the year (Monday as the first day of the week,
			-- rules corresponding to &V ) using the locale's alternative numeric symbols.

	Modified_week_number_monday_as_first_2: CHARACTER_8 = 'W'
			-- Replaced by the week number of the year (Monday as the first day of the week)
			-- using the locale's alternative numeric symbols.

	Modified_week_number_sunday_as_first: CHARACTER_8 = 'w'
			-- Replaced by the number of the weekday (Sunday=0) using the locale's alternative numeric symbols.

	Modified_weekday: CHARACTER_8 = 'u'
			-- Replaced by the weekday as a number in the locale's alternative representation (Monday=1).

	Modifier_character_2: CHARACTER_8 = 'O';

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
