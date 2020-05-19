note
	description: "DATE/TIME to STRING conversion"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DATE_TIME_CODE_STRING inherit

	FIND_SEPARATOR_FACILITY

create

	make

feature -- Creation

	make (s: READABLE_STRING)
			-- Create code descriptors and hash-table from `s'.
		require
			s_exists: s /= Void
		local
			i, pos1, pos2: INTEGER
			date_constants: DATE_CONSTANTS
			l_substrgs: like extracted_substrings
			l_substrg, l_substrg2: READABLE_STRING
		do
			create value.make (20)
			pos1 := 1
			create date_constants
			days := date_constants.days_text.twin
			months := date_constants.months_text.twin
			from
				i := 1
			until
				pos1 >= s.count
			loop
				pos2 := find_separator (s, pos1)
				l_substrgs := extracted_substrings (s, pos1, pos2)
				pos2 := pos2.abs
				l_substrg := l_substrgs.substrg
				if l_substrg.count > 0 then
					value.put (create {DATE_TIME_CODE}.make (l_substrg.as_lower), i)
					i := i + 1
				end
				l_substrg2 := l_substrgs.substrg2
				if l_substrg2.count > 0 then
					value.put (create {DATE_TIME_CODE}.make (l_substrg2), i)
					i := i + 1
					separators_used := True
				end
				pos1 := pos2 + 1
			end
			base_century := (create {C_DATE}).year_now // 100 * -100
				-- A negative value of `base_century' indicates that it has
				-- been calculated automatically, therefore '* -100'.
		ensure
			value_set: value /= Void
			base_century_set: base_century < 0 and (base_century \\ 100 = 0)
		end

feature -- Attributes

	value: HASH_TABLE [DATE_TIME_CODE, INTEGER]
			-- Hash-table representing the code string.

	name: STRING
			-- Name of the code string.
		local
			i: INTEGER
			l_item: detachable DATE_TIME_CODE
		do
			create Result.make (1)
			from
				i := 1
				l_item := value.item (i)
			until
				l_item = Void
			loop
				Result.append (l_item.name)
				Result.append_character (' ')
				i := i + 1
				l_item := value.item (i)
			end
		end

	base_century: INTEGER
			-- Base century, used when interpreting 2-digit year
			-- specifications.

feature -- Status report

	is_date (s: READABLE_STRING): BOOLEAN
			-- Does `s' contain a DATE?
		require
			non_empty_string: s /= Void and then not s.is_empty
		do
			Result := parser (s).is_date
		end

	is_time (s: READABLE_STRING): BOOLEAN
			-- Does `s' contain a TIME?
		require
			non_empty_string: s /= Void and then not s.is_empty
		do
			Result := parser (s).is_time
		end

	is_date_time (s: READABLE_STRING): BOOLEAN
			-- Does `s' contain a DATE_TIME?
		require
			non_empty_string: s /= Void and then not s.is_empty
		do
			Result := parser (s).is_date_time
		end

	is_value_valid (s: READABLE_STRING): BOOLEAN
			-- Does `s' contain a valid date or time as string representation?
		require
			non_empty_string: s /= Void and then not s.is_empty
		local
			l_parser: like parser
		do
			l_parser := parser (s)
			Result := l_parser.is_date or l_parser.is_time or l_parser.is_date_time
		end

	separators_used: BOOLEAN
			-- Does the code string contain any separators?

feature -- Status setting

	set_base_century (c: INTEGER)
			-- Set base century to `c'.
		require
			base_valid: c > 0 and (c \\ 100 = 0)
		do
			base_century := c
		ensure
			base_century_set: base_century = c
		end

feature -- Interface

	correspond (s: READABLE_STRING): BOOLEAN
			-- Does the user string `s' correspond to the code string?
		require
			s_exists: s /= Void
		local
			pos1, pos2, i: INTEGER
			code: detachable DATE_TIME_CODE
			has_seps: BOOLEAN
			l_substrgs: like extracted_substrings
			l_substrg, l_substrg2: READABLE_STRING
		do
			pos1 := 1
			if s.is_empty then
				Result := False
			else
				Result := True
				has_seps := has_separators (s)
			end
			from
				i := 1
			until
				pos1 > s.count
				or not Result
			loop
				code := value.item (i)
				if code = Void then
					Result := False
				else
					if has_seps then
						pos2 := find_separator (s, pos1)
					else
						pos2 := (pos1 + code.count_max - 1) * -1
					end
					l_substrgs := extracted_substrings (s, pos1, pos2)
					pos2 := pos2.abs
					l_substrg := l_substrgs.substrg
					if l_substrg.count > 0 then
						Result := l_substrg.count <= code.count_max and
						l_substrg.count >= code.count_min
						if code.is_numeric then
							Result := Result and l_substrg.is_integer
							if code.value_max /= -1 and
								code.value_min /= -1 then
								Result := Result and
									l_substrg.to_integer <= code.value_max and
									l_substrg.to_integer >= code.value_min
							end
						elseif code.is_meridiem (code.value) then
							Result := Result and (l_substrg.is_case_insensitive_equal ("AM") or
								l_substrg.is_case_insensitive_equal ("PM"))
						elseif code.is_day_text (code.value) then
							Result := Result and days.has (l_substrg)
						elseif code.is_month_text (code.value) then
							Result := Result and months.has (l_substrg)
						end
						i := i + 1
					end
					if has_seps then
						code := value.item (i)
						i := i + 1
						if code /= Void then
							l_substrg2 := l_substrgs.substrg2
							Result := Result and pos2 /= s.count and
								l_substrg2.same_string (code.value)
						end
					end
					pos1 := pos2 + 1
				end
			end
		end

	create_string (date_time: DATE_TIME): STRING
			-- Create the output of `date_time' according to the code string.
		require
			non_void: date_time /= Void
		local
			date: DATE
			time: TIME
			int, i, type: INTEGER
			l_tmp: STRING
			l_item: detachable DATE_TIME_CODE
		do
			create Result.make (1)
			date := date_time.date
			time := date_time.time
			from
				i := 1
				l_item := value.item (i)
			until
				l_item = Void
			loop
				type := l_item.type
				inspect
					type
				when {DATE_TIME_CODE}.day_numeric_type_code then
					Result.append (date.day.out)
				when {DATE_TIME_CODE}.day_numeric_on_2_digits_type_code then
					int := date.day
					if int < 10 then
						Result.append ("0")
					end
					Result.append (int.out)
				when {DATE_TIME_CODE}.day_text_type_code then
					int := date.day_of_the_week
					Result.append (days.item (int))
				when {DATE_TIME_CODE}.year_on_4_digits_type_code then
					-- Test if the year has four digits, if not put 0 to fill it
					l_tmp := date.year.out
					if l_tmp.count = 4 then
						Result.append (l_tmp)
					else
						if l_tmp.count = 1 then
							Result.append ("000")
							Result.append (l_tmp)
						elseif l_tmp.count = 2 then
							Result.append ("00")
							Result.append (l_tmp)
						elseif l_tmp.count = 3 then
							Result.append ("0")
							Result.append (l_tmp)
						end
					end
				when {DATE_TIME_CODE}.year_on_2_digits_type_code then
						-- Two digit year, we only keep the last two digits
					l_tmp := date.year.out
					if l_tmp.count > 2 then
						l_tmp.keep_tail (2)
					elseif l_tmp.count = 1 then
						Result.append_character ('0')
					end
					Result.append (l_tmp)
				when {DATE_TIME_CODE}.month_numeric_type_code then
					Result.append (date.month.out)
				when {DATE_TIME_CODE}.month_numeric_on_2_digits_type_code then
					int := date.month
					if int < 10 then
						Result.append ("0")
					end
					Result.append (int.out)
				when {DATE_TIME_CODE}.month_text_type_code then
					int := date.month
					Result.append (months.item (int))
				when {DATE_TIME_CODE}.hour_numeric_type_code then
					Result.append (time.hour.out)
				when {DATE_TIME_CODE}.hour_numeric_on_2_digits_type_code then
					int := time.hour
					if int < 10 then
						Result.append ("0")
					end
					Result.append (int.out)
				when {DATE_TIME_CODE}.hour_12_clock_scale_type_code, {DATE_TIME_CODE}.hour_12_clock_scale_on_2_digits_type_code then
					int := time.hour
					if int < 12 then
						if int = 0 then
							int := 12
						end
					else
						if int /= 12 then
							int := int - 12
						end
					end
					if type = {DATE_TIME_CODE}.hour_12_clock_scale_on_2_digits_type_code and then int < 10 then
							-- Format padded with 0.
						Result.append ("0")
					end
					Result.append (int.out)
				when {DATE_TIME_CODE}.minute_numeric_type_code then
					Result.append (time.minute.out)
				when {DATE_TIME_CODE}.minute_numeric_on_2_digits_type_code then
					int := time.minute
					if int < 10 then
						Result.append ("0")
					end
					Result.append (int.out)
				when {DATE_TIME_CODE}.second_numeric_type_code then
					Result.append (time.second.out)
				when {DATE_TIME_CODE}.second_numeric_on_2_digits_type_code then
					int := time.second
					if int < 10 then
						Result.append ("0")
					end
					Result.append (int.out)
				when {DATE_TIME_CODE}.fractional_second_numeric_type_code then
					int := (time.fractional_second * 10 ^ l_item.count_max).rounded
					l_tmp := int.out
					if l_tmp.count < l_item.count_max then
						Result.append (create {STRING}.make_filled ('0', l_item.count_max - l_tmp.count))
					end
					Result.append (l_tmp)
				when {DATE_TIME_CODE}.meridiem_type_code then
					int := time.hour
					if int < 12 then
						Result.append ("AM")
					else
						Result.append ("PM")
					end
				else
					Result.append (l_item.value)
				end
				i := i + 1
				l_item := value.item (i)
			end
		ensure
			string_exists: Result /= Void
			string_correspond: correspond (Result)
		end

	create_date_string (date: DATE): STRING
				-- Create the output of `date' according to the code string.
		require
			date_exists: date /= Void
		do
			Result := create_string (create {DATE_TIME}.make_by_date (date))
		ensure
			string_exists: Result /= Void
			string_correspond: correspond (Result)
		end

	create_time_string (time: TIME): STRING
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

	create_date_time (s: READABLE_STRING): DATE_TIME
			-- Create DATE_TIME according to `s'.
		require
			s_exist: s /= Void
			is_precise: precise
			s_correspond: correspond (s)
			valid: is_value_valid (s)
		local
			l_parser: like parser
			l_day_text: detachable READABLE_STRING
		do
			right_day_text := True
			l_parser := parser (s)
			create Result.make_fine (l_parser.year, l_parser.month, l_parser.day,
					l_parser.hour, l_parser.minute, l_parser.fine_second)
			l_day_text := l_parser.day_text
			if l_day_text /= Void then
				right_day_text := l_day_text.same_string
					(days.item (Result.date.day_of_the_week))
			end
		ensure
			date_time_exists: Result /= Void
			day_text_equal_day: right_day_text
		end

	create_date (s: READABLE_STRING): DATE
			-- Create a DATE according to the format in `s'.
		require
			s_exists: s /= Void
			is_precise: precise_date
			s_correspond: correspond (s)
		local
			tmp_code: DATE_TIME_CODE
			tmp_ht: HASH_TABLE [DATE_TIME_CODE, INTEGER]
			i: INTEGER
		do
			tmp_ht := value.twin
			i := value.count + 1
			if has_separators (s) then
				create tmp_code.make (" ")
				value.put (tmp_code, i)
				create tmp_code.make ("hh")
				value.put (tmp_code, i + 1)
				create tmp_code.make (":")
				value.put (tmp_code, i + 2)
				create tmp_code.make ("mi")
				value.put (tmp_code, i + 3)
				create tmp_code.make (":")
				value.put (tmp_code, i + 4)
				create tmp_code.make ("ss")
				value.put (tmp_code, i + 5)
				Result := create_date_time (s + " 0:0:0").date
			else
				create tmp_code.make ("[0]hh")
				value.put (tmp_code, i)
				create tmp_code.make ("[0]mi")
				value.put (tmp_code, i + 1)
				create tmp_code.make ("[0]ss")
				value.put (tmp_code, i + 2)
				Result := create_date_time (s + "000000").date
			end
			value := tmp_ht
		ensure
			date_exists: Result /= Void
			day_text_equal_day: right_day_text
		end

	create_time (s: READABLE_STRING): TIME
			-- Create a TIME according to the format in `s'.
		require
			s_exists: s /= Void
			is_precise: precise_time
			s_correspond: correspond (s)
		local
			tmp_code: DATE_TIME_CODE
			tmp_ht: HASH_TABLE [DATE_TIME_CODE, INTEGER]
			i: INTEGER
		do
			tmp_ht := value.twin
			i := value.count + 1
			if has_separators (s) then
				create tmp_code.make (" ")
				value.put (tmp_code, i)
				create tmp_code.make ("dd")
				value.put (tmp_code, i + 1)
				create tmp_code.make ("/")
				value.put (tmp_code, i + 2)
				create tmp_code.make ("mm")
				value.put (tmp_code, i + 3)
				create tmp_code.make ("/")
				value.put (tmp_code, i + 4)
				create tmp_code.make ("yy")
				value.put (tmp_code, i + 5)
				Result := create_date_time (s + " 1/1/01").time
			else
				create tmp_code.make ("[0]dd")
				value.put (tmp_code, i)
				create tmp_code.make ("[0]mm")
				value.put (tmp_code, i + 1)
				create tmp_code.make ("yy")
				value.put (tmp_code, i + 2)
				Result := create_date_time (s + "010101").time
			end
			value := tmp_ht
		ensure
			time_exists: Result /= Void
			time_correspond: create_time_string (Result).same_string (s)
		end


	precise: BOOLEAN
			-- Is the code string enough precise to create
			-- nn instance of type DATE_TIME?
		require
			not_void: value /= Void
		do
			Result := precise_date and precise_time
		end

	precise_date: BOOLEAN
			-- Is the code string enough precise to create
			-- nn instance of type DATE?
		require
			not_void: value /= Void
		local
			i, type: INTEGER
			has_day, has_month, has_year: BOOLEAN
		do
			from
				i := 1

			until
				not attached value.item (i) as l_item
			loop
				type := l_item.type
				if separators_used then
					inspect
						type
					when {DATE_TIME_CODE}.day_numeric_type_code, {DATE_TIME_CODE}.day_numeric_on_2_digits_type_code then
						has_day := True
					when {DATE_TIME_CODE}.year_on_4_digits_type_code, {DATE_TIME_CODE}.year_on_2_digits_type_code then
						has_year := True
					when {DATE_TIME_CODE}.month_numeric_type_code, {DATE_TIME_CODE}.month_numeric_on_2_digits_type_code, {DATE_TIME_CODE}.month_text_type_code then
						has_month := True
					else
						-- Wrong format
					end
				else
					inspect
						type
					when {DATE_TIME_CODE}.day_numeric_on_2_digits_type_code then
						has_day := True
					when {DATE_TIME_CODE}.year_on_4_digits_type_code, {DATE_TIME_CODE}.year_on_2_digits_type_code then
						has_year := True
					when {DATE_TIME_CODE}.month_numeric_on_2_digits_type_code then
						has_month := True
					else
						-- Wrong format
					end
				end
				i := i + 1
			end
			Result := has_day and has_month and has_year
		end

	precise_time: BOOLEAN
			-- Is the code string enough precise to create
			-- an instance of type TIME?
		require
			not_void: value /= Void
		local
			i, type: INTEGER
			has_hour_12, has_hour_24, has_minute, has_second: BOOLEAN
		do
			from
				i := 1
			until
				not attached value.item (i) as l_item
			loop
				type := l_item.type
				if separators_used then
					inspect
						type
					when {DATE_TIME_CODE}.hour_numeric_type_code, {DATE_TIME_CODE}.hour_numeric_on_2_digits_type_code then
						has_hour_24 := True
					when {DATE_TIME_CODE}.minute_numeric_type_code, {DATE_TIME_CODE}.minute_numeric_on_2_digits_type_code then
						has_minute := True
					when {DATE_TIME_CODE}.second_numeric_type_code, {DATE_TIME_CODE}.second_numeric_on_2_digits_type_code then
						has_second := True
					when {DATE_TIME_CODE}.hour_12_clock_scale_type_code, {DATE_TIME_CODE}.hour_12_clock_scale_on_2_digits_type_code then
						has_hour_12 := True
					else
						-- Wrong format
					end
				else
					inspect
						type
					when {DATE_TIME_CODE}.hour_numeric_on_2_digits_type_code then
						has_hour_24 := True
					when {DATE_TIME_CODE}.minute_numeric_on_2_digits_type_code then
						has_minute := True
					when {DATE_TIME_CODE}.second_numeric_on_2_digits_type_code then
						has_second := True
					when {DATE_TIME_CODE}.hour_12_clock_scale_on_2_digits_type_code then
							-- Two digit hours are valid without separators.
						has_hour_12 := True
					else
						-- Wrong format
					end
				end
				i := i + 1
			end
			Result := (has_hour_24 or has_hour_12) and has_minute and has_second
				--| Technically `has_hour_12' should be or'd with a 'has_meridiem' so that all time values can be specified
				--| but changing this may break existing code that rely on this behavior.
		end

feature {NONE} -- Implementation

	days: ARRAY [READABLE_STRING]

	months: ARRAY [READABLE_STRING]

	right_day_text: BOOLEAN
			-- Is the name of the day the right one?

	parser (s: READABLE_STRING): DATE_TIME_PARSER
			-- Parser from `s'.
			-- Build a new one if necessary.
		require
			non_empty_string: s /= Void and then not s.is_empty
		do
			Result := internal_parser
			if not attached Result or else not equal (Result.source_string, s) then
				create Result.make (value)
				Result.set_day_array (days)
				Result.set_month_array (months)
				Result.set_base_century (base_century)
				Result.set_source_string (s)
				Result.parse
				internal_parser := Result
			end
		ensure
			parser_not_void: Result /= Void
		end

	internal_parser: detachable DATE_TIME_PARSER;
			-- Cached instance of date-time string parser

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
