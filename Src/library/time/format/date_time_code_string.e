indexing
	description: "DATE/TIME to STRING conversion";
	date: "$Date$";
	revision: "$Revision$"

class 
	DATE_TIME_CODE_STRING	

creation
	make

feature -- Creation

	make (s: STRING) is
			-- Create code descriptors and hash-table.
		require
			s_exists: s /= Void
		local
			code, code_separator: DATE_TIME_CODE
			i, pos1, pos2: INTEGER
			substrg, substrg2, tmp_strg: STRING
			date_constants: DATE_CONSTANTS
		do
			!! value.make(20)
			pos1 := 1
			pos2 := 1
			!! date_constants
			days := clone (date_constants.days_text)
			months := clone (date_constants.months_text)
			from
				i := 1
			until
				pos1 >= s.count 
			loop
				pos2 := find_separator (s, pos1)
				substrg := s.substring(pos1, pos2-1)
				substrg2 := s.substring (pos2, pos2)
				substrg.to_lower
			--	if substrg = "pm" or tmp_strg = "am" then
			--		pos1 := s.count + 1
			--	else
					!! code.make (substrg)
					value.put (code, i)
					i := i + 1
					if not substrg2.is_equal("") then
						!! code_separator.make (substrg2)
						value.put (code_separator, i)
					end
					pos1 := pos2 + 1
					i := i + 1
			--	end
			end
		ensure
			value_set: value /= Void	
		end

feature -- Attributes

	value: HASH_TABLE [DATE_TIME_CODE,INTEGER]
			-- Hash-table representing the code string.

	name: STRING is
			-- Name of the code string.
		local
			i: INTEGER
		do	
			!! Result.make (1)
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

feature -- Interface

	correspond (s: STRING): BOOLEAN is
			-- Does the user string correspond to the code string?
		require
			s_exists: s /= Void
		local
			pos1, pos2, i: INTEGER
			substrg, substrg2, tmp_strg: STRING
			code: DATE_TIME_CODE
		do
			pos1 := 1
			pos2 := 1
			Result := True
			from
				i := 1
			until
				pos1 >= s.count
				or Result = False
			loop
				pos2 := find_separator (s, pos1)
				substrg := s.substring(pos1, pos2-1)
				substrg2 := s.substring (pos2, pos2)
				tmp_strg := substrg
				tmp_strg.to_upper
				if tmp_strg.is_equal ("PM") or tmp_strg.is_equal ("AM") then
				--	pos1 := s.count + 1
					am_pm_index := pos1
					pos1 := pos2 + 1
				else
					code := value.item (i)
					Result := substrg.count <= code.count_max and substrg.count >= code.count_min
					if code.is_numeric then
						Result := Result and substrg.is_integer
						if code.value_max /= -1 and code.value_min /= -1 then
							Result := Result and substrg.to_integer <= code.value_max and
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
						Result := Result and substrg2.is_equal (code.value)
					end
					pos1 := pos2 + 1
					i := i + 2
				end
			end
		end	

	create_string (date_time: DATE_TIME): STRING is
			-- Create the output of date_time according to the code string.
		require
			date_time /= Void
		local
			date: DATE
			time: TIME
			int, i, type: INTEGER
			double: DOUBLE
			am_pm: STRING
		do
			!! Result.make (1)
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
					Result.append (date.year.out)
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
					double := time.fractionnal_second * 10^(value.item(i).count_max)
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
					-- Create the output of date according to the code string.
		require
			date_exists: date /= Void
		local
			date_time: DATE_TIME
		do
			!! date_time.make_by_date (date)
			Result := create_string (date_time)
		ensure
			string_exists: Result /= Void
			string_correspond: correspond (Result)
		end

	create_time_string (time: TIME): STRING is
					-- Create the output of time according to the code string.
		require
			time_exists: time /= Void
		local
			date_time: DATE_TIME
		do
			!! date_time.make_fine (1, 1, 1, time.hour, time.minute, time.fine_second)
			Result := create_string (date_time)
		ensure
			string_exists: Result /= Void
			string_correspond: correspond (Result)
		end

	create_date_time (s: STRING): DATE_TIME is
			-- Create the DATE_TIME according to s.
		require
			s_exist: s /= Void
			is_precise: precise
			s_correspond: correspond (s)
		local
			year, month, day, hour, minute, second: INTEGER
			fine_second: DOUBLE
			substrg, day_text: STRING
			pos1, pos2, i, j: INTEGER
			type: INTEGER
		do
			s.to_upper
			year := 1
			month := 1
			day := 1
			hour := 0
			minute := 0
			fine_second := 0
			pos1 := 1
			pos2 := 1
			right_day_text := True
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
					if value.item (i) = Void then
						pos1 := s.count + 1
					else
						type := value.item(i).type
						inspect
							type
						when 1, 2 then
							day := substrg.to_integer
						when 3 then
							day_text := substrg
						when 4 then
							year := substrg.to_integer
						when 5 then 
							year := substrg.to_integer + 1900
						when 6, 7 then
							month := substrg.to_integer
						when 8 then
							from
								j := 1
							until 
								j > 12
							loop
								if months.item (j).is_equal (substrg) then
									month := j
								else
									--error
								end
								j := j + 1
							end
						when 9, 10 then
							hour := substrg.to_integer
						when 11 then
							if s.substring_index("PM", 1) /= 0 then
								hour := substrg.to_integer + 12
								if hour = 24 then 
									hour := 12
								end
							elseif s.substring_index("AM", 1) /= 0 then
								hour := substrg.to_integer
								if hour = 12 then
									hour := 0
								end
							else
								-- If no pm or am the am by default.
								hour := substrg.to_integer
								if hour = 12 then
									hour := 0
								end
							end
						when 12, 13 then 
							minute := substrg.to_integer
						when 14, 15 then
							second := substrg.to_integer
						when 16 then
							fine_second := substrg.to_double / (10^(substrg.count))
						end
						i := i + 2
						pos1 := pos2+1
					end
				end
			end
			fine_second := fine_second + second	
			!! Result.make_fine (year, month, day, hour, minute, fine_second)
			if day_text /= Void then
				i := Result.date.day_of_the_week
				right_day_text := day_text.is_equal (days.item (i))
			end
		ensure
			date_time_exists: Result /= Void
			day_text_equal_day: right_day_text
			date_time_correspond: create_string (Result).is_equal (s)
		end

	create_date (s: STRING): DATE is
			-- Create a DATE according to the string s format
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
			!! tmp_code.make (" ")
			value.put (tmp_code, i)
			!! tmp_code.make ("hh")
			value.put (tmp_code, i+1)
			!! tmp_code.make (":")
			value.put (tmp_code, i+2)
			!! tmp_code.make ("mi")
			value.put (tmp_code, i+3)
			!! tmp_code.make (":")
			value.put (tmp_code, i+4)
			!! tmp_code.make ("ss")
			value.put (tmp_code, i+5)
			s.append (" 0:0:0")
			Result := create_date_time (s).date
			s.replace_substring_all (" 0:0:0", "")
			value := tmp_ht
		ensure
			date_exists: Result /= Void
			day_text_equal_day: right_day_text
			date_correspond: create_date_string (Result).is_equal (s)
		end

	create_time (s: STRING): TIME is
			-- Create a TIME according to the string s format.
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
			!! tmp_code.make (" ")
			value.put (tmp_code, i)
			!! tmp_code.make ("dd")
			value.put (tmp_code, i+1)
			!! tmp_code.make ("/")
			value.put (tmp_code, i+2)
			!! tmp_code.make ("mm")
			value.put (tmp_code, i+3)
			!! tmp_code.make ("/")
			value.put (tmp_code, i+4)
			!! tmp_code.make ("yy")
			value.put (tmp_code, i+5)
			s.append (" 1/1/1")
			Result := create_date_time (s).time
			s.replace_substring_all (" 1/1/1", "")
			value := tmp_ht
		ensure
			time_exists: Result /= Void
			time_correspond: create_time_string (Result).is_equal (s)
		end


	precise: BOOLEAN is
			-- Is the code string enough precise to create
			-- An instance of type DATE_TIME?
		require
			not_void: value /= Void
		do
			Result := precise_date and precise_time
		end

	precise_date: BOOLEAN is
			-- Is the code string enough precise to create
			-- An instance of type DATE?
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
					-- Has_day, has_year and has_month no modified.
				end
				i := i + 1
			end
			Result := has_day and has_month and has_year
		end

	precise_time: BOOLEAN is
			-- Is the code string enough precise to create
			-- An instance of type TIME?
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
	
feature {NONE}
		
	find_separator (s: STRING; i: INTEGER): INTEGER is
			-- Position of the next separator in s starting at ith character.
			-- ":", "/", "-", ",", " ", "."
		require
			s_exists: s /= Void
			i_exists: i /= Void
			i_small: i <= s.count
		local
			int: ARRAY [INTEGER]
			j, int_tmp: INTEGER
		do
			!! int.make (0, 5)
			int.put (s.index_of (':', i), 0)
			int.put (s.index_of ('/', i), 1)
			int.put (s.index_of ('-', i), 2)
			int.put (s.index_of (',', i), 3)
			int.put (s.index_of (' ', i), 4)
			int.put (s.index_of ('.', i), 5)
			Result := s.count + 1
			from 
				j := 0
			until 
				j > 5
			loop
				int_tmp := int.item (j)
				if int_tmp /= 0 and int_tmp < Result then
					Result := int_tmp
				end
				j := j + 1
			end
		ensure
			index_exists: Result /= Void
			next_index: Result > i
		end
		
	days: ARRAY [STRING]

	months: ARRAY [STRING]	

	right_day_text: BOOLEAN
			-- Is the name of the day the right one?

	am_pm_index: INTEGER 
			-- Index of the am/pm notation.

end -- class DATE_TIME_CODE_STRING

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
