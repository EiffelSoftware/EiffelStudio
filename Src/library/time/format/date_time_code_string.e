indexing
	description: "DATE/TIME to STRING conversion";
	date: "$Date$";
	revision: "$Revision$"

class DATE_TIME_CODE_STRING	inherit

	FIND_SEPARATOR_FACILITY

create
	make

feature -- Creation

	make (s: STRING) is
			-- Create code descriptors and hash-table from `s'.
		require
			s_exists: s /= Void
		local
			code, code_separator: DATE_TIME_CODE
			i, pos1, pos2: INTEGER
			substrg, substrg2, tmp_strg: STRING
			date_constants: DATE_CONSTANTS
		do
			create value.make(20)
			pos1 := 1
			pos2 := 1
			create date_constants
			days := clone (date_constants.days_text)
			months := clone (date_constants.months_text)
			from
				i := 1
			until
				pos1 >= s.count 
			loop
				pos2 := find_separator (s, pos1)
				substrg := s.substring(pos1, pos2 - 1)
				substrg2 := s.substring (pos2, pos2)
				substrg.to_lower
				if substrg = "pm" or tmp_strg = "am" then
					pos1 := s.count + 1
				else
					if substrg.count > 0 then
						create code.make (substrg)
						value.put (code, i)
						i := i + 1
					end
					if substrg2.count > 0 then
						create code_separator.make (substrg2)
						value.put (code_separator, i)
					end
					pos1 := pos2 + 1
					i := i + 1
				end
			end
			base_century := c_year_now // 100 * -100
				-- A negative value of `base_century' indicates that it has
				-- been calculated automatically, therefore '* -100'.
		ensure
			value_set: value /= Void
			base_century_set: base_century < 0 and (base_century \\ 100 = 0)
		end

feature -- Attributes

	value: HASH_TABLE [DATE_TIME_CODE, INTEGER]
			-- Hash-table representing the code string.

	name: STRING is
			-- Name of the code string.
		local
			i: INTEGER
		do	
			create Result.make (1)
			from
				i := 1
			until
				value.item(i) = Void
			loop
				Result.append (value.item(i).name)
				Result.append(" ")
				i := i + 1
			end
		end

	base_century: INTEGER
			-- Base century, used when interpreting 2-digit year
			-- specifications.
			
feature -- Status report

	is_date (s: STRING): BOOLEAN is
			-- Does `s' contain a DATE?
		require
			non_empty_string: s /= Void and then not s.empty
		do
			build_parser (s)
			Result := parser.is_date
		end

	is_time (s: STRING): BOOLEAN is
			-- Does `s' contain a TIME?
		require
			non_empty_string: s /= Void and then not s.empty
		do
			build_parser (s)
			Result := parser.is_time
		end	

	is_date_time (s: STRING): BOOLEAN is
			-- Does `s' contain a DATE_TIME?
		require
			non_empty_string: s /= Void and then not s.empty
		do
			build_parser (s)
			Result := parser.is_date_time
		end

	is_value_valid (s: STRING): BOOLEAN is
			-- Does `s' contain a valid date or time as string representation?
		require
			non_empty_string: s /= Void and then not s.empty
		do
			build_parser (s)
			Result := parser.is_date or parser.is_time or parser.is_date_time
		end

feature -- Status setting

	set_base_century (c: INTEGER) is
			-- Set base century to `c'.
		require
			base_valid: c > 0 and (c \\ 100 = 0)
		do
			base_century := c
		ensure
			base_century_set: base_century = c
		end

feature -- Interface

	correspond (s: STRING): BOOLEAN is
			-- Does the user string `s' correspond to the code string?
		require
			s_exists: s /= Void
		local
			pos1, pos2, i: INTEGER
			substrg, substrg2, tmp_strg: STRING
			code: DATE_TIME_CODE
		do
			pos1 := 1
			pos2 := 1

			if s.count = 0 then
				Result := False
			else
				Result := True
			end
			from
				i := 1
			until
				pos1 > s.count
				or Result = False
			loop
				pos2 := find_separator (s, pos1)
				substrg := s.substring(pos1, pos2-1)
				substrg2 := s.substring (pos2, pos2)
				tmp_strg := substrg
				tmp_strg.to_upper
				if tmp_strg.is_equal ("PM") or tmp_strg.is_equal ("AM") then
					pos1 := s.count + 1
					am_pm_index := pos1
					pos1 := pos2 + 1
				else
					code := value.item (i)
					Result := substrg.count <= code.count_max and substrg.count >= code.count_min
					if code.is_numeric then
						Result := Result and substrg.is_integer
						if code.value_max /= -1 and code.value_min /= -1 then
							Result := Result and 
								substrg.to_integer <= code.value_max and
								substrg.to_integer >= code.value_min
						end
					else
						if code.is_day_text (code.value) then 
							Result := Result and days.has (tmp_strg)
						else
							Result := Result and months.has (tmp_strg)
						end
					end
					code := value.item (i+1)
					if code /= Void then
						Result := Result and (pos2 /= s.count) and 
							substrg2.is_equal (code.value)
					end
					pos1 := pos2 + 1
					i := i + 2
				end
			end
		end	

	create_string (date_time: DATE_TIME): STRING is
			-- Create the output of `date_time' according to the code string.
		require
			non_void: date_time /= Void
		local
			date: DATE
			time: TIME
			int, i, type: INTEGER
			double: DOUBLE
			am_pm: STRING
		do
			create Result.make (1)
			am_pm := ""
			date := date_time.date
			time := date_time.time
			from 
				i := 1
			until
				value.item (i) = Void
			loop
				type := value.item(i).type
				inspect
					type
				when 1 then
					Result.append (date.day.out)
				when 2 then
					int := date.day
					if int < 10 then
						Result.append ("0")
					end
					Result.append (int.out)
				when 3 then
					int := date.day_of_the_week
					Result.append (days.item (int))
				when 4 then
					-- Test if the year has four digits, if not put 0 to fill it
					if date.year.out.count = 4 then
						Result.append(date.year.out)
					else
						if date.year.out.count = 1 then
							Result.append ("000")
							Result.append(date.year.out)
						end
						if date.year.out.count = 2 then
							Result.append ("00")
							Result.append(date.year.out)
						end
						if date.year.out.count =3 then
							Result.append("0")
							Result.append(date.year.out)
						end
					end
				when 5 then 
					int := date.year - 1900
					Result.append (int.out)
				when 6 then
					Result.append (date.month.out)
				when 7 then
					int := date.month
					if int < 10 then
						Result.append ("0")
					end
					Result.append (int.out)
				when 8 then
					int := date.month
					Result.append (months.item (int))
				when 9 then
					Result.append (time.hour.out)
				when 10 then
					int := time.hour
					if int < 10 then
						Result.append ("0")
					end
					Result.append (int.out)
				when 11 then
					int := time.hour
					if int < 12 then
						am_pm := " AM"
						if int = 0 then
							int := 12
						end
					else
						am_pm := " PM"
						if int /= 12 then 
							int := int - 12
						end
					end
					Result.append (int.out)
				when 12 then 
					Result.append (time.minute.out)
				when 13 then
					int := time.minute
					if int < 10 then
						Result.append ("0")
					end
					Result.append (int.out)
				when 14 then
					Result.append (time.second.out)
				when 15 then
					int := time.second
					if int < 10 then
						Result.append ("0")
					end
					Result.append (int.out)
				when 16 then
					double := time.fractional_second * 
						10^(value.item(i).count_max)
					int := double.truncated_to_integer
					Result.append (int.out)
				else
					Result.append (value.item(i).value)
				end
			i := i + 1
			end
			if am_pm_index /= 0 then
				Result.insert (am_pm, am_pm_index - 1)
			else
				Result.append (am_pm)
			end
		ensure
			string_exists: Result /= Void
			string_correspond: correspond (Result)
		end	
	
	create_date_string (date: DATE): STRING is
				-- Create the output of `date' according to the code string.
		require
			date_exists: date /= Void
		local
			date_time: DATE_TIME
		do
			create date_time.make_by_date (date)
			Result := create_string (date_time)
		ensure
			string_exists: Result /= Void
			string_correspond: correspond (Result)
		end

	create_time_string (time: TIME): STRING is
				-- Create the output of `time' according to the code string.
		require
			time_exists: time /= Void
		local
			date_time: DATE_TIME
		do
			create date_time.make_fine (1, 1, 1, time.hour, time.minute, 
				time.fine_second)
			Result := create_string (date_time)
		ensure
			string_exists: Result /= Void
			string_correspond: correspond (Result)
		end

	create_date_time (s: STRING): DATE_TIME is
			-- Create DATE_TIME according to `s'.
		require
			s_exist: s /= Void
			is_precise: precise
			s_correspond: correspond (s)
			valid: is_value_valid (s)
		local
			i: INTEGER
		do
			right_day_text := True
			build_parser (s)
			create Result.make_fine (parser.year, parser.month, parser.day, 
					parser.hour, parser.minute, parser.fine_second)
			if parser.day_text /= Void then
				i := Result.date.day_of_the_week
				right_day_text := parser.day_text.is_equal (days.item (i))
			end
		ensure
			date_time_exists: Result /= Void
			day_text_equal_day: right_day_text
		end

	create_date (s: STRING): DATE is
			-- Create a DATE according to the format in `s'.
		require
			s_exists: s /= Void
			is_precise: precise_date
			s_correspond: correspond (s)
		local
			tmp_code: DATE_TIME_CODE
			tmp_ht: HASH_TABLE [DATE_TIME_CODE,INTEGER]
			i: INTEGER
		do
			tmp_ht := clone (value)
			i := value.count + 1
			create tmp_code.make (" ")
			value.put (tmp_code, i)
			create tmp_code.make ("hh")
			value.put (tmp_code, i+1)
			create tmp_code.make (":")
			value.put (tmp_code, i+2)
			create tmp_code.make ("mi")
			value.put (tmp_code, i+3)
			create tmp_code.make (":")
			value.put (tmp_code, i+4)
			create tmp_code.make ("ss")
			value.put (tmp_code, i+5)
			s.append (" 0:0:0")
			Result := create_date_time (s).date
			s.replace_substring_all (" 0:0:0", "")
			value := tmp_ht
		ensure
			date_exists: Result /= Void
			day_text_equal_day: right_day_text
		end

	create_time (s: STRING): TIME is
			-- Create a TIME according to the format in `s'.
		require
			s_exists: s /= Void
			is_precise: precise_time
			s_correspond: correspond (s)
		local
			tmp_code: DATE_TIME_CODE
			tmp_ht: HASH_TABLE [DATE_TIME_CODE,INTEGER]
			i: INTEGER
		do
			tmp_ht := clone (value)
			i := value.count + 1
			create tmp_code.make (" ")
			value.put (tmp_code, i)
			create tmp_code.make ("dd")
			value.put (tmp_code, i+1)
			create tmp_code.make ("/")
			value.put (tmp_code, i+2)
			create tmp_code.make ("mm")
			value.put (tmp_code, i+3)
			create tmp_code.make ("/")
			value.put (tmp_code, i+4)
			create tmp_code.make ("yy")
			value.put (tmp_code, i+5)
			s.append (" 1/1/01")
			Result := create_date_time (s).time
			s.replace_substring_all (" 1/1/01", "")
			value := tmp_ht
		ensure
			time_exists: Result /= Void
			time_correspond: create_time_string (Result).is_equal (s)
		end


	precise: BOOLEAN is
			-- Is the code string enough precise to create
			-- nn instance of type DATE_TIME?
		require
			not_void: value /= Void
		do
			Result := precise_date and precise_time
		end

	precise_date: BOOLEAN is
			-- Is the code string enough precise to create
			-- nn instance of type DATE?
		require
			not_void: value /= Void
		local
			code: DATE_TIME_CODE
			i, type: INTEGER
			has_day, has_month, has_year: BOOLEAN
		do
			from 
				i := 1
			until 
				value.item (i) = Void
			loop
				code := clone (value.item (i))
				type := code.type
				inspect
					type
				when 1, 2 then
					has_day := True
				when 4, 5 then
					has_year := True
				when 6, 7, 8 then
					has_month := True
				else
					-- Has_day, has_year and has_month not modified.
				end
				i := i + 1
			end
			Result := has_day and has_month and has_year
		end

	precise_time: BOOLEAN is
			-- Is the code string enough precise to create
			-- an instance of type TIME?
		require
			not_void: value /= Void
		local
			code: DATE_TIME_CODE
			i, type: INTEGER
			has_hour, has_minute, has_second: BOOLEAN
		do
			from 
				i := 1
			until 
				value.item (i) = Void
			loop
				code := clone (value.item (i))
				type := code.type
				inspect
					type
				when 9, 10, 11 then
					has_hour := True
				when 12, 13 then
					has_minute := True
				when 14, 15 then
					has_second := True
				else
					-- Has_hour, has_minute, has_second not modified.
				end
				i := i + 1
			end
			Result := has_hour and has_minute and has_second
		end
	
feature {NONE} -- Externals

	c_year_now: INTEGER is
			-- Today's year
		external
			"C"
		end

feature {NONE} -- Implementation
		
	parser: DATE_TIME_PARSER
			-- Instance of date-time string parser

	build_parser (s: STRING) is
			-- Build parser from `s'.
		require
			non_empty_string: s /= Void and then not s.empty
		do
			if parser = Void or else not equal (parser.source_string, s) then
				create parser.make (value)
				parser.set_day_array (days)
				parser.set_month_array (months)
				parser.set_base_century (base_century)
				parser.set_source_string (s)
				parser.parse
			end
		ensure
			parser_created: parser /= Void
		end

	days: ARRAY [STRING]

	months: ARRAY [STRING]	

	right_day_text: BOOLEAN
			-- Is the name of the day the right one?

	am_pm_index: INTEGER 
			-- Index of the am/pm notation

end -- class DATE_TIME_CODE_STRING

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
