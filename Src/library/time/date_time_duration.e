indexing 
	description: "duration expressed in date and time" 
	status: "See notice at end of class" 
	date: "$Date$" 
	revision: "$Revision$" 
	access: date, time 

class 
	DATE_TIME_DURATION
 
inherit
	DATE_TIME_VALUE
		undefine
			is_equal
		redefine
			date,
			time
		end;
	DURATION
		undefine
			is_equal,
			out
		end

creation
	make,
	make_definite,
	make_fine,
	make_by_date_time,
	make_by_date

feature -- Initialization

	make (y, mo, d, h, mi, s: INTEGER) is
			-- Set `year', `month', `day' to `y', `mo', `d' .
			-- Set `hour', `minute', `second' to `h', `mi', `s'.
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

	make_definite (d, h, m, s: INTEGER) is
			-- Set `day' to `d'.
			-- Set `hour', `minute', `second' to `h', `m', `s'.
		do
			!! date.make_by_days (d);
			!! time.make (h, m, s)
		ensure
			definite_result: definite;
			day_set: day = d; 
			hour_set: hour = h;
			minute_set: minute = m;
			second_set: second = s
		end;

	make_fine (y, mo, d, h, mi: INTEGER; s: DOUBLE) is
			-- set `year', `month', `day' to `y', `mo', `d'.
			-- set `hour', `minute', `second' to `h', `mi', `s'.
		do
			!! date.make (y, mo, d);
			!! time.make_fine (h, mi, s)
		ensure
			year_set: year = y; 
			month_set: month = mo; 
			day_set: day = d; 
			hour_set: hour = h;
			minute_set: minute = mi;
			fine_second_set: fine_second = s
		end;

	 make_by_date_time (d: DATE_DURATION; t: TIME_DURATION) is
			-- Set `date' to `d' and `time' to `t'.
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

	make_by_date (d: DATE_DURATION) is
			-- Set `date' to `d' and `time' to zero.
		require 
			d_exists: d /= Void; 
		do 
			date := d;
			!! time.make (0,0,0); 
		ensure 
			date_set: date = d; 
			time_set: time.is_equal (time.zero)
		end; 

feature -- Access 

	date: DATE_DURATION;
			-- date part of the current duration

	time: TIME_DURATION;
			-- time part of current duration

	zero: DATE_TIME_DURATION is
			-- Neutral element
		once
			!! Result.make_by_date_time (date.zero, time.zero)
		end;

	fine_seconds_count: DOUBLE is
			-- Number of seconds and fractionnals of seconds of the current duration
		do
			Result := time.fine_seconds_count
		end;

	seconds_count: INTEGER is
			-- Total number of seconds of the current duration
		do
			Result := time.seconds_count
		end;

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is the current duration smaller than `other'?
			-- False if either is not definite
		do
			if definite and then other.definite then
				Result := (day + time.to_days < other.day + other.time.to_days) or else
					(day + time.to_days = other.day + other.time.to_days) and then
					(time.time_modulo_day < other.time.time_modulo_day)
			end
		ensure then
			non_definite_result: not (definite and other.definite) implies Result = False	
		end;

	is_equal (other: like Current): BOOLEAN is
			-- Are the current duration an `other' equal?
		do
			Result := year = other.year and then month = other.month and then
				(day + time.to_days = other.day + other.time.to_days) and then
				time.time_modulo_day.is_equal (other.time.time_modulo_day)
		end;

feature -- Status report

	definite: BOOLEAN is
			-- Is this duration date-independent?
			-- (True if it only uses `day', not `year' and `month')
		do
			Result:= date.definite
		ensure
			result_definition: Result = (year = 0 and then month = 0);
		end;

	canonical (start_date: DATE_TIME): BOOLEAN is
			-- Are the time and date parts of the same sign,
			-- and both canonical?
		local
			final_date: DATE_TIME
		do
			final_date := start_date + Current;
			if final_date >= start_date then
				Result := (date.canonical (start_date.date) and then
						time.seconds_count >= 0 and then time.canonical and then
						hour < Hours_in_day)
			else
				Result := (date.canonical (start_date.date) and then
						time.seconds_count <= 0 and then time.canonical and then
						hour > -Hours_in_day)
			end
		end;

feature -- Element Change

	set_date (d: DATE_DURATION) is
			-- Set `date' to `d'.
		require
			d_exists: d /= Void
		do
			date := d
		ensure
			date_set: date = d
		end;

	set_time (t: TIME_DURATION) is 
			-- Set `time' to `t'.
		require 
			t_exists: time /= Void
		do 
			time := t
		ensure 
			time_set: time = t 
		end;

feature -- Basic operations

	infix "+" (other:like current): like current is
			-- Sum with `other' (commutative)
		do
			!! Result.make_by_date_time (date + other.date, time + other.time)
		end;

	infix "-" (other:like current): like current is
			-- Difference with `other'
		do
			!! Result.make_by_date_time (date - other.date, time - other.time)
		end;

	prefix "+": like current is
			-- Unary plus
		do
			Result := Current
		end;

	prefix "-": like current is
			-- Unary minus
		do
			!! Result.make_by_date_time (-date, -time)
		end;

	day_add (d: INTEGER) is
			-- Add `d' days to the current duration.
		do
			date.set_day (day + d)
		ensure
			Result_definition: day = old day + d
		end;
	

feature -- Conversion

	to_canonical (start_date: DATE_TIME): like Current is
			-- A new duration, equivalent to current one 
			-- and canonical for `start_date' 
		local
			final_date: DATE_TIME;
			date_part_of_Result: DATE_DURATION
			time_part_of_Result: TIME_DURATION
		do
			if canonical (start_date) then
				Result := deep_clone (Current)
			else
				final_date := start_date + Current;
				!! time_part_of_Result.make_fine (final_date.hour - start_date.hour,
					final_date.minute - start_date.minute,
					final_date.fine_second - start_date.fine_second);
				if (final_date >= start_date) and then (final_date.time < start_date.time) then
					time_part_of_result.hour_add (24);
					final_date.day_add (-1)
				elseif (final_date < start_date) and then (final_date.time > start_date.time) then
					time_part_of_result.hour_add (-24);
					final_date.day_add (1)
				end;
				!! date_part_of_Result.make_by_days (final_date.days - start_date.days);
				!! Result.make_by_date_time (date_part_of_Result.to_canonical (start_date.date), time_part_of_Result.to_canonical)
			end
		ensure
			canonical_set: Result.canonical (start_date)
			duration_not_changed: (start_date + Current).is_equal (start_date + Result)
		end;

	time_to_canonical: like Current is
			-- A new duration, equivalent to current one
			-- but `time' is canonical and has the same sign as `date'
		require
			definite_duration: definite
		do
			Result := deep_clone (Current);
			if Current >= zero then
				if time < time.zero then
					Result.time.hour_add (- time.to_days * Hours_in_day)
				end;
				Result.day_add (time.to_days);
				Result.set_time (Result.time.time_modulo_day);
			else
				Result := - (- Result).time_to_canonical
			end;
		ensure
			time_canonical: Result.time.canonical;
			same_sign: ((Result.date > date.zero) implies (Result.time >= time.zero)) and then
				((Result.date < date.zero) implies (Result.time <= time.zero))
		end;
 
end -- class DATE_TIME_DURATION

--|--------------------------------------------------------------- 
--| EiffelTime: library of reusable components for ISE Eiffel 3. 
--| Copyright (C) 1995, Interactive Software Engineering Inc. 
--| All rights reserved. Duplication and distribution prohibited. 
--| 
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA 
--| Telephone 805-685-1006 
--| Fax 805-685-6869 
--| Electronic mail <info@eiffel.com> 
--| Customer support e-mail <support@eiffel.com> 
--|--------------------------------------------------------------- 
