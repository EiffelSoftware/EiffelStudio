indexing
	description: "Absolute temporal value composed with a date and a time"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	access: date, time

class
	DATE_TIME

inherit
	ABSOLUTE
		undefine
			out
		redefine
			infix "<", copy, is_equal
		end;

	DATE_TIME_VALUE
		undefine
			is_equal
		redefine
			date, 
			time,
			copy,
			out
		end

creation

	make,
	make_fine,
	make_by_date_time,
	make_by_date,
	make_now,
	make_from_string
	

feature -- Initialization 

	make (y, mo, d, h, mi, s: INTEGER) is
			-- Set `year', `month' `day' to `y', `mo', `d'.
			-- Set `hour', `minute', `second' to `h', `mi', `s'.
		require 
			month_large_enough: mo >= 1;
			month_small_enough: mo <= Months_in_year;
			day_large_enough: d >= 1;
			day_small_enough: d <= days_in_i_th_month (mo, y)
			h_large_enough: h >= 0;
			h_small_enough: h < Hours_in_day;
			m_large_enough: mi >= 0;
			m_small_enough: mi < Minutes_in_hour;
			s_large_enough: s >= 0;
			s_small_enough: s < Seconds_in_minute	
		do
			!! date.make (y, mo, d);
			!! time.make (h, mi, s)
		ensure
			year_set: year = y;
			month_set: month = mo;
			day_set: day = d;
			hour_set: hour = h;
			minute_set: minute = mi;
			second_set: second = s
		end;
 
	make_fine (y, mo, d, h, mi: INTEGER; s: DOUBLE) is
			-- Set `year', `month' `day' to `y', `mo', `d'.
			-- Set `hour', `minute', `second' to `h', `m', `s'.
		require
			month_large_enough: mo >= 1;
			month_small_enough: mo <= Months_in_year;
			day_large_enough: d >= 1;
			day_small_enough: d <= days_in_i_th_month (mo, y)
			h_large_enough: h >= 0;
			h_small_enough: h < Hours_in_day;
			m_large_enough: mi >= 0;
			m_small_enough: mi < Minutes_in_hour;
			s_large_enough: s >= 0;
			s_small_enough: s < Seconds_in_minute	
		do
			!! date.make (y, mo, d);
			!! time.make_fine (h, mi, s)
		ensure
			year_set: year = y;
			month_set: month = mo;
			day_set: day = d
			hour_set: hour = h;
			minute_set: minute = mi;
			second_set: fine_second = s
		end;

	make_by_date_time (d: DATE; t: TIME) is
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
 
	make_by_date (d: DATE) is
			-- Set `date' to `d' and `time' to origin of time.
		require 
			d_exists: d /= Void; 
		do 
			date := d;
			!! time.make (0,0,0); 
		ensure 
			date_set: date = d; 
			time_set: time.is_equal (time.origin) 
		end; 
 
	make_now is
			-- Get the date and the time from the system.
		do 
			!! date.make_now; 
			!! time.make_now
		end; 

	make_from_string_default (s: STRING) is
			-- Initialise from a "standard" string of form
			-- `default_format_string'
		require
			s_exists: s /= Void;
			date_time_valid: date_time_valid (s, default_format_string)
		do
			make_from_string (s, default_format_string)
		end

	make_from_string (s: STRING; code: STRING) is
			-- Initialise from a "standard" string of form
			-- `code'
		require
			s_exists: s /= Void;
			c_exists: code /= Void
			date_time_valid: date_time_valid (s, code)
		local
			code_string: DATE_TIME_CODE_STRING
			date_time: DATE_TIME
		do
			!! code_string.make (code)
			date_time := code_string.create_date_time (s)
			make_by_date_time (date_time.date, date_time.time)
		end

feature -- Preconditions

	date_time_valid (s: STRING; code_string: STRING): BOOLEAN is
			-- Is the code_string enough precise
			-- To create an instance of type DATE_TIME
			-- And does the string `s' correspond to `code_string'?
		require
			s_exists: s /= Void
			code_exists: code_string /= Void
		local
			code: DATE_TIME_CODE_STRING
		do
			!! code.make (code_string)
			Result := code.precise and code.correspond (s)
		end
	
feature -- Access
			
	date: DATE;
			-- Date of the current object
 
	time: TIME;
			-- Time of the current object 

	origin: DATE_TIME is
			-- Origin date with origin time
		once
			!! Result.make_by_date_time (date.origin, time.origin)
		end;

	date_duration: DATE_DURATION is
			-- Definite duration between origin of date and current date
		do
			Result := date.duration
		end;

	days: INTEGER is
			-- Number of days elapsed since `origin'
		do
			Result := date.days
		end;

	time_duration: TIME_DURATION is
			-- Duration elapsed from midnight of the current date
		do
			Result := time.duration
		end;
	
	seconds: INTEGER is
			-- Number of seconds elapsed from midnight of the current date
		do
			Result := time.seconds
		end;

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is the current object before `other'?
		do
			Result := date < other.date or else
				(date.is_equal (other.date) and then
				(time < other.time))
		end;

	is_equal (other: like Current): BOOLEAN is
			-- Is the current object equal to `other'?
		do
			Result := equal (date, other.date) and then equal (time, other.time)
		end

feature -- Measurement 
 
	duration: DATE_TIME_DURATION is 
			-- Definite duration elapsed from `origin' 
		do
			!! Result.make_by_date_time (date_duration, time_duration)
		ensure then
			definite_result: Result.definite 
		end 

feature -- Element Change

	set_date (d: DATE) is 
			-- Set `date' to `d'.
		require 
			d_exists: d /= Void
		do 
			date := d
		ensure 
			date_set: date = d
		end;
 
	set_time (t: TIME) is 
			-- Set `time' to `t'. 
		require 
			t_exists: t /= Void
		do 
			time := t
		ensure 
			time_set: time = t 
		end;

	copy (other: like Current) is
			-- set `date' and `time' with the `other' attributes.
		do
			{ABSOLUTE} Precursor (other)
			date := clone (other.date)
			time := clone (other.time)
		end

feature -- Basic operations

	infix "+" (d: DATE_TIME_DURATION): like Current is
			-- Sum the current object with `d'
		do
			Result := clone (Current)
			Result.add (d)
		ensure
			result_exists: Result /= Void
		end;
	
	add (dtd: DATE_TIME_DURATION) is
			-- Adds `dtd' to the current object.
		do
			if dtd.definite then
				day_add (dtd.day)
			else
				date.year_month_add (dtd.year, dtd.month);
				day_add (dtd.day)
			end;
			day_add ((dtd.time + time_duration).to_days);
			time := time.origin + (dtd.time + time_duration).time_modulo_day
		end;
	
	relative_duration (other: like Current): DATE_TIME_DURATION is
			-- Duration from `other' to the current date, expressed in year, month, day and time
		do
			!! Result.make_fine (0, 0, days - other.days, hour - other.hour, minute - other.minute, fine_second - other.fine_second);
			Result := Result.to_canonical (other)
		end;

	definite_duration (other: like Current): DATE_TIME_DURATION is 
			-- Duration from `other' to the current date, expressed in year, month, day and time 
		require
			other_exists: other /= Void
		do 
			Result := relative_duration (other);
			Result.date.to_definite (other.date)
		ensure
			definite_result: Result.definite
		end; 
 
	day_add (d: INTEGER) is
			-- Add `d' days to the current date.
		do
			date.make_by_days (days + d)
		ensure
			days_set: days = old days + d
		end

	hour_add (h: INTEGER) is
			-- Add `h' hours to the current time.
		local
			total_hour: INTEGER
		do
			total_hour := hour + h;
			if (total_hour < 0 or else total_hour >= Hours_in_day) then
				time.set_hour (mod (total_hour, Hours_in_day));
				day_add (div (total_hour, Hours_in_day))
			else
				time.set_hour (total_hour)
			end
		end;

	minute_add (m: INTEGER) is
			-- Add `m' minutes to the current time.
		local
			total_minute: INTEGER
		do
			total_minute := minute + m;
			if (total_minute < 0 or else total_minute >= Minutes_in_hour) then
				time.set_minute (mod (total_minute, Minutes_in_hour));
				hour_add (div (total_minute, Minutes_in_hour))
			else
				time.set_minute (total_minute)
			end
		end;

	second_add (s: INTEGER) is
			-- Add `s' seconds to the current time.
		local
			total_second: INTEGER
		do
			total_second := second + s;
			if (total_second < 0 or else total_second >= Seconds_in_minute) then
				time.set_second (mod (total_second, Seconds_in_minute));
				minute_add (div (total_second, Seconds_in_minute))
			else
				time.set_second (total_second)
			end
		end;

	fine_second_add (s: DOUBLE) is
			-- Add `s' seconds to the current object.
			-- if `s' has decimals, `fractionnal_second' from `time' is modified.
		local
			total_second: DOUBLE
		do
			total_second := time.fine_second + s;
			if (total_second < 0 or else total_second >= Seconds_in_minute) then
				time.set_fine_second (total_second - div (total_second.floor, Seconds_in_minute) * Seconds_in_minute);
				minute_add (div (total_second.floor, Seconds_in_minute))
			else
				time.set_fine_second (total_second)
			end
		end;

feature -- Output

	out: STRING is
			-- Printable representation of the current object
			-- With "standard" form: `default_format_string'
		do
			Result := formatted_out (default_format_string)
			--Result := clone (date.out);
			--Result.extend (' ');
			--Result.append (time.out_fine(3))
		end

	formatted_out (s: STRING): STRING is
			-- Printable representation of the current object
			-- With "standard" form: `s'
		require
			s_exists: s /= Void
		local
			code: DATE_TIME_CODE_STRING
		do
			!! code.make (s)
			Result := code.create_string (Current)
		end

end -- class DATE_TIME

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


