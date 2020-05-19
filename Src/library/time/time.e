note
	description: "Absolute times"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	access: time
	EIS: "name=Obtaining a DATE from a DATE_TIME and vice versa", "src=$(ISE_DOC_UUID)/195849fc-1a9c-d734-2d2b-acae78133886#Obtaining_a_DATE_from_a_DATE_TIME_and_vice_versa", "tag=EiffelTime"

class TIME inherit

	ABSOLUTE
		undefine
			out
		redefine
			is_less
		end

	TIME_VALUE
		undefine
			is_equal
		redefine
			out
		end

	TIME_VALIDITY_CHECKER
		undefine
			is_equal, out
		end

	DEBUG_OUTPUT
		export
			{NONE} all
		undefine
			is_equal, out
		end

create

	make,
	make_fine,
	make_now,
	make_now_utc,
	make_by_seconds,
	make_by_fine_seconds,
	make_from_string,
	make_from_string_default,
	make_by_compact_time

feature -- Initialization

	make (h, m, s: INTEGER)
			-- Set `hour, `minute' and `second' to `h', `m', `s' respectively.
		require
			correct_time: is_correct_time (h, m, s, False)
		do
			set_hour (h)
			set_minute (m)
			set_second (s)
			fractional_second := 0
		ensure
			hour_set: hour = h
			minute_set: minute = m
			second_set: second = s
			fractional_second_set: fractional_second = 0
		end

	make_fine (h, m: INTEGER; s: DOUBLE)
			-- Set `hour, `minute' and `second' to `h', `m' and truncated to
			-- integer part of `s' respectively.
			-- Set `fractional_second' to the fractional part of `s'.
		require
			correct_time: is_correct_time (h, m, s, False)
		local
			s_tmp: INTEGER
		do
			s_tmp :=  s.truncated_to_integer
			make (h, m, s_tmp)
			fractional_second := s - s_tmp
		ensure
			hour_set: hour = h
			minute_set: minute = m
			fine_second_set: fine_second = s
		end

	make_now
			-- Set current time according to timezone.
		local
			l_date: C_DATE
		do
			create l_date
			make (l_date.hour_now, l_date.minute_now, l_date.second_now)
			fractional_second := l_date.millisecond_now / 1000
		end

	make_now_utc
			-- Set the current object to today's date in utc format.
		local
			l_date: C_DATE
		do
			create l_date.make_utc
			make (l_date.hour_now, l_date.minute_now, l_date.second_now)
			fractional_second := l_date.millisecond_now / 1000
		end

	make_by_seconds (sec: INTEGER)
			-- Set the object by the number of seconds `sec' from midnight.
		require
			s_large_enough: sec >= 0
			s_small_enough: sec < Seconds_in_day
		local
			h, m, s: INTEGER
		do
			s := sec
			h := s // Seconds_in_hour
			s := s - (h * Seconds_in_hour)
			m := s // Seconds_in_minute
			s := s - (m * Seconds_in_minute)
			make (h, m, s)
		ensure
			seconds_set: seconds = sec
		end

	make_by_fine_seconds (sec: DOUBLE)
			-- Set the object by the number of seconds `sec'.
		require
			s_large_enough: sec >= 0
			s_small_enough: sec < Seconds_in_day
		local
			s: INTEGER
		do
			s := sec.truncated_to_integer
			make_by_seconds (s)
			fractional_second := sec - s
		end

	make_from_string_default (s: READABLE_STRING)
			-- Initialize from a "standard" string of form
			-- `default_format_string'.
		require
			s_exists: s /= Void
			time_valid: time_valid (s, Default_format_string)
		do
			make_from_string (s, Default_format_string)
		end

	make_from_string (s: READABLE_STRING; code: READABLE_STRING)
			-- Initialize from a "standard" string of form
			-- `code'.
		require
			s_exists: s /= Void
			c_exists: code /= Void
			time_valid: time_valid (s, code)
		local
			time: TIME
		do
			time := (create {DATE_TIME_CODE_STRING}.make (code)).create_time (s)
			make_fine (time.hour, time.minute, time.fine_second)
		end

	make_by_compact_time (c_t: INTEGER)
			-- Initialize from `compact_time'.
		require
			c_t_valid: compact_time_valid (c_t)
		do
			compact_time := c_t
		ensure
			compact_time_set: compact_time = c_t
		end

feature -- Access

	origin: TIME
			-- Origin time
		once
			create Result.make (0, 0, 0)
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is the current time before `other'?
		local
			l_current, l_other: like compact_time
		do
			l_current := compact_time
			l_other := other.compact_time
			Result := (l_current < l_other) or else
				((l_current = l_other) and (
					fractional_second < other.fractional_second and then
					(other.fractional_second - fractional_second) > 1.0E-10))
		end

feature -- Measurement

	duration: TIME_DURATION
			-- Duration elapsed from midnight
		do
			create Result.make_fine (hour, minute, fine_second)
		ensure then
			seconds_large_enough: Result.seconds_count >= 0
			seconds_small_enough: Result.seconds_count < Seconds_in_day
		end

	seconds: INTEGER
			-- Number of seconds elapsed from midnight
		do
			Result := (hour * Seconds_in_hour) + (minute * Seconds_in_minute) +
				second
		ensure
			result_definition: Result = duration.seconds_count
		end

	fine_seconds: DOUBLE
			-- Number of seconds and fractions of seconds elapsed from midnight
		do
			Result := (hour * Seconds_in_hour) + (minute * Seconds_in_minute) +
				fine_second
		end

feature -- Basic operations

	plus alias "+" (t: TIME_DURATION): TIME
			-- Sum of the current time and duration `t'
		require
			t_exists: t /= Void
		do
			Result := twin
			Result.fine_second_add (t.fine_second)
			Result.minute_add (t.minute)
			Result.hour_add (t.hour)
		ensure
			result_exists: Result /= Void
		end

	relative_duration (other: like Current): TIME_DURATION
			-- Duration elapsed from `other' to `Current'
		do
			create Result.make_by_fine_seconds (fine_seconds - other.fine_seconds)
			Result := Result.to_canonical
		end

	second_add (s: INTEGER)
			-- Add `s' seconds to the current time.
		local
			total_second: INTEGER
		do
			total_second := second + s
			if total_second < 0 or else total_second >= Seconds_in_minute then
				set_fine_second (mod (total_second, Seconds_in_minute) +
					fractional_second)
				minute_add (div (total_second, Seconds_in_minute))
			else
				set_fine_second (total_second + fractional_second)
			end
		end

	fine_second_add (f: DOUBLE)
			-- Add `f' seconds to the current time.
			-- if `f' has decimals, `fractional_second' is modified.
		local
			total_second: DOUBLE
		do
			total_second:= fine_second + f
			if total_second < 0 or else total_second >= Seconds_in_minute then
				set_fine_second (total_second - div (total_second.floor,
					Seconds_in_minute) * Seconds_in_minute)
				minute_add (div (total_second.floor, Seconds_in_minute))
			else
				set_fine_second (total_second)
			end
		end;

	minute_add (m: INTEGER)
			-- Add `m' minutes to the current object.
		local
			total_minute: INTEGER
		do
			total_minute := minute + m
			if total_minute < 0 or else total_minute >= minutes_in_hour then
				set_minute (mod (total_minute, minutes_in_hour))
				hour_add (div (total_minute, minutes_in_hour))
			else
				set_minute (total_minute)
			end
		end

	hour_add (h: INTEGER)
			-- Add `h' hours to the current object.
		do
			set_hour (mod (hour + h, Hours_in_day))
		end

	second_forth
			-- Move to next second.
		do
			if fine_second < Seconds_in_minute - 1 then
				set_fine_second (fine_second + 1)
			else
				set_fine_second (0)
				minute_forth
			end
		end

	second_back
			-- Move to previous second.
		do
			if fine_second > 0 then
				set_fine_second (fine_second - 1)
			else
				set_fine_second (Seconds_in_minute - 1)
				minute_back
			end
		end;

	minute_forth
			-- Move to next minute.
		do
			if minute < Minutes_in_hour - 1 then
				set_minute (minute + 1)
			else
				set_minute (0)
				hour_forth
			end
		end

	minute_back
			-- Move to evious minute.	
		do
			if minute > 0 then
				set_minute (minute - 1)
			else
				set_minute (Minutes_in_hour - 1)
				hour_back
			end
		end

	hour_forth
			-- Move to next hour.
		do
			if hour < Hours_in_day -  1 then
				set_hour (hour + 1)
			else
				set_hour (0)
			end
		end

	hour_back
			-- Move to evious hour.
		do
			if hour > 0 then
				set_hour (hour - 1)
			else
				set_hour (Hours_in_day - 1)
			end
		end

feature -- Output

	debug_output, out: STRING
			-- Printable representation of time with "standard"
			-- Form: `time_default_format_string'
		do
			Result := formatted_out (time_default_format_string)
		end

	formatted_out (s: READABLE_STRING): STRING
			-- Printable representation of time with "standard"
			-- Form: `s'
		require
			s_exists: s /= Void
		do
			Result := (create {DATE_TIME_CODE_STRING}.make (s)).create_time_string (Current)
		end

invariant

	second_large_enough: second >= 0
	second_small_enough: second < seconds_in_minute
	fractionals_large_enough: fractional_second >= 0
	fractionals_small_enough: fractional_second < 1
	minute_large_enough: minute >= 0;
	minute_small_enough: minute < minutes_in_hour
	hour_large_enough: hour >= 0
	hour_small_enough: hour < hours_in_day

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
