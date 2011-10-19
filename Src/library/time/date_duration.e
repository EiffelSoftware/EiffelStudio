﻿note
	description: "Durations of date"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	make (y, m, d: INTEGER)
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

	make_by_days (d: INTEGER)
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

	zero: like Current
			-- Neutral element for "+" and "-"
		do
			create Result.make_by_days (0)
		ensure then
			definite: Result.definite
		end

feature -- Attribute

	day: INTEGER

	month: INTEGER

	year: INTEGER

	origin_date: detachable DATE
			-- Origin date of duration

	days_count: INTEGER
			-- Number of days in duration
		require
			origin_date_set: has_origin_date
		do
			check origin_date_not_void: attached origin_date as l_origin_date then
				Result := (l_origin_date + to_canonical (l_origin_date)).days - l_origin_date.days
			end
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
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

	is_equal (other: like Current): BOOLEAN
			-- Are the current object and `other' equal?
		do
			Result := year = other.year and then month = other.month and then
				day = other.day
		ensure then
			result_definition: Result = (year = other.year and then
					month = other.month and then day = other.day)
		end

feature -- Status report

	definite: BOOLEAN
			-- Is the duration is independant of the date
			-- on which it applies? (use of `day' only)?
			-- or not (use of `year', `month' and `day')?
		do
			Result := (year = 0) and then (month = 0)
		ensure
			result_definition: Result = ((year = 0) and then (month = 0))
		end

	canonical (date: DATE): BOOLEAN
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
						and then (month > -Months_in_year)
						and then (day <= 0) and then (final_date > limit_date)
			end
		end

	is_positive: BOOLEAN
			-- Is duration positive?
		do
			Result := (day > 0 or month > 0 or year > 0)
		end

	has_origin_date: BOOLEAN
			-- Has `origin date' been set?
		do
			Result := (origin_date /= Void)
		end

feature -- Status setting

	set_origin_date (d: detachable DATE)
			-- Set `origin_date' to `d'.
		do
			origin_date := d
		ensure
			origin_date_set: origin_date = d
		end

feature -- Element Change

	set_day (d: INTEGER)
			-- Set `day' to `d'.
		do
			day := d
		end

	set_month (m: INTEGER)
			-- Set `month' to `m'.
		do
			month := m
		end

	set_year (y: INTEGER)
			-- Set `year' to `y'.
		do
			year := y
		end

	set_date (y, m, d: INTEGER)
			-- Set `year' with `y', `month' with `m' and `day' with `d'.
		do
			day := d
			month := m
			year := y
		end

	day_add (d: INTEGER)
			-- Add `d' days to `Current'.
		do
			day := day + d
		ensure
			day_set: day = old day + d
		end

	month_add (m: INTEGER)
			-- Add `m' months to `Current'.
		do
			month := month + m
		ensure
			month_set: month = old month + m
		end

	year_add (y: INTEGER)
			-- Add `y' years to `Current'.
		do
			year := year + y
		ensure
			year_set: year = old year + y
		end

feature -- Basic operations

	plus alias "+" (other: like Current): like Current
			-- Sum of current object with `other'
		local
			l_origin: like origin_date
		do
			create Result.make (year + other.year, month + other.month,
				day + other.day)
			l_origin := origin_date
			if l_origin /= Void then
				Result.set_origin_date (l_origin.twin)
			else
				Result.set_origin_date (Void)
			end
		ensure then
			origin_equal: equal (origin_date, Result.origin_date)
		end

	opposite alias "-": like Current
			-- Unary minus
		local
			l_origin: like origin_date
		do
			create Result.make (-year, -month, -day)
			l_origin := origin_date
			if l_origin /= Void then
				Result.set_origin_date (l_origin.twin)
			else
				Result.set_origin_date (Void)
			end
		ensure then
			origin_equal: equal (origin_date, Result.origin_date)
		end

feature -- Conversion

	to_canonical (start_date: DATE): like Current
			-- A new duration, equivalent to current one
			-- and canonical for `date'
		require
			start_date_not_void: start_date /= Void
		local
			date_tmp, final_date: DATE
			d1: INTEGER
		do
			if canonical (start_date) then
				Result := deep_twin
			else
				final_date := start_date + Current;
				d1 := (final_date.year - start_date.year) * Months_in_year +
					final_date.month - start_date.month
				date_tmp := start_date.twin
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

	to_definite (date: DATE)
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

	to_date_time: DATE_TIME_DURATION
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

	equal_signs: (has_origin_date and then
				attached origin_date as l_origin_date and then
				canonical (l_origin_date)) implies
			(day >= 0 and month >= 0 and year >= 0) or
			(day <= 0 and month <= 0 and year <= 0)

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class DATE_DURATION
