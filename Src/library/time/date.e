indexing
	description: "absolute date"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	access: date, time

class
	DATE

inherit
	ABSOLUTE
		undefine
			out
		redefine
			infix "<"
		end;
	DATE_VALUE
		undefine
			is_equal
		end

creation
 
	make,
	make_month_day_year,
	make_day_month_year,
	make_now,
	make_by_days,
	make_from_string

feature -- Initialization

	make (y, m, d: INTEGER) is
			-- Set `year', `month' and `day' to `y', `m', `d' respectively.
		require
			month_large_enough: m >= 1;
			month_small_enough: m <= Months_in_year;
			day_large_enough: d >= 1;
			day_small_enough: d <= days_in_i_th_month (m, y)
		do
			year := y;
			month := m;
			day := d
		ensure
			year_set: year = y;
			month_set: month = m;
			day_set: day = d
		end;

	make_month_day_year (m, d, y: INTEGER) is
			-- Set `month', `day' and `year' to `m', `d' and `y' respectively.
		require
			month_large_enough: m >= 1;
			month_small_enough: m <= Months_in_year;
			day_large_enough: d >= 1;
			day_small_enough: d <= days_in_i_th_month (m, y)
		do
			make (y, m, d)
		ensure
			year_set: year = y;
			month_set: month = m;
			day_set: day = d
		end;

	make_day_month_year (d, m, y: INTEGER) is
			-- Set `day', `month' and `year' to `d', `m' and `y' respectively.
		do
			make (y, m, d)
		ensure
			year_set: year = y;
			month_set: month = m;
			day_set: day = d
		end;

	make_now is
			-- Set the current object to today's date.
		do
			c_get_date_time;
			year := c_year;
			month := c_month;
			day := c_day
		end;

	make_by_days (d: INTEGER) is
			-- Set the current date with the number of days `d' since `origin'.
		local
			i, j: INTEGER
		do
			i := 4 * (d - 59) - 1;
			j := (4 * div ((mod (i, 146097)), 4)) + 3;
			year := (100 * (div (i, 146097))) + (div (j, 1461));
			i := (5 * (div (((mod (j, 1461)) + 4), 4))) - 3;
			month := div (i, 153);
			day := div (((mod (i, 153)) + 5 ), 5);
			if month < 10 then
				month := month + 3
			else
				month := month - 9;
				year := year + 1
			end;
			year := year + 1600
		ensure
			days_set: days = d
		end;

	make_from_string(s:STRING) is
			-- initialise from a "standard" string of form
			-- "dd/mm/yyyy hh:mm:ss.sss".
		require
			s_exits: s /= Void;
			date_valid: date_valid(s)
		local
			 pos1, pos2, pos3, pos4:INTEGER
			 substrg1, substrg2, substrg3: STRING
	    do
			pos1 := s.index_of(Std_date_delim,1) 
			pos2 := s.index_of(Std_date_delim,pos1+1) 
			pos3 := s.index_of(Std_date_time_delim,1)
			pos4 := s.count+1
			substrg1:=s.substring(1, pos1-1)
			substrg2:=s.substring(pos1+1, pos2-1)
			if pos3/=0 then
				substrg3:=s.substring(pos2+1, pos3-1)
			else
				substrg3:=s.substring(pos2+1, pos4-1)
			end -- if
			make_day_month_year(substrg1.to_integer, substrg2.to_integer, substrg3.to_integer) 
	   end
		   
feature -- conditions
	date_valid(s: STRING): BOOLEAN is
			-- Has the substring the format "dd/mm/yyyy"?
		local
			pos1, pos2, pos3, pos4: INTEGER
			substrg1, substrg2, substrg3: STRING
		do
			pos1:=s.index_of(Std_date_delim,1)
			pos2:=s.index_of(Std_date_delim,pos1+1)
			pos3:=s.index_of(Std_date_time_delim,1)
			pos4:=s.count+1
			substrg1:=s.substring(1, pos1-1)
			substrg2:=s.substring(pos1+1, pos2-1)
			if pos3/=0 then
				substrg3:=s.substring(pos2+1, pos3-1)
			else
				substrg3:=s.substring(pos2+1, pos4-1)
			end
			Result:=s.item(pos1)=Std_date_delim and s.item(pos1+3)=Std_date_delim and substrg1.is_integer and substrg2.is_integer and substrg3.is_integer; 
		end
feature -- Access

	origin: DATE is
			-- Origin date
		once
			!! Result.make (1600, 1, 1)
		end;

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is the current date before `other'?
		do
			Result := year < other.year or else
				(year = other.year and then
				(month < other.month or else
				(month = other.month and then
				(day < other.day))))
		end;

feature -- Measurement

	duration: DATE_DURATION is
			-- Definite duration elapsed since `origin'
		do
			!! Result.make_by_days (days_from (origin.year) + year_day - origin.year_day)
		ensure then
			definite_result: Result.definite
			duration_set: ((Current - origin).duration).is_equal (Result)
		end;

	days: INTEGER is
			-- Number of days elapsed since `origin'
		do
			Result := days_from (origin.year) + year_day - origin.year_day
		ensure
			same_duration: Result = duration.day
		end;

feature -- Status report

	leap_year: BOOLEAN is
			-- Is the current year a leap year?
		do
			Result := i_th_leap_year (year)
		end;

	days_in_month: INTEGER is
			-- Number of days in the current month
		do
			Result := days_in_i_th_month (month, year)
		ensure
			positive_result: Result > 0
		end;

	days_at_month: INTEGER is
			-- Number of days from the beginning of the year
			-- until the beginning of the current month
		do
			Result := days_at_months @ month;
			if leap_year and then month > 2 then
				Result := Result +1
			end
		ensure
			positive_result: Result >= 0
		end;
		
	year_day: INTEGER is
			-- Number of days from the beginning of the year
		do
			Result := days_at_month + day 
		ensure
			result_large_enough: Result >= 1
			result_small_enough: Result <= days_in_year
		end;

	week_of_year: INTEGER is
			-- Number of weeks from the beginning of the year
			-- The first week of the year begins on the first sunday of the year
			-- The week number before the first sunday of the year is 0
		do
			if day_of_the_week <= year_day then
				if day_of_january_1st > 0 then
					Result := div (year_day - day_of_the_week, days_in_week) + 1
				else
					Result := div (year_day - day_of_the_week + day_of_january_1st - 1, days_in_week)
				end
			else
				Result := 0
			end
		ensure
			positive_result: Result >= 0;
			Result_small_enough: Result < Max_weeks_in_year	
		end;

	days_in_year: INTEGER is
			-- Number of days in the current year
		do
			if leap_year then
				Result := days_in_leap_year
			else
				Result := days_in_non_leap_year
			end
		ensure
			valid_result: (leap_year implies Result = days_in_leap_year) and then
				(not leap_year implies Result = days_in_non_leap_year)
		end;

	day_of_the_week: INTEGER is
			-- Number of day from the beginning of the week
			-- sunday is 1, etc.., saturday is 7
		do
			Result := mod (days - 1, 7) + 1
		ensure
			day_of_the_week_range: Result > 0 and then Result < 8
		end;

	day_of_january_1st: INTEGER is
			-- Day of the week of january 1st of the current year
		local
			january_1st: DATE
		do
			!! january_1st.make (year,1,1);
			Result := january_1st.day_of_the_week 
		ensure
			day_of_the_week_definition: Result > 0 and then Result < 8
		end;

	days_from (y: INTEGER): INTEGER is
			-- Days between the current year and year `y'
		do
			Result := (year - y) * days_in_non_leap_year +
				(div(year - 1, 4) - div(y - 1, 4)) -
				(div(year - 1,100) - div(y - 1,100)) +
				(div(year - 1,400) - div(y - 1,400))
		end

feature -- Element change

	set_day (d: INTEGER) is
			-- Set `day' to `d'.
		require
			d_large_enough: d >= 1;
			d_small_enough: d <= days_in_month
		do
			day := d
		ensure
			day_set: day = d
		end;

	
	set_month (m: INTEGER) is
			-- Set `month' to `m'.
			-- `day' must be small enough.
		require
			m_large_enough: m >= 1;
			m_small_enough: m <= Months_in_year;
			d_small_enough: day <= days_in_i_th_month (m, year)
		do
			month := m
		ensure
			month_set: month = m
		end;
	
	set_year (y: INTEGER) is
			-- Set `year' to `y'.
		require
			can_not_cut_29th_feb: day <= days_in_i_th_month (month, y)
		do
			year := y
		ensure
			year_set: year = y
		end;

feature -- Conversion

	to_date_time: DATE_TIME is
			-- Date-time version, with a zero time component
		do
			!! Result.make_by_date (Current)
		end;

feature -- Basic operations

	infix "+" (d: DATE_DURATION): DATE is
			-- Sum to current date the duration `d'
			-- if duration not define, add years and then months and then days.
		do
			Result := deep_clone (Current);
			Result.add (d)
		ensure
			result_exists: Result /= Void;
			definite_set: d.definite implies (Result - Current).duration.is_equal (d)
		end;

	add (d: DATE_DURATION) is
			-- Adds `d' to the current date.
			-- if `d' is not definite, add years and months and then days.
		do
			if d.definite then
				day_add (d.day)
			else
				year_month_add (d.year, d.month);
				day_add (d.day)
			end
		end;

	relative_duration (other: like Current): DATE_DURATION is
			-- Duration from `other' to the current date, expressed in year, month and day
		do
			!! Result.make_by_days (days - other.days);
			Result := Result.to_canonical (other)
		ensure then
			exact_duration: (other + Result).is_equal (Current);
			canonical_duration: Result.canonical (other)
		end;

	day_forth is
			-- Move to next day.
			-- days is from the origin, day is current.
		do
			if day = days_in_month then
				day := 1;
				month_forth
			else
				day := day + 1
			end
		ensure
			days_set: days = old days + 1
		end;

	day_back is
			-- Move to previous day.
		do
			if day = 1 then
				month_back;
				day := days_in_month
			else
				day := day - 1
			end
		ensure
			days_set: days = old days - 1
		end;

	day_add (d: INTEGER) is
			-- Add `d' days to the current date.
		do
			make_by_days (days + d)
		ensure
			days_set: days = old days + d
		end

	month_forth is
			-- Move to next month.
			-- Can move days backward if next month has less days than the current month.
		do
			if month = Months_in_year then
				month := 1;
				year_forth
			else
				month := month + 1
				if day > days_in_month then
					day := days_in_month
				end
			end
		end;

	month_back is
			-- Move to previous month.
			-- Can move days backward if previous month has less days than the current month.
		do
			if month = 1 then
				month := Months_in_year;
				year_back
			else
				month := month - 1;
				if day > days_in_month then
					day := days_in_month
				end
			end
		end;

	month_add (m: INTEGER) is
			-- add `m' months to the current date.
			-- Can move days backward.
		do
			year := year + div ((month + m - 1), Months_in_year);
			month := mod ((month + m - 1), Months_in_year) + 1;
			if day > days_in_month then
				day := days_in_month
			end
		end;

	year_forth is
			-- Move to next year.
			-- May cut the 29th february.
		do
			if day > days_in_i_th_month (month, year + 1) then
				day := days_in_i_th_month (month, year + 1)
			end;	
			year := year + 1
		
		ensure
			year_increased: year = old year + 1
		end;

	year_back is
			-- Move to previous year.
			-- May cut the 29th february.
		do
			if day > days_in_i_th_month (month, year - 1) then
				day := days_in_i_th_month (month, year - 1)
			end;	
			year := year - 1
		ensure
			year_decreased: year = old year - 1
		end;

	year_add (y: INTEGER) is
			-- Add `y' years to the current date.
			-- May cut the 29th february.
		do
			if day > days_in_i_th_month (month, year + y) then
				day := days_in_i_th_month (month, year + y)
			end;	
			year := year + y
		ensure
			year_set: year = old year + y
		end;

	year_month_add (y, m: INTEGER) is
			-- Add `y' years and `m' months to the current date.
			-- Check the number of days after.
		do
			month_add (y * Months_in_year + m)
		end;

feature {NONE} -- Implementation

	days_at_months: ARRAY [INTEGER] is
			-- Array containing number of days from the end of
			-- the year to each month of a non-leap year
		once
			Result := <<0, 31, 59, 90, 120, 151, 181, 212, 243,
				273, 304, 334>>
		ensure
			result_exists: Result /= Void;
			count_is_months_in_year: Result.count = Months_in_year
		end;

	c_get_date_time is
			-- get the date from the intern clock
			-- and save it in a local variable.
		external
			"C"
		end;
	
	c_year: INTEGER is
			-- Current year recorded by c_get_date_time.
			-- Has to be checked after 2000.
		external 
			"C"
		end

	c_month: INTEGER is
			-- Current month recorded by c_get_date_time.
		external
			"C"
		end;

	c_day: INTEGER is
			-- Current day recorded by c_get_date_time.
		external
			"C"
		end;

invariant

	day_large_enough: day >= 1;
	day_small_enough: day <= days_in_month;
	month_large_enough: month >= 1;
	month_small_enough: month <= Months_in_year;

end -- class DATE


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


