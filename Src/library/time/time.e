indexing
	description: "absolute time"
	status: "See notice at end of class";
	date: "$Date: "
	revision: "$Revision$"
	access: date, time

class
	TIME

inherit
	ABSOLUTE
		undefine
			out
		redefine
			infix "<"
		end;
	TIME_VALUE
		undefine
			is_equal
		redefine
			out
		end

creation

	make,
	make_fine,
	make_now,
	make_by_seconds,
	make_by_fine_seconds,
	make_from_string,
	make_by_compact_time

feature -- Initialization

	make (h, m, s: INTEGER) is
			-- Set `hour, `minute' and `second' to `h', `m', `s' respectively.
		require
			h_large_enough: h >= 0;
			h_small_enough: h < Hours_in_day;
			m_large_enough: m >= 0;
			m_small_enough: m < Minutes_in_hour;
			s_large_enough: s >= 0;
			s_small_enough: s < Seconds_in_minute	
		do
			compact_time := c_make_time (h, m, s)
		ensure
			hour_set: hour = h;
			minute_set: minute = m;
			second_set: second = s
		end;

	make_fine (h, m: INTEGER; s: DOUBLE) is
			-- Set `hour, `minute' and `second' to `h', `m' and truncated to integer part of `s' respectively.
			-- Set `fractionnal_second' to the fractionnal part of `s'.
		require
			h_large_enough: h >= 0;
			h_small_enough: h < Hours_in_day;
			m_large_enough: m >= 0;
			m_small_enough: m < Minutes_in_hour;
			s_large_enough: s >= 0;
			s_small_enough: s < Seconds_in_minute;
		local
			s_tmp: INTEGER
		do
			s_tmp :=  s.truncated_to_integer
			fractionnal_second := s - s_tmp
			make (h, m, s_tmp)
		ensure
			hour_set: hour = h;
			minute_set: minute = m;
			fine_second_set: fine_second = s
		end;

	make_now is
			-- Set current time according to timezone.
		local
			h, m, s: INTEGER
		do
			c_get_date_time;
			h := c_hour_now;
			m := c_minute_now;
			s := c_second_now;
			make (h, m, s)
			fractionnal_second := c_millisecond_now / 1000;
			--fine_second := (c_second + c_millisecond / 1000);
		end;

	make_by_seconds (sec: INTEGER) is
			-- Set the object by the number of seconds `sec' from midnight.
		require
			s_large_enough: sec >= 0;
			s_small_enough: sec < Seconds_in_day
		local
			h, m, s: INTEGER
		do
			s := sec;
			h := s // Seconds_in_hour;
			s := s - (h * Seconds_in_hour);
			m := s // Seconds_in_minute;
			s := s - (m * Seconds_in_minute);
			make (h, m, s)
			fractionnal_second := 0;
		ensure
			seconds_set: seconds = sec
		end;

	make_by_fine_seconds (sec: DOUBLE) is
			-- Set the object by the number of seconds `sec'.
		require
			s_large_enough: sec >= 0;
			s_small_enough: sec < Seconds_in_day
		local
			s: INTEGER
		do
			s := sec.truncated_to_integer;
			fractionnal_second := sec - s;
			make_by_seconds (s)
		end;

	make_from_string_default (s: STRING) is
			-- Initialise from a "standard" string of form
			-- `default_format_string'
		require
			s_exists: s /= Void;
			time_valid: time_valid (s, default_format_string)
		do
			make_from_string (s, default_format_string)
		end

	make_from_string (s: STRING; code: STRING) is
			-- Initialise from a "standard" string of form
			-- `code'
		require
			s_exists: s /= Void;
			c_exists: code /= Void
			time_valid: time_valid (s, code)
		local
			code_string: DATE_TIME_CODE_STRING
			time: TIME
		do
			!! code_string.make (code)
			time := code_string.create_time (s)
			make_fine (time.hour, time.minute, time.fine_second)
		end
		
	make_by_compact_time (c_t: INTEGER) is
			-- Initialize from `compact_time'.
		require
			c_t_not_void: c_t /= Void
			c_t_valid: compact_time_valid (c_t)
		do
			compact_time := c_t
		ensure
			compact_time_set: compact_time = c_t;
		end

feature -- Preconditions

	time_valid (s: STRING; code_string: STRING): BOOLEAN is
			-- Is the code_string enough precise
			-- To create an instance of type TIME
			-- And does the string `s' correspond to `code_string'?
		require
			s_exists: s /= Void
			code_exists: code_string /= Void
		local
			code: DATE_TIME_CODE_STRING
		do
			!! code.make (code_string)
			Result := code.precise_time and code.correspond (s)
		end
		
	compact_time_valid (c_t: INTEGER): BOOLEAN is
		require
			c_t_not_void: c_t /= Void
		local
			h, m, s: INTEGER
		do
			h := c_hour (c_t)
			m := c_minute (c_t)
			s := c_second (c_t)
			Result := (h >= 0 and h < Hours_in_day and
			m >= 0 and m < Minutes_in_hour and
			s >= 0 and s < Seconds_in_minute)	
		end

feature -- Access

	origin: TIME is
			-- Origin time
		once
			!! Result.make (0, 0, 0)
		end;

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is the current time before `other'?
		do
			Result := hour < other.hour or else
				(hour = other.hour and then 
				(minute < other.minute or else
				(minute = other.minute and then
				(fine_second < other.fine_second))))
		end;

feature -- Measurement

	duration: TIME_DURATION is 
			-- Duration elapsed from midnight 
		do 
			!! Result.make_fine (hour, minute, fine_second) 
		ensure then
			seconds_large_enough: duration.seconds_count >= 0;
			seconds_small_enough: duration.seconds_count < Seconds_in_day
		end;

	seconds: INTEGER is
			-- Number of seconds elapsed from midnight
		do
			Result := (hour * Seconds_in_hour) + (minute * Seconds_in_minute) + second
		ensure
			result_definition: Result = duration.seconds_count
		end

	fine_seconds: DOUBLE is
			-- Number of seconds and fractions of seconds elapsed from midnight
		do
			Result := (hour * Seconds_in_hour) + (minute * Seconds_in_minute) + fine_second
		end;

feature -- Element change 
 
	set_second (s: INTEGER) is 
			-- Set `second' to `s'.
		require 
			s_large_enough: s >= 0; 
			s_small_enough: s < Seconds_in_minute 
		do 
			c_set_second (s, compact_time)
		ensure 
			second_set: second = s 
		end;

	set_fine_second (s: DOUBLE) is 
			-- Set `fine_second' to `s'
		require 
			s_large_enough: s >= 0; 
			s_small_enough: s < Seconds_in_minute
		local
			s_tmp: INTEGER 
		do 
			s_tmp := s.truncated_to_integer
			fractionnal_second := s - s_tmp
			set_second (s_tmp)
		ensure
			fine_second_set: fine_second = s
		end;

	set_fractionnals (f: DOUBLE) is
			-- Set `fractionnal_second' to `f'.
		require
			f_large_enough: f >= 0;
			f_small_enough: f < 1 
		do
			fractionnal_second := f
		ensure
			second_same: second = old second
		end;	

	set_minute (m: INTEGER) is 
			-- Set `minute' to `m'.
		require 
			m_large_enough: m >= 0; 
			m_small_enough: m < Minutes_in_hour 
		do 
			c_set_minute (m, compact_time) 
		ensure 
			minute_set: minute = m 
		end;

	set_hour (h: INTEGER) is 
			-- Set `hour' to `h'.
		require 
			h_large_enough: h >= 0; 
			h_small_enough: h < Hours_in_day 
		do 
			c_set_hour (h, compact_time)
		ensure 
			hour_set: hour = h 
		end;

feature -- Basic operations

	infix "+" (t: TIME_DURATION): TIME is
			-- Sum of the current time and duration `t'
		require
			t_exists: t /= Void
		do
			Result := clone (Current);
			Result.fine_second_add (t.fine_second);
			Result.minute_add (t.minute);
			Result.hour_add (t.hour)
		ensure
			result_exists: Result /= Void
		end;

	relative_duration (other: like Current): TIME_DURATION is
			-- Duration elapsed from `other' to `Current'
		do
			!! Result.make_by_fine_seconds (fine_seconds - other.fine_seconds);
			Result := Result.to_canonical
		end;

	second_add (s : INTEGER) is
			-- Add `s' seconds to the current time.
		local
			total_second: INTEGER
		do
			total_second := second + s;
			if (total_second < 0 or else total_second >= Seconds_in_minute) then
				set_fine_second (mod (total_second, Seconds_in_minute) + fractionnal_second)
				minute_add (div (total_second, Seconds_in_minute))	
			else
				set_fine_second (total_second + fractionnal_second)
			end
		end;

	fine_second_add (f: DOUBLE) is
			-- Add `f' seconds to the current time.
			-- if `f' has decimals, `fractionnal_second' is modified.
		local
			total_second: DOUBLE
		do
			total_second:= fine_second + f;
			if (total_second < 0 or else total_second >= Seconds_in_minute) then
				set_fine_second (total_second - div (total_second.floor, Seconds_in_minute) * Seconds_in_minute)
				minute_add (div (total_second.floor, Seconds_in_minute))
			else
				set_fine_second (total_second)
			end
		end;	

	minute_add (m: INTEGER) is
			-- Add `m' minutes to the current object.
		local
			total_minute: INTEGER
		do
			total_minute := minute + m;
			if (total_minute < 0 or else total_minute >= minutes_in_hour) then
				set_minute (mod (total_minute, minutes_in_hour))
				hour_add (div (total_minute, minutes_in_hour))
			else
				set_minute (total_minute)
			end
		end;

	hour_add (h: INTEGER) is
			-- Add `h' hours to the current object.
		do
			set_hour (mod (hour + h, Hours_in_day))
		end;

	second_forth is
			-- Move to next second.
		do
			if fine_second < Seconds_in_minute - 1 then
				set_fine_second (fine_second + 1)
			else
				set_fine_second (0);
				minute_forth
			end
		end;
	
	second_back is
			-- Move to previous second.
		do
			if fine_second > 0 then
				set_fine_second (fine_second - 1)
			else
				set_fine_second (Seconds_in_minute - 1)
				minute_back
			end
		end;	

	minute_forth is
			-- Move to next minute.
		do
			if minute < Minutes_in_hour - 1 then
				set_minute (minute + 1)
			else
				set_minute (0);
				hour_forth
			end
		end;

	minute_back is
			-- Move to evious minute.	
		do
			if minute > 0 then
				set_minute (minute - 1)
			else
				set_minute (Minutes_in_hour - 1)
				hour_back
			end
		end;

	hour_forth is
			-- Move to next hour.
		do
			if hour < Hours_in_day -  1 then
				set_hour (hour + 1)
			else
				set_hour (0)
			end
		end;

	hour_back is
			-- Move to evious hour.
		do
			if hour > 0 then
				set_hour (hour - 1)
			else
				set_hour (Hours_in_day - 1)
			end
		end;
		
feature -- Output

	out: STRING is
			-- Printable representation of time with "standard"
			-- Form: `time_default_format_string'
		do
			Result := formatted_out (time_default_format_string)
		end

	formatted_out (s: STRING): STRING is
			-- Printable representation of time with "standard"
			-- Form: `s'
		require
			s_exists: s /= Void
		local
			code: DATE_TIME_CODE_STRING
		do
			!! code.make (s)
			Result := code.create_time_string (Current)
		end	
	
feature {NONE} -- Externals 
	
	c_get_date_time is
		external
			"C"
		end;
	
	c_hour_now: INTEGER is
		external
			"C"
		end;

	c_minute_now: INTEGER is
		external
			"C"
		end;

	c_second_now: INTEGER is
		external
			"C"
		end;

	c_millisecond_now: INTEGER is
		external
			"C"
		end;

	c_make_time (h, m, s: INTEGER): INTEGER is
		external
			"C"
		end;

	c_set_hour (h, c_t: INTEGER) is
		external
			"C"
		end;

	c_set_minute (h, c_t: INTEGER) is
		external
			"C"
		end;

	c_set_second (h, c_t: INTEGER) is
		external
			"C"
		end;

invariant
	second_large_enough: second >= 0;
	second_small_enough: second < seconds_in_minute;
	fractionnals_large_enough: fractionnal_second >= 0;
	fractionnals_small_enough: fractionnal_second < 1;
	minute_large_enough: minute >= 0;	 
	minute_small_enough: minute < minutes_in_hour;
	hour_large_enough: hour >= 0;
	hour_small_enough: hour < hours_in_day;
	
end -- class TIME


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

