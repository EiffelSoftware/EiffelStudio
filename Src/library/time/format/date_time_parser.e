indexing
	description: "Parser facility for dates and times" 
	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class DATE_TIME_PARSER inherit

	DATE_VALIDITY_CHECKER
		rename
			year as checker_year, month as checker_month,
			day as checker_day
		export
			{NONE} all
		end

	TIME_VALIDITY_CHECKER
		rename
			hour as checker_hour, minute as checker_minute, 
			fine_second as checker_fine_second
		export
			{NONE} all
		end

	DATE_TIME_VALIDITY_CHECKER
		export
			{NONE} all
		end

	FIND_SEPARATOR_FACILITY

create

	make

feature {NONE} -- Initialization

	make (c: HASH_TABLE [DATE_TIME_CODE, INTEGER]; 
			m, d: ARRAY [STRING];
			b: INTEGER) is
			-- Create parser with date/time code `c', months array `m',
			-- days array `d', and base century `b'.
		require
			code_exists: c /= Void
			months_exist: m /= Void
			days_exist: d /= Void
			base_century_valid: b > 0 and (b \\ 100 = 0)
		do
			code := c
			months := m
			days := d
			base_century := b
		ensure
			code_set: code = c
			months_set: months = m
			days_set: days = d
			base_century_set: base_century = b
		end
		
feature -- Access

	source_string: STRING
			-- String to be parsed

	year: INTEGER is
			-- Year part of `source_string'
		require
			value_parsed: parsed
		do
			Result := year_val
		end

	month: INTEGER is
			-- Month part of `source_string'
		require
			value_parsed: parsed
		do
			Result := month_val
		end

	day: INTEGER is
			-- Day part of `source_string'
		require
			value_parsed: parsed
		do
			Result := day_val
		end

	hour: INTEGER is
			-- Hour part of `source_string'
		require
			value_parsed: parsed
		do
			Result := hour_val
		end

	minute: INTEGER is
			-- Minute part of `source_string'
		require
			value_parsed: parsed
		do
			Result := minute_val
		end

	fine_second: DOUBLE is
			-- Seconds part of `source_string'
		require
			value_parsed: parsed
		do
			Result := fine_second_val
		end

	day_text: STRING is
			-- Text representation of `day'
		require
			value_parsed: parsed
		do
			Result := day_text_val
		end

feature -- Status report

	parsed: BOOLEAN
			-- Has `source_string' been parsed?

	is_source_set: BOOLEAN is
			-- Has `source_string' been set?
		do
			Result := source_string /= Void and then not source_string.empty
		end

	is_date: BOOLEAN is
			-- Does `source_string' contain a DATE?
		require
			string_parsed: parsed
		do
			Result := is_correct_date (year, month, day)
		end

	is_time: BOOLEAN is
			-- Does `source_string' contain a TIME?
		require
			string_parsed: parsed
		do
			Result := is_correct_time (hour, minute, fine_second)
		end

	is_date_time: BOOLEAN is
			-- Does `source_string' contain a DATE_TIME?
		require
			string_parsed: parsed
		do
			Result := is_correct_date_time (year, month, day, hour,
				minute, fine_second)
		end

	is_value_valid: BOOLEAN is
			-- Is parsed value valid?
		do
			Result := parsed and then (is_date or is_time or is_date_time)
		end

feature -- Status setting

	set_source_string (s: STRING) is
			-- Assign `s' to `source_string'.
		require
			non_empty_string: s /= Void and then not s.empty
		do
			source_string := s
			parsed := False
		ensure
			source_set: source_string = s
			not_parsed: not parsed
		end

feature -- Basic operations

	parse is
			-- Parse `source_string'.
		require
			source_set: is_source_set
		local
			substrg: STRING
			pos1, pos2, i, j: INTEGER
			type: INTEGER
			second_val: INTEGER
			s: STRING
		do
			s := clone (source_string)
			s.to_upper
			year_val := 1
			month_val := 1
			day_val := 1
			hour_val := 0
			minute_val := 0
			fine_second_val := 0
			pos1 := 1
			pos2 := 1
			from 
				i := 1
			until 
				pos1 > s.count
			loop
				pos2 := find_separator (s, pos1)
				substrg := s.substring (pos1, pos2-1)
				if substrg.is_equal ("AM") or substrg.is_equal ("PM") then
					pos1 := pos2 + 1
				else
					if code.item (i) = Void then
						pos1 := s.count + 1
					else
						type := code.item (i).type
						inspect
							type
						when 1, 2 then
							day_val := substrg.to_integer
						when 3 then
							day_text_val := substrg
						when 4 then
							year_val := substrg.to_integer
						when 5 then 
							year_val := substrg.to_integer + base_century
						when 6, 7 then
							month_val := substrg.to_integer
						when 8 then
							from
								j := 1
							until 
								j > 12
							loop
								if months.item (j).is_equal (substrg) then
									month_val := j
								else
									-- error
								end
								j := j + 1
							end
						when 9, 10 then
							hour_val := substrg.to_integer
						when 11 then
							if s.substring_index ("PM", 1) /= 0 then
								hour_val := substrg.to_integer + 12
								if hour_val = 24 then 
									hour_val := 12
								end
							elseif s.substring_index ("AM", 1) /= 0 then
								hour_val := substrg.to_integer
								if hour_val = 12 then
									hour_val := 0
								end
							else
								-- If no pm or am the am by default.
								hour_val := substrg.to_integer
								if hour_val = 12 then
									hour_val := 0
								end
							end
						when 12, 13 then 
							minute_val := substrg.to_integer
						when 14, 15 then
							second_val := substrg.to_integer
						when 16 then
							fine_second_val := substrg.to_double / 
								(10 ^ (substrg.count))
						end
						i := i + 2
						pos1 := pos2 + 1
					end
				end
			end
			fine_second_val := fine_second_val + second_val
			parsed := True
		ensure
			string_parsed: parsed
		end

feature {NONE} -- Implementation

	year_val: INTEGER

	month_val: INTEGER

	day_val: INTEGER

	hour_val: INTEGER

	minute_val: INTEGER

	fine_second_val: DOUBLE

	day_text_val: STRING

	code: HASH_TABLE [DATE_TIME_CODE, INTEGER]
			-- Hash table containing the parsed date/time code

	months: ARRAY [STRING]
			-- Names of months
			
	days: ARRAY [STRING]
			-- Names of days	

	base_century: INTEGER
			-- Base century, used when interpreting 2-digit year
			-- specifications.
			
invariant

	valid_value_definition: is_value_valid =
			parsed and then (is_date or is_time or is_date_time)
	valid_value_implies_parsing: is_value_valid implies parsed
	
end -- class DATE_TIME_PARSER

--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
