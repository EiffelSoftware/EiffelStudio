note
	description:"Durations of time"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date:"$Date$"
	revision:"$Revision$"
	access: time

class TIME_DURATION inherit

	DURATION
		undefine
			is_equal
		end

	TIME_MEASUREMENT
		undefine
			is_equal
		end

	DOUBLE_MATH
		export
			{NONE} all
		undefine
			is_equal
		end

create

	make,
	make_fine,
	make_by_seconds,
	make_by_fine_seconds

feature -- Initialization

	make (h, m, s: INTEGER)
			-- Set `hour', `minute' and `second' to `h', `m', `s' respectively.
		do
			hour := h
			minute := m
			fine_second := s
		ensure
			hour_set: hour = h
			minute_set: minute = m
			second_set: second = s
		end

	make_fine (h, m: INTEGER; s: DOUBLE)
			-- Set `hour, `minute' and `second' to `h', `m' and truncated to
			-- integer part of `s' respectively.
			-- Set `fractional_second' to the fractional part of `s'.
		do
			hour := h
			minute := m
			fine_second := s
		ensure
			hour_set: hour = h
			minute_set: minute = m
			fine_second_set: fine_second = s
		end

	make_by_seconds (s: INTEGER)
			-- Set the object by the number of seconds `s'.
		do
			fine_second := s
			hour := div (s, seconds_in_hour)
			fine_second := fine_second - (hour * seconds_in_hour)
			minute := div (second, seconds_in_minute)
			fine_second := fine_second - (minute * seconds_in_minute)
		ensure
			seconds_count_set: seconds_count = s
		end

	make_by_fine_seconds (s: DOUBLE)
			-- Set the object by the number of seconds `s'.
		do
			fine_second := s
			hour := div (second, seconds_in_hour)
			fine_second := fine_second - (hour * seconds_in_hour)
			minute := div (second, seconds_in_minute)
			fine_second := fine_second - (minute * seconds_in_minute)
		ensure
			minute_large_enough: minute >= 0
			minute_small_enough: minute < Minutes_in_hour
			second_large_enough: second >= 0
			second_small_enough: second < Seconds_in_minute
			fine_seconds_set: dabs (fine_seconds_count - s) <= tolerance
		end

feature -- Access

	fine_seconds_count: DOUBLE
			-- Number of seconds and fractionals of seconds of current duration
		do
			Result := hour * Seconds_in_hour + minute * Seconds_in_minute +
				fine_second
		end

	seconds_count: INTEGER
			-- Total number of seconds of current duration
		do
			Result := fine_seconds_count.truncated_to_integer
		ensure
			same_count: Result = fine_seconds_count.truncated_to_integer
		end

	zero: like Current
			-- Neutral element for "+" and "-"
		do
			create Result.make (0, 0, 0)
		end

feature -- Attributes

	hour: INTEGER

	minute: INTEGER

	second: INTEGER
		do
			Result := fine_second.truncated_to_integer
		end

	fine_second: DOUBLE

	fractional_second: DOUBLE
		do
			Result := fine_second - second
		end

feature -- Comparaison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is the current duration smaller than `other'?
		do
			Result := fine_seconds_count < other.fine_seconds_count
		end

	is_equal (other: like Current): BOOLEAN
			-- Is the current duration equal to `other'?
		do
			Result := fine_seconds_count = other.fine_seconds_count
		end

feature -- Status report

	canonical: BOOLEAN
			-- Is duration expressed minimally, i.e.
			--	If duration is positive then
			--		`hour' positive,
			--		`minute' and `second' between 0 and 59,
			--		`fractional_second' between 0 and 999?
			--	If duration is negative then
			--		`hour' negative,
			--		`minute' and `second' between -59 and 0,
			--		`fractional_second' between -999 and 0?
		do
			if fine_seconds_count >= 0 then
				Result := fine_second < Seconds_in_minute and then
					fine_second >= 0 and then minute < minutes_in_hour and then
					minute >= 0
			else
				Result := fine_second > -Seconds_in_minute and then
					fine_second <= 0 and then minute > -Minutes_in_hour and then
					minute <= 0
			end
		end

	is_positive: BOOLEAN
			-- Is duration positive?
		do
			Result := (hour > 0 or minute > 0 or fine_second > 0)
		end

feature -- Element Change

	set_second (s: INTEGER)
			-- Set `second' to `s'.
			-- `fractional_second' is cut down to 0.
		do
			fine_second := s
		end

	set_fine_second (s: DOUBLE)
			-- Set `fine_second' to `s'.
		do
			fine_second := s
		end

	set_fractionals (f: DOUBLE)
			-- Set `fractional_second' to `f'.
			-- `f' must have the same sign as `second'.
		do
			fine_second := second + f
		end

	set_minute (m: INTEGER)
			-- Set `minute' to `m'.
		do
			minute:= m
		end

	set_hour (h: INTEGER)
			-- Set `hour' to `h'.
		do
			hour := h
		end

feature -- Basic operations

	second_add (s: INTEGER)
			-- Add `s' seconds to the current duration.
		do
			fine_second := fine_second + s
		ensure
			second_set: second = old second + s
		end

	fine_second_add (s: DOUBLE)
			-- Add `s' seconds to the current time.
			-- if `s' has decimals, `fractional_second' is modifed.
		do
			fine_second:= fine_second + s
		end

	minute_add (m: INTEGER)
			-- Add `m' minutes to the current duration.
		do
			minute := minute + m
		ensure
			minute_set: minute = old minute + m
		end

	hour_add (h: INTEGER)
			-- Add `h' hours to the current duration.
		do
			hour := hour + h
		ensure
			hour_set: hour = old hour + h
		end

	infix "+" (other: like Current): like Current
			-- Sum with `other'
		do
			create Result.make_fine (hour + other.hour, minute + other.minute,
				fine_second + other.fine_second)
		end

	prefix "-": like Current
			-- Unary minus
		do
			create Result.make_fine (-hour, -minute, -fine_second)
		end

feature -- Conversion

	to_canonical: like Current
			-- A new duration
		do
			if canonical then
				Result := twin
			else
				if fine_seconds_count >= 0 then
					create Result.make_by_fine_seconds (fine_seconds_count)
				else
					create Result.make_by_fine_seconds (-fine_seconds_count)
					Result := -Result
				end
			end
		ensure
			result_canonical: Result.canonical
		end

	to_days: INTEGER
			-- Total number of days equivalent to the current duration
		do
			Result := div (fine_seconds_count.floor, Seconds_in_day)
		end

	time_modulo_day: like Current
			-- Duration modulo duration of a day
		do
			create Result.make_by_seconds (mod (fine_seconds_count.floor,
				Seconds_in_day))
			Result.fine_second_add (fine_seconds_count -
				fine_seconds_count.floor)
		ensure
			Result_smaller_than_day: Result.seconds_count < Seconds_in_day
			Result_positive: Result >= zero
		end

feature {NONE} -- Constants

	tolerance: DOUBLE = 1.0E-06
			-- Tolerance for floating point errors

invariant

	fractionals_large_enough: fractional_second > -1
	fractionals_small_enough: fractional_second < 1
	fractional_and_second_same_sign: second * fractional_second >= 0
	equal_signs: canonical implies (hour >= 0 and minute >= 0 and
			fine_second >= 0) or (hour <= 0 and minute <= 0 and
			fine_second <= 0)


note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class TIME_DURATION


