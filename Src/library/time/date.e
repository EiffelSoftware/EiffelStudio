indexing
	description: "Absolute dates"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	access: date

class DATE inherit

	ABSOLUTE
		undefine
			out
		redefine
			infix "<"
		end

	DATE_VALUE
		undefine
			is_equal
		redefine
			out
		end

	DATE_VALIDITY_CHECKER
		undefine
			is_equal, out
		end

create
 
	make,
	make_month_day_year,
	make_day_month_year,
	make_now,
	make_now_utc,
	make_by_days,
	make_from_string_default,
	make_from_string_default_with_base,
	make_from_string,
	make_from_string_with_base,
	make_by_compact_date,
	make_by_ordered_compact_date

feature -- Initialization

	make (y, m, d: INTEGER) is
			-- Set `year', `month' and `day' to `y', `m', `d' respectively.
		require
			correct_date: is_correct_date (y, m, d)
		do
			set_date (y, m, d)
		ensure
			year_set: year = y
			month_set: month = m
			day_set: day = d
		end

	make_month_day_year (m, d, y: INTEGER) is
			-- Set `month', `day' and `year' to `m', `d' and `y' respectively.
		require
			correct_date: is_correct_date (y, m, d)
		do
			make (y, m, d)
		ensure
			year_set: year = y
			month_set: month = m
			day_set: day = d
		end

	make_day_month_year (d, m, y: INTEGER) is
			-- Set `day', `month' and `year' to `d', `m' and `y' respectively.
		require
			correct_date: is_correct_date (y, m, d)
		do
			make (y, m, d)
		ensure
			year_set: year = y
			month_set: month = m
			day_set: day = d
		end

	make_now is
			-- Set the current object to today's date.
		local
			l_date: C_DATE
		do
			create l_date
			make (l_date.year_now, l_date.month_now, l_date.day_now)
		end

	make_now_utc is
			-- Set the current object to today's date in utc format.
		local
			l_date: C_DATE
		do
			create l_date.make_utc
			make (l_date.year_now, l_date.month_now, l_date.day_now)
		end

	make_by_days (n: INTEGER) is
			-- Set the current date with the number of days `n' since `origin'.
		local
			i, j: INTEGER
			y, m, d: INTEGER
		do
			i := 4 * (n - 59) - 1
			j := (4 * div ((mod (i, 146097)), 4)) + 3
			y := (100 * (div (i, 146097))) + (div (j, 1461))
			i := (5 * (div (((mod (j, 1461)) + 4), 4))) - 3
			m := div (i, 153)
			d := div (((mod (i, 153)) + 5), 5)
			if m < 10 then
				m := m + 3
			else
				m := m - 9
				y := y + 1
			end
			y := y + 1600
			make (y, m, d)
		ensure
			days_set: days = n
		end

	make_from_string_default (s: STRING) is
			-- Initialize from a "standard" string of form
			-- `date_default_format_string'.
			-- (For 2-digit year specifications, the current century is used as
			-- base century.)
		require
			s_exists: s /= Void
			date_valid: date_valid (s, Date_default_format_string)
		do
			make_from_string (s, Date_default_format_string)
		end

	make_from_string_default_with_base (s: STRING; base: INTEGER) is
			-- Initialize from a "standard" string of form
			-- `date_default_format_string' with base century `base'.
		require
			s_exists: s /= Void
			base_valid: base > 0 and (base \\ 100 = 0)
			date_valid: 
				date_valid_with_base (s, Date_default_format_string, base)
		do
			make_from_string_with_base (s, Date_default_format_string, base)
		end

	make_from_string (s: STRING; code: STRING) is
			-- Initialize from a "standard" string of form
			-- `code'.
			-- (For 2-digit year specifications, the current century is used as
			-- base century.)
		require
			s_exists: s /= Void
			c_exists: code /= Void
			date_valid: date_valid (s, code)
		local
			code_string: DATE_TIME_CODE_STRING
			date: DATE
		do
			create code_string.make (code)
			date := code_string.create_date (s)
			make (date.year, date.month, date.day)
		end

	make_from_string_with_base (s: STRING; code: STRING; base: INTEGER) is
			-- Initialize from a "standard" string of form
			-- `code' with base century `base'.
		require
			s_exists: s /= Void
			c_exists: code /= Void
			base_valid: base > 0 and (base \\ 100 = 0)
			date_valid: date_valid_with_base (s, code, base)
		local
			code_string: DATE_TIME_CODE_STRING
			date: DATE
		do
			create code_string.make (code)
			code_string.set_base_century (base)
			date := code_string.create_date (s)
			make (date.year, date.month, date.day)
		end

	make_by_compact_date (c_d: INTEGER) is
			-- Initialize from a `compact_date'.
		obsolete
			"Use `make_by_ordered_compact_date' instead. But be careful in your update %
			%since `compact_date' and `ordered_compact_date' do not have the same %
			%encoding."
		require
			c_d_valid: compact_date_valid (c_d)
		do
			set_internal_compact_date (c_d)
		ensure
			compact_date_set: compact_date = c_d
		end

	make_by_ordered_compact_date (c_d: INTEGER) is
			-- Initialize from a `ordered_compact_date'.
		require
			c_d_valid: ordered_compact_date_valid (c_d)
		do
			set_internal_ordered_compact_date (c_d)
		ensure
			ordered_compact_date_set: ordered_compact_date = c_d
		end

feature -- Access

	origin: DATE is
			-- Origin date
		once
			create Result.make (1600, 1, 1)
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is the current date before `other'?
		local
			l_current, l_other: INTEGER
		do
			l_current := ordered_compact_date
			l_other := other.ordered_compact_date
			if l_current >= 0 and l_other >= 0 then
					-- There was no sign issue so we can safely compate the integer values
				Result := l_current < l_other
			else
				Result := year < other.year and (l_current & 0x0000FFFF) < (l_other & 0x0000FFFF)
			end
		end

feature -- Measurement

	duration: DATE_DURATION is
			-- Definite duration elapsed since `origin'
		do
			create Result.make_by_days (days_from (origin.year) + year_day - 
				origin.year_day)
		ensure then
			definite_result: Result.definite
			duration_set: ((Current - origin).duration).is_equal (Result)
		end

	days: INTEGER is
			-- Number of days elapsed since `origin'
		do
			Result := days_from (origin.year) + year_day - origin.year_day
		ensure
			same_duration: Result = duration.day
		end

feature -- Status report

	leap_year: BOOLEAN is
			-- Is the current year a leap year?
		do
			Result := is_leap_year (year)
		end

	days_at_month: INTEGER is
			-- Number of days from the beginning of the year
			-- until the beginning of the current month
		do
			Result := days_at_months @ month
			if leap_year and then month > 2 then
				Result := Result + 1
			end
		ensure
			positive_result: Result >= 0
		end
		
	year_day: INTEGER is
			-- Number of days from the beginning of the year
		do
			Result := days_at_month + day 
		ensure
			result_large_enough: Result >= 1
			result_small_enough: Result <= days_in_year
		end

	week_of_year: INTEGER is
			-- Number of weeks from the beginning of the year
			-- The first week of the year begins on the first sunday of the year
			-- The week number before the first sunday of the year is 0
		do
			if day_of_the_week <= year_day then
				if day_of_january_1st > 0 then
					Result := div (year_day - day_of_the_week, days_in_week) + 1
				else
					Result := div (year_day - day_of_the_week + 
						day_of_january_1st - 1, days_in_week)
				end
			else
				Result := 0
			end
		ensure
			positive_result: Result >= 0
			Result_small_enough: Result < Max_weeks_in_year	
		end

	days_in_year: INTEGER is
			-- Number of days in the current year
		do
			if leap_year then
				Result := days_in_leap_year
			else
				Result := days_in_non_leap_year
			end
		ensure
			valid_result: 
				(leap_year implies Result = days_in_leap_year) and then
					(not leap_year implies Result = days_in_non_leap_year)
		end

	day_of_the_week: INTEGER is
			-- Number of day from the beginning of the week
			-- sunday is 1, etc.., saturday is 7
		do
			Result := mod (days - 1, 7) + 1
		ensure
			day_of_the_week_range: Result > 0 and then Result < 8
		end

	day_of_january_1st: INTEGER is
			-- Day of the week of january 1st of the current year
		local
			january_1st: DATE
		do
			create january_1st.make (year, 1, 1)
			Result := january_1st.day_of_the_week 
		ensure
			day_of_the_week_definition: Result > 0 and then Result < 8
		end

	days_from (y: INTEGER): INTEGER is
			-- Days between the current year and year `y'
		do
			Result := (year - y) * days_in_non_leap_year +
				(div (year - 1, 4) - div (y - 1, 4)) -
				(div (year - 1, 100) - div (y - 1, 100)) +
				(div (year - 1, 400) - div (y - 1, 400))
		end

feature -- Conversion

	to_date_time: DATE_TIME is
			-- Date-time version, with a zero time component
		do
			create Result.make_by_date (Current)
		end

feature -- Basic operations

	infix "+" (d: DATE_DURATION): DATE is
			-- Sum to current date the duration `d'
			-- if duration not define, add years and then months and then days.
		do
			Result := twin
			Result.add (d)
		ensure
			result_exists: Result /= Void
			definite_set: d.definite implies 
					(Result - Current).duration.is_equal (d)
		end

	add (d: DATE_DURATION) is
			-- Adds `d' to the current date.
			-- if `d' is not definite, add years and months and then days.
		do
			if d.definite then
				day_add (d.day)
			else
				year_month_add (d.year, d.month)
				day_add (d.day)
			end
		end

	relative_duration (other: like Current): DATE_DURATION is
			-- Duration from `other' to the current date
		do
			create Result.make_by_days (days - other.days)
			Result := Result.to_canonical (other)
			Result.set_origin_date (other.twin)
		ensure then
			exact_duration: (other + Result).is_equal (Current)
			canonical_duration: Result.canonical (other)
			origin_date_set: equal (Result.origin_date, other)
		end

	day_forth is
			-- Move to next day.
			-- days is from the origin, day is current.
		do
			if day = days_in_month then
				set_day (1)
				month_forth
			else
				set_day (day + 1)
			end
		ensure
			days_set: days = old days + 1
		end

	day_back is
			-- Move to previous day.
		do
			if day = 1 then
				month_back
				set_day (days_in_month)
			else
				set_day (day - 1)
			end
		ensure
			days_set: days = old days - 1
		end

	day_add (d: INTEGER) is
			-- Add `d' days to the current date.
		do
			make_by_days (days + d)
		ensure
			days_set: days = old days + d
		end

	month_forth is
			-- Move to next month.
			-- Can move days backward if next month has less days than the 
			-- current month.
		local
			days_in_new_month: INTEGER
		do
			if month = Months_in_year then
				set_month (1)
				year_forth
			else
				days_in_new_month := days_in_i_th_month (month + 1, year)
				if day > days_in_new_month then
					set_day (days_in_new_month)
				end
				set_month (month + 1)
			end
		end

	month_back is
			-- Move to previous month.
			-- Can move days backward if previous month has less days than the 
			-- current month.
		local
			days_in_new_month: INTEGER
		do
			if month = 1 then
				set_month (Months_in_year)
				year_back
			else
				days_in_new_month := days_in_i_th_month (month - 1, year)
				if day > days_in_new_month then
					set_day (days_in_new_month)
				end
				set_month (month - 1)
			end
		end

	month_add (m: INTEGER) is
			-- Add `m' months to the current date.
			-- Can move days backward.
		local
			new_month: INTEGER
			days_in_new_month: INTEGER
		do
			new_month := mod ((month + m - 1), Months_in_year) + 1
			set_year (year + div ((month + m - 1), Months_in_year))
			days_in_new_month := days_in_i_th_month (new_month, year)
			if day > days_in_new_month then
				set_day (days_in_new_month)
			end
			set_month (new_month)
		end

	year_forth is
			-- Move to next year.
			-- May cut the 29th february.
		do
			if day > days_in_i_th_month (month, year + 1) then
				set_day (days_in_i_th_month (month, year + 1))
			end;	
			set_year (year + 1)
		
		ensure
			year_increased: year = old year + 1
		end

	year_back is
			-- Move to previous year.
			-- May cut the 29th february.
		do
			if day > days_in_i_th_month (month, year - 1) then
				set_day (days_in_i_th_month (month, year - 1))
			end;	
			set_year (year - 1)
		ensure
			year_decreased: year = old year - 1
		end

	year_add (y: INTEGER) is
			-- Add `y' years to the current date.
			-- May cut the 29th february.
		do
			if day > days_in_i_th_month (month, year + y) then
				set_day (days_in_i_th_month (month, year + y))
			end;	
			set_year (year + y)
		ensure
			year_set: year = old year + y
		end

	year_month_add (y, m: INTEGER) is
			-- Add `y' years and `m' months to the current date.
			-- Check the number of days after.
		do
			month_add (y * Months_in_year + m)
		end

feature -- Output

	out: STRING is
			-- Printable representation of `Current' with "standard"
			-- Form: `date_default_format_string'
		do
			Result := formatted_out (date_default_format_string)
		end

	formatted_out (s: STRING): STRING is
			-- Printable representation of `Current' with "standard"
			-- Form: `s'
		require
			s_exists: s /= Void
		local
			code: DATE_TIME_CODE_STRING
		do
			create code.make (s)
			Result := code.create_date_string (Current)
		end

feature {NONE} -- Implementation

	days_at_months: ARRAY [INTEGER] is
			-- Array containing number of days from the end of
			-- the year to each month of a non-leap year
		once
			Result := <<0, 31, 59, 90, 120, 151, 181, 212, 243,
				273, 304, 334>>
		ensure
			result_exists: Result /= Void
			count_is_months_in_year: Result.count = Months_in_year
		end

invariant

	day_large_enough: day >= 1
	day_small_enough: day <= days_in_month
	month_large_enough: month >= 1
	month_small_enough: month <= Months_in_year
	year_small_enough: year <= 65535
	year_positive: year > 0

end -- class DATE

--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

