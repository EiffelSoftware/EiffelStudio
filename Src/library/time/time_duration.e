indexing
	description:"duration expressed in time"
	status:"See notice at end of class"
	date:"$Date: "
	revision:"$Revision$"
	access:date, time

class
	TIME_DURATION

inherit
	TIME_VALUE
		undefine
			is_equal
		end;
	DURATION
		undefine
			is_equal,
			out
		end

creation

	make,
	make_fine,
	make_by_seconds,
	make_by_fine_seconds

feature -- Initialization 

	make (h, m, s: INTEGER) is
			-- Set `hour', `minute' and `second' to `h', `m', `s' respectively.
		do
			hour := h;
			minute := m;
			fine_second := s
		ensure
			hour_set: hour = h;
			minute_set: minute = m;
			second_set: second = s
		end;

	make_fine (h, m: INTEGER; s: DOUBLE) is
			-- Set `hour, `minute' and `second' to `h', `m' and truncated to integer part of `s' respectively.
			-- Set `fractionnal_second' to the fractionnal part of `s'.
		do
			hour := h;
			minute := m;
			fine_second := s
		ensure
			hour_set: hour = h;
			minute_set: minute = m;
			fine_second_set: fine_second = s
		end;

	make_by_seconds (s: INTEGER) is
			-- Set the object by the number of seconds `s'.
		do
			fine_second := s;
			hour := div (s, seconds_in_hour);
			fine_second := fine_second - (hour * seconds_in_hour);
			minute := div (second, seconds_in_minute);
			fine_second := fine_second - (minute * seconds_in_minute)
		ensure
			seconds_count_set: seconds_count = s;
		end;

	make_by_fine_seconds (s: DOUBLE) is
			-- Set the object by the number of seconds `s'.
		do
			fine_second := s;
			hour := div (second, seconds_in_hour);
			fine_second := fine_second - (hour * seconds_in_hour);
			minute := div (second, seconds_in_minute);
			fine_second := fine_second - (minute * seconds_in_minute)
		ensure
			minute_large_enough: minute >= 0;
			minute_small_enough: minute < Minutes_in_hour;
			second_large_enough: second >= 0;
			second_small_enough: second < Seconds_in_minute;
			fine_seconds_set: fine_seconds_count = s
		end;

feature -- Access 

	fine_seconds_count: DOUBLE is
			-- Number of seconds and fractionnals of seconds of the current duration
		do
			Result := hour * Seconds_in_hour + minute * Seconds_in_minute + fine_second
		end;

	seconds_count: INTEGER is
			-- Total number of seconds of the current duration
		do
			Result := hour * Seconds_in_hour + minute * Seconds_in_minute + second
		ensure
			same_count: Result = fine_seconds_count.truncated_to_integer
		end;

	zero: TIME_DURATION is
			-- Neutral element for "+" and "-"
		once
			!! Result.make (0, 0, 0)
		end;

feature -- Comparaison

	infix "<" (other: like Current): BOOLEAN is
			-- Is the current duration smaller than `other'?
		do
			Result := fine_seconds_count < other.fine_seconds_count
		end;

	is_equal (other: like Current): BOOLEAN is
			-- Is the current duration equal to `other'?
		do
			Result := fine_seconds_count = other.fine_seconds_count
		end;

feature -- Status report

	canonical: BOOLEAN is
			-- Is duration expressed minimally, i.e.
			--	If duration is positive then
			--		`hour' positive,
			--		`minute' and `second' between 0 and 59,
			--		`fractionnal_second' between 0 and 999?
			--	If duration is negative then
			--		`hour' negative,
			--		`minute' and `second' between -59 and 0,
			--		`fractionnal_second' between -999 and 0?
		do
			if fine_seconds_count >= 0 then
				Result := fine_second < Seconds_in_minute and then fine_second >= 0 
					and then minute < minutes_in_hour and then minute >= 0
			else
				Result := fine_second > - Seconds_in_minute and then fine_second <= 0 
					and then minute > - minutes_in_hour and then minute <= 0
			end
		end;

feature -- Element Change

	set_second (s: INTEGER) is 
			-- Set `second' to `s'.
			-- `fractionnal_second' is cut down to 0.
		do
			fine_second := s
		ensure
			second_set: second = s
		end;

	set_fine_second (s: DOUBLE) is
			-- Set `fine_second' to `s'.
		do
			fine_second := s
		ensure
			second_set: fine_second = s
		end;

	set_fractionnals (f: DOUBLE) is
			-- Set `fractionnal_second' to `f'.
			-- `f' must have the same sign as `second'.
		require
			same_sign: (f.sign = second.sign) or else
				f.sign = 0 or else second.sign = 0;
			f_large_enough: f > -1;
			f_small_enough: f < 1
		do
			fine_second := second + f
		end;

	set_minute (m: INTEGER) is 
			-- Set `minute' to `m'.
		do
			minute:= m 
		ensure
			minute_set: minute = m 
		end;

	set_hour (h: INTEGER) is 
			-- Set `hour' to `h'. 
		do
			hour := h 
		ensure
			hour_set: hour = h 
		end;

feature -- Basic operations

	second_add (s: INTEGER) is
			-- Add `s' seconds to the current duration.
		do
			fine_second := fine_second + s
		ensure
			second_set: second = old second + s
		end;

	fine_second_add (s: DOUBLE) is
			-- Add `s' seconds to the current time.
			-- if `s' has decimals, `fractionnal_second' is modifed.
		do
			fine_second:= fine_second + s;
		end;

	minute_add (m: INTEGER) is
			-- Add `m' minutes to the current duration.
		do
			minute := minute + m
		ensure
			minute_set: minute = old minute + m
		end;

	hour_add (h: INTEGER) is
			-- Add `h' hours to the current duration.
		do
			hour := hour + h
		ensure
			hour_set: hour = old hour + h
		end;

	infix "+" (other: like Current): like Current is
			-- Sum with `other'
		do
			!! Result.make_fine (hour + other.hour, minute + other.minute, fine_second + other.fine_second)
		end;

	infix "-" (other: like Current): like Current is
			-- Difference with `other'
		do
			!! Result.make_fine (hour - other.hour, minute - other.minute, fine_second - other.fine_second)
		end;

	prefix "+": like Current is
			-- Unary plus
		do
			Result := Current
		end;

	prefix "-": like Current is
			-- Unary minus 
		do
			!! Result.make_fine (- hour, - minute, - fine_second)
		end;

feature -- Conversion

	to_canonical: like Current is
			-- A new duration 
		do
			if canonical then
				Result:= clone (Current)
			else
				if fine_seconds_count >= 0 then
					!! Result.make_by_fine_seconds (fine_seconds_count)
				else
					!! Result.make_by_fine_seconds (- fine_seconds_count);
					Result := - Result
				end
			end
		ensure
			result_canonical: Result.canonical;
		end;

	to_days: INTEGER is
			-- Total number of days equivalent to the current duration
		do
			Result := div (fine_seconds_count.floor, Seconds_in_day)
		end;

	time_modulo_day: like Current is
			-- Duration modulo duration of a day
		do
			!! Result.make_by_seconds (mod (fine_seconds_count.floor, Seconds_in_day));
			Result.fine_second_add (fine_seconds_count - fine_seconds_count.floor)
		ensure
			Result_smaller_than_day: Result.seconds_count < Seconds_in_day
			Result_positive: Result >= zero
		end;

invariant
	fractionnals_large_enough: fractionnal_second > -1;
	fractionnals_small_enough: fractionnal_second < 1;
	fractionnal_and_second_same_sign: second * fractionnal_second >= 0

end -- class TIME_DURATION

--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


