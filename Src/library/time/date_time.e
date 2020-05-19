note
	description: "Absolute temporal values composed of a date and a time"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	access: date, time
	EIS: "name=Obtaining a DATE from a DATE_TIME and vice versa", "src=$(ISE_DOC_UUID)/195849fc-1a9c-d734-2d2b-acae78133886#Obtaining_a_DATE_from_a_DATE_TIME_and_vice_versa", "tag=EiffelTime"
	EIS: "name=DATE / TIME to STRING Conversion", "src=$(ISE_DOC_UUID)/88972ba4-694b-8558-b0c8-87b1fc40afc4", "tag=EiffelTime"

class DATE_TIME inherit

	ABSOLUTE
		undefine
			out
		redefine
			is_less, copy, is_equal
		end

	DATE_TIME_VALUE
		undefine
			is_equal, fractional_second
		redefine
			date,
			time,
			copy,
			out
		end

	DATE_TIME_VALIDITY_CHECKER
		rename
			set_date as set_compact_date
		undefine
			copy, is_equal, out, year, month, day, hour, minute, second,
			fine_second
		end

	DEBUG_OUTPUT
		export
			{NONE} all
		undefine
			is_equal, copy, out
		end

create
	make,
	make_fine,
	make_by_date_time,
	make_by_date,
	make_now,
	make_now_utc,
	make_from_epoch,
	make_from_string,
	make_from_string_with_base,
	make_from_string_default,
	make_from_string_default_with_base


feature -- Initialization

	make (y, mo, d, h, mi, s: INTEGER)
			-- Set `year', `month' `day' to `y', `mo', `d'.
			-- Set `hour', `minute', `second' to `h', `mi', `s'.
		require
			correct_date_time: is_correct_date_time (y, mo, d, h, mi, s, False)
		do
			create date.make (y, mo, d)
			create time.make (h, mi, s)
		ensure
			year_set: year = y
			month_set: month = mo
			day_set: day = d
			hour_set: hour = h
			minute_set: minute = mi
			second_set: second = s
		end

	make_fine (y, mo, d, h, mi: INTEGER; s: DOUBLE)
			-- Set `year', `month' `day' to `y', `mo', `d'.
			-- Set `hour', `minute', `second' to `h', `m', `s'.
		require
			correct_date_time: is_correct_date_time (y, mo, d, h, mi, s, False)
		do
			create date.make (y, mo, d)
			create time.make_fine (h, mi, s)
		ensure
			year_set: year = y
			month_set: month = mo
			day_set: day = d
			hour_set: hour = h
			minute_set: minute = mi
			second_set: fine_second = s
		end

	make_by_date_time (d: DATE; t: TIME)
			-- Set `date' to `d' and `time' to `t'
		require
			d_exists: d /= Void;
			t_exists: t /= Void
		do
			date := d;
			time := t
		ensure
			date_set: date = d;
			time_set: time = t
		end;

	make_by_date (d: DATE)
			-- Set `date' to `d' and `time' to origin of time.
		require
			d_exists: d /= Void;
		do
			date := d
			create time.make (0, 0, 0);
		ensure
			date_set: date = d;
			time_set: time.is_equal (time.origin)
		end;

	make_now
			-- Get the date and the time from the system.
		local
			l_date: C_DATE
		do
			create l_date
			create date.make (l_date.year_now, l_date.month_now, l_date.day_now)
			create time.make_fine (l_date.hour_now, l_date.minute_now,
				l_date.second_now + l_date.millisecond_now / 1000)
		end

	make_now_utc
			-- Get the date and the time from the system.
		local
			l_date: C_DATE
		do
			create l_date.make_utc
			create date.make (l_date.year_now, l_date.month_now, l_date.day_now)
			create time.make_fine (l_date.hour_now, l_date.minute_now,
				l_date.second_now + l_date.millisecond_now / 1000)
		end

	make_from_string_default (s: READABLE_STRING)
			-- Initialize from a "standard" string of form
			-- `default_format_string'.
			-- (For 2-digit year specifications, the current century is used as
			-- base century.)
		require
			s_exists: s /= Void
			date_time_valid: date_time_valid (s, default_format_string)
		do
			make_from_string (s, default_format_string)
		end

	make_from_string_default_with_base (s: READABLE_STRING; base: INTEGER)
			-- Initialize from a "standard" string of form
			-- `default_format_string' with base century `base'.
		require
			s_exists: s /= Void
			base_valid: base > 0 and (base \\ 100 = 0)
			date_time_valid:
					date_time_valid_with_base (s, default_format_string, base)
		do
			make_from_string_with_base (s, default_format_string, base)
		end

	make_from_string (s: READABLE_STRING; code: READABLE_STRING)
			-- Initialize from a "standard" string of form
			-- `code'.
			-- (For 2-digit year specifications, the current century is used as
			-- base century.)
		require
			s_exists: s /= Void
			c_exists: code /= Void
			date_time_valid: date_time_valid (s, code)
		local
			date_time: DATE_TIME
		do
			date_time := (create {DATE_TIME_CODE_STRING}.make (code)).create_date_time (s)
			make_by_date_time (date_time.date, date_time.time)
		end

	make_from_string_with_base (s: READABLE_STRING; code: READABLE_STRING; base: INTEGER)
			-- Initialize from a "standard" string of form
			-- `code' with base century `base'.
		require
			s_exists: s /= Void
			c_exists: code /= Void
			base_valid: base > 0 and (base \\ 100 = 0)
			date_time_valid: date_time_valid_with_base (s, code, base)
		local
			code_string: DATE_TIME_CODE_STRING
			date_time: DATE_TIME
		do
			create code_string.make (code)
			code_string.set_base_century (base)
			date_time := code_string.create_date_time (s)
			make_by_date_time (date_time.date, date_time.time)
		end

	make_from_epoch (s: INTEGER)
			-- Create a new date time from the number of
			-- seconds since epoch (1 Jan 1970 at 00:00:00).
		local
			d: INTEGER
			ss: INTEGER
			l_dur: DATE_TIME_DURATION
		do
			if s < 0 then
				ss := -s
			else
				ss := s
			end
			d := ss // Seconds_in_day
			ss := ss \\ Seconds_in_day
			create l_dur.make_definite (d, 0, 0, ss)
			make_fine (1970, 1, 1, 0, 0, 0.0)
			if s < 0 then
				add (-l_dur)
			else
				add (l_dur)
			end
		end

feature -- Access

	date: DATE
			-- Date of the current object

	time: TIME
			-- Time of the current object

	origin: DATE_TIME
			-- Origin date with origin time
		once
			create Result.make_by_date_time (date.origin, time.origin)
		end

	date_duration: DATE_DURATION
			-- Definite duration between origin of date and current date
		do
			Result := date.duration
		end

	days: INTEGER
			-- Number of days elapsed since `origin'
		do
			Result := date.days
		end

	time_duration: TIME_DURATION
			-- Duration elapsed from midnight of the current date
		do
			Result := time.duration
		end

	seconds: INTEGER
			-- Number of seconds elapsed from midnight of the current date
		do
			Result := time.seconds
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is the current object before `other'?
		do
			Result := date < other.date or else
				(date.is_equal (other.date) and then
				(time < other.time))
		end

	is_equal (other: like Current): BOOLEAN
			-- Is the current object equal to `other'?
		do
			Result := equal (date, other.date) and then equal (time, other.time)
		end

feature -- Measurement

	duration: DATE_TIME_DURATION
			-- Definite duration elapsed from `origin'
		do
			create Result.make_by_date_time (date_duration, time_duration)
		ensure then
			definite_result: Result.definite
		end

feature -- Element Change

	set_date (d: DATE)
			-- Set `date' to `d'.
		require
			d_exists: d /= Void
		do
			date := d
		ensure
			date_set: date = d
		end

	set_time (t: TIME)
			-- Set `time' to `t'.
		require
			t_exists: t /= Void
		do
			time := t
		ensure
			time_set: time = t
		end

	copy (other: like Current)
			-- set `date' and `time' with the `other' attributes.
		do
			if other /= Current then
				Precursor {ABSOLUTE} (other)
				date := other.date.twin
				time := other.time.twin
			end
		end

feature -- Basic operations

	plus alias "+" (d: DATE_TIME_DURATION): like Current
			-- Sum the current object with `d'
		require
			d_not_void: d /= Void
		do
			Result := twin
			Result.add (d)
		ensure
			result_exists: Result /= Void
		end

	add (dtd: DATE_TIME_DURATION)
			-- Adds `dtd' to current duration
		require
			dtd_not_void: dtd /= Void
		do
			if dtd.definite then
				day_add (dtd.day)
			else
				date.year_month_add (dtd.year, dtd.month)
				day_add (dtd.day)
			end
			day_add ((dtd.time + time_duration).to_days)
			time := time.origin + (dtd.time + time_duration).time_modulo_day
		end

	relative_duration (other: like Current): DATE_TIME_DURATION
			-- Duration from `other' to current date
		do
			create Result.make_fine (0, 0, days - other.days,
				hour - other.hour, minute - other.minute,
				fine_second - other.fine_second)
			Result := Result.to_canonical (other)
			Result.set_origin_date_time (other.twin)
		ensure then
			origin_set: equal (other, Result.origin_date_time)
		end

	definite_duration (other: like Current): DATE_TIME_DURATION
			-- Duration from `other' to the current date, converted to a
			-- definite duration
		require
			other_exists: other /= Void
		do
			Result := relative_duration (other)
			Result.date.to_definite (other.date)
		ensure
			definite_result: Result.definite
		end;

	day_add (d: INTEGER)
			-- Add `d' days to the current date.
		do
			date.make_by_days (days + d)
		ensure
			days_set: days = old days + d
		end

	hour_add (h: INTEGER)
			-- Add `h' hours to the current time.
		local
			total_hour: INTEGER
		do
			total_hour := hour + h
			if total_hour < 0 or else total_hour >= Hours_in_day then
				time.set_hour (mod (total_hour, Hours_in_day))
				day_add (div (total_hour, Hours_in_day))
			else
				time.set_hour (total_hour)
			end
		end

	minute_add (m: INTEGER)
			-- Add `m' minutes to the current time.
		local
			total_minute: INTEGER
		do
			total_minute := minute + m
			if total_minute < 0 or else total_minute >= Minutes_in_hour then
				time.set_minute (mod (total_minute, Minutes_in_hour))
				hour_add (div (total_minute, Minutes_in_hour))
			else
				time.set_minute (total_minute)
			end
		end

	second_add (s: INTEGER)
			-- Add `s' seconds to the current time.
		local
			total_second: INTEGER
		do
			total_second := second + s
			if total_second < 0 or else total_second >= Seconds_in_minute then
				time.set_second (mod (total_second, Seconds_in_minute))
				minute_add (div (total_second, Seconds_in_minute))
			else
				time.set_second (total_second)
			end
		end

	fine_second_add (s: DOUBLE)
			-- Add `s' seconds to the current object.
			-- if `s' has decimals, `fractional_second' from `time' is modified.
		local
			total_second: DOUBLE
		do
			total_second := time.fine_second + s
			if total_second < 0 or else total_second >= Seconds_in_minute then
				time.set_fine_second (total_second - div (total_second.floor,
					Seconds_in_minute) * Seconds_in_minute)
				minute_add (div (total_second.floor, Seconds_in_minute))
			else
				time.set_fine_second (total_second)
			end
		end

feature -- Output

	debug_output, out: STRING
			-- Printable representation of the current object
			-- With "standard" form: `default_format_string'
		do
			Result := formatted_out (default_format_string)
		end

	formatted_out (s: READABLE_STRING): STRING
			-- Printable representation of the current object
			-- With "standard" form: `s'
		require
			s_exists: s /= Void
		do
			Result := (create {DATE_TIME_CODE_STRING}.make (s)).create_string (Current)
		end

note
	ca_ignore: "CA011", "CA011: too many arguments"
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
