indexing
	description: "Durations of date"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	access: date

class DATE_DURATION inherit

	DURATION
		undefine
			is_equal
		end

	DATE_CONSTANTS
		undefine
			is_equal	
		end

	DATE_MEASUREMENT
		undefine
			is_equal
		end

create
 
	make, make_by_days

feature -- Initialization

	make (y, m, d: INTEGER) is
			-- Set `year', `month' and `day' to `y', `m' and `d' respectively.
		do
			year := y
			month := m
			day := d
		ensure
			year_set: year = y
			month_set: month = m
			day_set: day = d
		end

	make_by_days (d: INTEGER) is
			-- Set `day' to `d'.
			-- The duration is definite
		do
			year := 0
			month := 0
			day := d
		ensure
			day_set: day = d
			definite_duration: definite
		end

feature -- Access

	Zero: DATE_DURATION is 
			-- Neutral element for "+" and "-"
		once
				create Result.make_by_days (0)
		ensure then
			definite: Result.definite
		end

feature -- Attribute

	day: INTEGER

	month: INTEGER

	year: INTEGER

	origin_date: DATE
			-- Origin date of duration
	
	days_count: INTEGER is
			-- Number of days in duration
		require
			origin_date_set: has_origin_date
		local
			tmp: DATE
			tmp_dur: like Current
			i: INTEGER
		do
			tmp := clone (origin_date)
			tmp_dur := clone (Current)
			tmp_dur := tmp_dur.to_canonical (origin_date)
			if is_positive then
				from
					i := 1
				until
					i > tmp_dur.year
				loop
					if is_leap_year (tmp.year) then
						Result := Result + Days_in_leap_year
					else
						Result := Result + Days_in_non_leap_year
					end
					tmp.year_forth
					i := i + 1
				end
				from
					i := 1
				until
					i > tmp_dur.month
				loop
					Result := Result + days_in_i_th_month (tmp.month, tmp.year)
					tmp.month_forth
					i := i + 1
				end
				Result := Result + tmp_dur.day
			elseif is_negative then
				from
					i := -1
				until
					i < tmp_dur.year
				loop
					tmp.year_back
					if is_leap_year (tmp.year) then
						Result := Result - Days_in_leap_year
					else
						Result := Result - Days_in_non_leap_year
					end
					i := i - 1
				end
				from
					i := -1
				until
					i < tmp_dur.month
				loop
					tmp.month_back
					Result := Result - days_in_i_th_month (tmp.month, tmp.year)
					i := i - 1
				end
				Result := Result + tmp_dur.day
			end
		end
	
feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is the current object smaller than `other'?
			-- It is impossible to compare not definite duration.
		do
			if definite and then other.definite then
				Result := (day < other.day)
			else
				Result := False
			end
		ensure then
			definite_duration: (definite and then other.definite) implies 
				Result = (day < other.day)
			non_definite_duration: 
				(not definite or else not other.definite) implies Result = False
		end
	
	is_equal (other: like Current): BOOLEAN is
			-- Are the current object and `other' equal?
		do
			Result := year = other.year and then month = other.month and then
				day = other.day
		ensure then
			result_definition: Result = (year = other.year and then 
					month = other.month and then day = other.day)
		end

feature -- Status report

	definite: BOOLEAN is
			-- Is the duration is independant of the date
			-- on which it applies? (use of `day' only)?
			-- or not (use of `year', `month' and `day')?
		do
			Result := (year = 0) and then (month = 0)
		ensure
			result_definition: Result = ((year = 0) and then (month = 0))
		end

	canonical (date: DATE): BOOLEAN is
			-- Is duration expressed minimally for adding to `date', i.e.
			-- 	If addition will yield a date after `date', then:
			--		`year' positive,
			--		`month' between 0 and `Months_in_year - 1',
			--		`day' between 0 and (number of days of the month before 
			--		the yielded) - 1?
			-- 	If addition will yield a date before `date', then:
			--		`year' negative, 
			--		`month' between `1 - Months_in_year' and 0, 
			--		`day' between (number of days of the month before the 
			--		yielded) and 0?
		require
			date_exist: date /= Void
		local
			final_date, limit_date: DATE
			d: DATE_DURATION
		do
			final_date := date + Current
			if final_date >= date then
					create d.make (year, month + 1, 0)
					limit_date := date + d; 
					Result := (year >= 0) and then (month >= 0) and then
						(month < Months_in_year) and then
						(day >= 0) and then (final_date < limit_date)
			else
					create d.make (year, month - 1, 0)
					limit_date := date + d; 
					Result := (year <= 0) and then (month <= 0)
						and then (month > - Months_in_year)
						and then (day <= 0) and then (final_date > limit_date)
			end
		end

	is_positive: BOOLEAN is
			-- Is duration positive?
		do
			Result := (day > 0 or month > 0 or year > 0)
		end

	has_origin_date: BOOLEAN is
			-- Has `origin date' been set?
		do
			Result := (origin_date /= Void)
		end

feature -- Status setting

	set_origin_date (d: DATE) is
			-- Set `origin_date' to `d'.
		do
			origin_date := d
		ensure
			origin_date_set: origin_date = d
		end
		
feature -- Element Change

	set_day (d: INTEGER) is
			-- Set `day' to `d'.
		do
			day := d
		end

	set_month (m: INTEGER) is
			-- Set `month' to `m'.
		do
			month := m
		end

	set_year (y: INTEGER) is
			-- Set `year' to `y'.
		do
			year := y
		end

	day_add (d: INTEGER) is
			-- Add `d' days to `Current'.
		do
			day := day + d
		ensure
			day_set: day = old day + d
		end

	month_add (m: INTEGER) is
			-- Add `m' months to `Current'.
		do
			month := month + m
		ensure
			month_set: month = old month + m
		end

	year_add (y: INTEGER) is
			-- Add `y' years to `Current'.
		do
			year := year + y
		ensure
			year_set: year = old year + y
		end

feature -- Basic operations

	infix "+" (other: like Current): like Current is
			-- Sum of current object with `other'
		do
			create Result.make (year + other.year, month + other.month, 
				day + other.day)
			Result.set_origin_date (clone (origin_date))
		ensure then
			origin_equal: equal (origin_date, Result.origin_date)
		end
	
	prefix "-": like Current is
			-- Unary minus
		do
			create Result.make (-year, -month, -day)
			Result.set_origin_date (clone (origin_date))
		ensure then
			origin_equal: equal (origin_date, Result.origin_date)
		end

feature -- Conversion

	to_canonical (start_date: DATE): like Current is 
			-- A new duration, equivalent to current one 
			-- and canonical for `date' 
		local 
			date_tmp, final_date: DATE
			d1: INTEGER 
		do 
			if canonical (start_date) then 
				Result := deep_clone (Current) 
			else 
				final_date := start_date + Current; 
				d1 := (final_date.year - start_date.year) * Months_in_year + 
					final_date.month - start_date.month
				date_tmp := clone (start_date)
				date_tmp.month_add (d1)
				if final_date >= start_date then
					if date_tmp <= final_date then
						create Result.make (d1 // Months_in_year, 
							d1 \\ Months_in_year, final_date.day - date_tmp.day)
					else
						d1 := d1 - 1
						date_tmp.month_back
						if start_date.days_in_i_th_month (date_tmp.month, 
							date_tmp.year) < start_date.day then 
							create Result.make (d1 // Months_in_year, 
								d1 \\ Months_in_year, final_date.day)
						else 
							create Result.make (d1 // Months_in_year, 
								d1 \\ Months_in_year,
								final_date.day + 
								start_date.days_in_i_th_month (date_tmp.month, 
								date_tmp.year) - start_date.day) 
						end
					end
				else 
					if date_tmp >= final_date then 
						create Result.make (d1 // Months_in_year, 
							d1 \\ Months_in_year, final_date.day - date_tmp.day)
					else
						d1 := d1 + 1
						date_tmp.month_forth
						create Result.make (d1 // Months_in_year, 
							d1 \\ Months_in_year,
							final_date.day - start_date.days_in_i_th_month 
							(final_date.month, final_date.year) - date_tmp.day) 
					end 
				end 
			end 
		ensure 
			canonical_result: Result.canonical (start_date) 
			duration_not_changed: equal (start_date + Current,
					start_date + Result) 
		end; 
 
	to_definite (date: DATE) is
			-- Make current duration definite.
		require
			date_exists: date /= Void
		local
			final_date: DATE
		do
			final_date := date + Current
			make_by_days (final_date.days - date.days)	
		ensure
			definite_result: definite
		end

	to_date_time: DATE_TIME_DURATION is
			-- Date-time version, with a zero time component
		do
			create Result.make (year, month, day, 0, 0, 0)
		ensure
			result_exists: Result /= Void
			year_set: Result.year = year
			month_set: Result.month = month
			day_set: Result.day = day
		end

invariant

	equal_signs: (has_origin_date and then canonical (origin_date)) implies 
			(day >= 0 and month >= 0 and year >= 0) or
			(day <= 0 and month <= 0 and year <= 0)

end -- class DATE_DURATION


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

