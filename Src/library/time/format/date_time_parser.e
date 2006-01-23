indexing
	description: "Parser facility for dates and times"
	legal: "See notice at end of class." 
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DATE_TIME_PARSER inherit

	DATE_TIME_VALIDITY_CHECKER
		rename
			year as checker_year, month as checker_month,
			day as checker_day, hour as checker_hour, minute as checker_minute, 
			fine_second as checker_fine_second
		export
			{NONE} all
		end

	FIND_SEPARATOR_FACILITY

create

	make

feature {NONE} -- Initialization

	make (c: HASH_TABLE [DATE_TIME_CODE, INTEGER]) is
			-- Create parser with date/time code `c', months array `m',
			-- days array `d', and base century `b'.
		require
			code_exists: c /= Void
		do
			code := c
		ensure
			code_set: code = c
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

	is_set_up: BOOLEAN is
			-- Has parser been set up completely?
		do
			Result := (days /= Void) and (months /= Void) and 
				(source_string /= Void and then not source_string.is_empty)
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
			Result := is_correct_time (hour, minute, fine_second, False)
		end

	is_date_time: BOOLEAN is
			-- Does `source_string' contain a DATE_TIME?
		require
			string_parsed: parsed
		do
			Result := is_correct_date_time (year, month, day, hour,
				minute, fine_second, False)
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
			non_empty_string: s /= Void and then not s.is_empty
		do
			source_string := s
			parsed := False
		ensure
			source_set: source_string = s
			not_parsed: not parsed
		end

	set_day_array (d: ARRAY [STRING]) is
			-- Set day array to `d'.
		require
			not_void: d /= Void
		do
			days := d
		ensure
			days_set: days = d
		end

	set_month_array (m: ARRAY [STRING]) is
			-- Set month array to `m'.
		require
			not_void: m /= Void
		do
			months := m
		ensure
			months_set: months = m
		end

	set_base_century (c: INTEGER) is
			-- Set base century to `c'.
		require
			base_century_valid: c /= 0 and (c \\ 100 = 0)
		do
			base_century := c
		ensure
			base_century_set: base_century = c
		end

feature -- Basic operations

	parse is
			-- Parse `source_string'.
		require
			setup_complete: is_set_up
		local
			pos1, pos2, i, j: INTEGER
			type: INTEGER
			second_val: INTEGER
			s: STRING
			has_seps: BOOLEAN
			l_year_now: INTEGER
			l_is_pm, l_is_pm_computed: BOOLEAN
			l_hour_val_need_computation: BOOLEAN
		do
			l_year_now := (create {C_DATE}).year_now
			s := source_string.as_upper
			year_val := 1
			month_val := 1
			day_val := 1
			hour_val := 0
			minute_val := 0
			fine_second_val := 0
			pos1 := 1
			pos2 := 1
			has_seps := has_separators (s)
			from 
				i := 1
			until 
				pos1 > s.count
			loop
				if has_seps then
					pos2 := find_separator (s, pos1)
				else
					pos2 := (pos1 + code.item (i).count_max - 1) * -1
				end
				extract_substrings (s, pos1, pos2)
				pos2 := abs (pos2)
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
						if base_century < 0 then
							-- A negative value in `base_century' indicates
							-- that this value has been calculated
							-- automaticaly. Since we want to add it, we
							-- have to substract it, because it is
							-- negative.
							year_val := substrg.to_integer - base_century
							
							-- We need a smart century correction
							-- eventually.
							if year_val - l_year_now > 50 then
								year_val := year_val - 100
							elseif l_year_now - year_val > 50 then
								year_val := year_val + 100
							end
						else
							-- `base_century' has been set manually.
							year_val := substrg.to_integer - base_century
						end
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
						hour_val := substrg.to_integer
						if l_is_pm_computed then
							if l_is_pm then
								hour_val := hour_val + 12
								if hour_val = 24 then
									hour_val := 12
								end
							elseif hour_val = 12 then
								hour_val := 0
							end
						else
							l_hour_val_need_computation := True
						end
					when 23 then
						l_is_pm_computed := True
						l_is_pm := s.as_upper.is_equal ("PM")
					when 12, 13 then 
						minute_val := substrg.to_integer
					when 14, 15 then
						second_val := substrg.to_integer
					when 16 then
						fine_second_val := substrg.to_double / 
							(10 ^ (substrg.count))
					end
					if has_seps then
						i := i + 2
					else
						i := i + 1
					end
					pos1 := pos2 + 1
				end
			end
			if l_hour_val_need_computation then
				if not l_is_pm_computed then
						-- We assume it is AM
					if hour_val = 12 then
						hour_val := 0
					end
				elseif l_is_pm then
					hour_val := hour_val + 12
					if hour_val = 24 then
						hour_val := 12
					end
				elseif hour_val = 12 then
					hour_val := 0
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
			-- specifications
			
invariant

	valid_value_definition: is_value_valid =
			(parsed and then (is_date or is_time or is_date_time))
	valid_value_implies_parsing: is_value_valid implies parsed
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DATE_TIME_PARSER


