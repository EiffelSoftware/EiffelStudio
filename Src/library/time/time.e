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
		end

creation

	make,
	make_fine,
	make_now,
	make_by_seconds,
	make_by_fine_seconds,
	make_from_string

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
		require
			h_large_enough: h >= 0;
			h_small_enough: h < Hours_in_day;
			m_large_enough: m >= 0;
			m_small_enough: m < Minutes_in_hour;
			s_large_enough: s >= 0;
			s_small_enough: s < Seconds_in_minute;
		do
			hour := h;
			minute := m;
			fine_second := s
		ensure
			hour_set: hour = h;
			minute_set: minute = m;
			fine_second_set: fine_second = s
		end;

	make_now is
			-- Set current time according to timezone.
		do
			c_get_date_time;
			hour := c_hour;
			minute := c_minute;
			fine_second := c_second;
		end;

	make_by_seconds (s: INTEGER) is
			-- Set the object by the number of seconds `s' from midnight.
		require
			s_large_enough: s >= 0;
			s_small_enough: s < Seconds_in_day
		do
			fine_second := s;
			hour := second // Seconds_in_hour;
			fine_second := fine_second - (hour * Seconds_in_hour);
			minute := second // Seconds_in_minute;
			fine_second := fine_second - (minute * Seconds_in_minute)
		ensure
			seconds_set: seconds = s
		end;

	make_by_fine_seconds (s: DOUBLE) is
			-- Set the object by the number of seconds `s'.
		require
			s_large_enough: s >= 0;
			s_small_enough: s < Seconds_in_day
		do
			fine_second := s;
			hour := div (second, seconds_in_hour);
			fine_second := fine_second - (hour * seconds_in_hour);
			minute := div (second, seconds_in_minute);
			fine_second := fine_second - (minute * seconds_in_minute)
		end;

	make_from_string(s:STRING) is
			-- initialise from a "standard" string of form
			-- "dd/mm/yyyy hh:mm:ss.sss".
		require 
			s_exits: s /= Void;
			time_valid: time_valid(s);
		local
			 t:STRING
			 pos1, pos2, pos3:INTEGER
		do
			 t := s.substring(s.index_of(Std_date_time_delim,1)+1, s.count)
			 pos1 := t.index_of(Std_time_delim,1) 
			 pos2 := t.index_of(Std_time_delim,pos1+1) 
			 pos3 := t.count+1

			 make_fine(t.substring(1,pos1-1).to_integer, 
						t.substring(pos1+1,pos2-1).to_integer, 
						t.substring(pos2+1,pos3-1).to_real) 
		ensure
			
	       end
		   
feature -- conditions

	time_valid(s: STRING): BOOLEAN is
			-- Has the substring the format "hh:mm:ss.sss"?
		local
			pos1, pos2, pos3, pos4: INTEGER
			substrg1, substrg2, substrg3: STRING
		do
			pos1:=s.index_of(Std_date_time_delim,1)
			pos2:=s.index_of(Std_time_delim,1)
			pos3:=s.index_of(Std_time_delim,pos2+1)
			pos4:=s.count+1
			substrg1:=s.substring(pos1+1, pos2-1)
			substrg2:=s.substring(pos2+1, pos3-1)
			substrg3:=s.substring(pos3+1, pos4-1)
			
			Result:=s.item(pos1+3)=Std_time_delim and s.item(pos2+3)=Std_time_delim and substrg1.is_integer and substrg2.is_integer and substrg3.is_real; 
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
			fine_second := s
		ensure 
			second_set: second = s 
		end;

	set_fine_second (s: DOUBLE) is 
			-- Set `fine_second' to `s'
		require 
			s_large_enough: s >= 0; 
			s_small_enough: s < Seconds_in_minute 
		do 
			fine_second := s 
		ensure
			fine_second_set: fine_second = s
		end;

	set_fractionnals (f: DOUBLE) is
			-- Set `fractionnal_second' to `f'.
		require
			f_large_enough: f >= 0;
			f_small_enough: f < 1 
		do
			fine_second := second + f
		ensure
			second_same: second = old second
		end;	

	set_minute (m: INTEGER) is 
			-- Set `minute' to `m'.
		require 
			m_large_enough: m >= 0; 
			m_small_enough: m < Minutes_in_hour 
		do 
			minute := m 
		ensure 
			minute_set: minute = m 
		end;

	set_hour (h: INTEGER) is 
			-- Set `hour' to `h'.
		require 
			h_large_enough: h >= 0; 
			h_small_enough: h < Hours_in_day 
		do 
			hour := h 
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
				fine_second := mod (total_second, Seconds_in_minute) + fractionnal_second;
				minute_add (div (total_second, Seconds_in_minute))	
			else
				fine_second := total_second + fractionnal_second
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
				fine_second := total_second - div (total_second.floor, Seconds_in_minute) * Seconds_in_minute;
				minute_add (div (total_second.floor, Seconds_in_minute))
			else
				fine_second:= total_second
			end
		end;	

	minute_add (m: INTEGER) is
			-- Add `m' minutes to the current object.
		local
			total_minute: INTEGER
		do
			total_minute := minute + m;
			if (total_minute < 0 or else total_minute >= minutes_in_hour) then
				minute := mod (total_minute, minutes_in_hour);
				hour_add (div (total_minute, minutes_in_hour))
			else
				minute := total_minute
			end
		end;

	hour_add (h: INTEGER) is
			-- Add `h' hours to the current object.
		do
			hour := mod (hour + h, Hours_in_day)
		end;

	second_forth is
			-- Move to next second.
		do
			if fine_second < Seconds_in_minute - 1 then
				fine_second := fine_second + 1
			else
				fine_second := 0;
				minute_forth
			end
		end;
	
	second_back is
			-- Move to previous second.
		do
			if fine_second > 0 then
				fine_second := fine_second - 1
			else
				fine_second := Seconds_in_minute - 1;
				minute_back
			end
		end;	

	minute_forth is
			-- Move to next minute.
		do
			if minute < Minutes_in_hour - 1 then
				minute := minute + 1
			else
				minute := 0;
				hour_forth
			end
		end;

	minute_back is
			-- Move to evious minute.	
		do
			if minute > 0 then
				minute := minute - 1
			else
				minute := Minutes_in_hour - 1
				hour_back
			end
		end;

	hour_forth is
			-- Move to next hour.
		do
			if hour < Hours_in_day -  1 then
				hour := hour + 1
			else
				hour := 0
			end
		end;

	hour_back is
			-- Move to evious hour.
		do
			if hour > 0 then
				hour := hour - 1
			else
				hour := Hours_in_day - 1
			end
		end;
				
feature {NONE} -- Externals 
	
	c_get_date_time is
		external
			"C"
		end;
	
	c_hour: INTEGER is
		external
			"C"
		end;

	c_minute: INTEGER is
		external
			"C"
		end;

	c_second: INTEGER is
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

