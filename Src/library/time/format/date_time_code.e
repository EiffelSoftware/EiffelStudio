note
	description: "Code used by the DATE/TIME to STRING conversion"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DATE_TIME_CODE inherit

	CODE_VALIDITY_CHECKER

	DEBUG_OUTPUT

create

	make

feature -- Creation

	make (v: READABLE_STRING)
			-- Create code.
		require
			v_exists: v /= Void
			v_is_code: is_code (v)
		do
			set_value (v)
		ensure
			value_set: value.same_string (v)
		end

feature -- Status report

	is_separator_code: BOOLEAN
		do
			inspect type
			when
				colon_type_code,
				slash_type_code,
				minus_type_code,
				comma_type_code,
				space_type_code,
				dot_type_code
			then
				Result := True
			else
			end
		end

	is_text: BOOLEAN
			-- Has the code a string value?

	is_numeric: BOOLEAN;
			-- Has the code a numeric value?

feature -- Change

	set_value (v: READABLE_STRING)
			-- Set all the attributes such as
			-- Value, count_max, etc.
		require
			v_exists: v /= Void
			v_is_code: is_code (v)
		local
			l_name: like name
		do
			value := v.twin
			if is_day (value) then
				count_max := 2
				count_min := 1
				l_name := "day-numeric"
				value_max := 31
				value_min := 1
				is_text := False
				is_numeric := True
				type := day_numeric_type_code
			elseif is_day0 (value) then
				count_max := 2
				count_min := 2
				l_name := "day-numeric-on-2-digits"
				value_max := 31
				value_min := 1
				is_text := False
				is_numeric := True
				type := day_numeric_on_2_digits_type_code
			elseif is_day_text (value) then
				count_max := 3
				count_min := 3
				l_name := "day-text"
				value_max := 7
				value_min := 1
				is_text := True
				is_numeric := False
				type := day_text_type_code
			elseif is_year4 (value) then
				count_max := 4
				count_min := 4
				l_name := "year-on-4-digits"
				is_text := False
				is_numeric := True
				type := year_on_4_digits_type_code
				value_max := -1
				value_min := -1
			elseif is_year2 (value) then
				count_max := 2
				count_min := 2
				l_name := "year-on-2-digits"
				is_text := False
				is_numeric := True
				type := year_on_2_digits_type_code
				value_max := -1
				value_min := -1
			elseif is_month (value) then
				count_max := 2
				count_min := 1
				l_name := "month-numeric"
				value_max := 12
				value_min := 1
				is_text := False
				is_numeric := True
				type := month_numeric_type_code
			elseif is_month0 (value) then
				count_max := 2
				count_min := 2
				l_name := "month-numeric-on-2-digits"
				value_max := 12
				value_min := 1
				is_text := False
				is_numeric := True
				type := month_numeric_on_2_digits_type_code
			elseif is_month_text (value) then
				count_max := 3
				count_min := 3
				l_name := "month-text"
				value_max := 12
				value_min := 1
				is_text := True
				is_numeric := False
				type := month_text_type_code
			elseif is_hour (value) then
				count_max := 2
				count_min := 1
				l_name := "hour-numeric"
				value_max := 24
				value_min := 0
				is_text := False
				is_numeric := True
				type := hour_numeric_type_code
			elseif is_hour0 (value) then
				count_max := 2
				count_min := 2
				l_name := "hour-numeric-on-2-digits"
				value_max := 24
				value_min := 0
				is_text := False
				is_numeric := True
				type := hour_numeric_on_2_digits_type_code
			elseif is_hour12 (value) then
				count_max := 2
				count_min := 1
				l_name := "hour-12-clock-scale"
				value_max := 12
				value_min := 0
				is_text := False
				is_numeric := True
				type := hour_12_clock_scale_type_code
			elseif is_minute (value) then
				count_max := 2
				count_min := 1
				l_name := "minute-numeric"
				value_max := 59
				value_min := 0
				is_text := False
				is_numeric := True
				type := minute_numeric_type_code
			elseif is_minute0 (value) then
				count_max := 2
				count_min := 2
				l_name := "minute-numeric-on-2-digits"
				value_max := 59
				value_min := 0
				is_text := False
				is_numeric := True
				type := minute_numeric_on_2_digits_type_code
			elseif is_second (value) then
				count_max := 2
				count_min := 1
				l_name := "second-numeric"
				value_max := 59
				value_min := 0
				is_text := False
				is_numeric := True
				type := second_numeric_type_code
			elseif is_second0 (value) then
				count_max := 2
				count_min := 2
				l_name := "second-numeric-on-2-digits"
				value_max := 59
				value_min := 0
				is_text := False
				is_numeric := True
				type := second_numeric_on_2_digits_type_code
			elseif is_fractional_second (value) then
				count_max := value.substring (3, value.count).to_integer
				count_min := 1
				l_name := "fractional-second-numeric"
				is_text := False
				is_numeric := True
				type := fractional_second_numeric_type_code
				value_max := -1
				value_min := -1
			elseif is_colon (value) then
				count_max := 1
				count_min := 1
				l_name := "colon"
				is_text := True
				is_numeric := False
				type := colon_type_code
			elseif is_slash (value) then
				count_max := 1
				count_min := 1
				l_name := "slash"
				is_text := True
				is_numeric := False
				type := slash_type_code
			elseif is_minus (value) then
				count_max := 1
				count_min := 1
				l_name := "minus"
				is_text := True
				is_numeric := False
				type := minus_type_code
			elseif is_comma (value) then
				count_max := 1
				count_min := 1
				l_name := "comma"
				is_text := True
				is_numeric := False
				type := comma_type_code
			elseif is_space (value) then
				count_max := 1
				count_min := 1
				l_name := "space"
				is_text := True
				is_numeric := False
				type := space_type_code
			elseif is_dot (value) then
				count_max := 1
				count_min := 1
				l_name := "dot"
				is_text := True
				is_numeric := False
				type := dot_type_code
			elseif is_meridiem (value) then
				count_max := 2
				count_min := 2
				l_name := "meridiem"
				is_text := True
				is_numeric := False
				type := meridiem_type_code
			else
				check is_hour12_0: is_hour12_0 (value) end
				count_max := 2
				count_min := 2
				l_name := "hour-12-clock-scale-on-2-digits"
				value_max := 12
				value_min := 0
				is_text := False
				is_numeric := True
				type := hour_12_clock_scale_on_2_digits_type_code
			end
			name := l_name
		ensure
			value_set: value.same_string (v)
		end

feature -- Attributes

	value: READABLE_STRING
			-- String code

	count_max: INTEGER
			-- Count max of the real value

	count_min: INTEGER
			-- Count min of the real value

	name: STRING
			-- Name of the code

	value_max: INTEGER
			-- Max of the real value

	value_min: INTEGER
			-- Min of the real value

	type: INTEGER
			-- Type number.

feature -- Output

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_empty
			Result.append_integer (type)
			Result.append (" -> ")
			Result.append (name)
		end

feature {FIND_SEPARATOR_FACILITY} -- Implementation

	day_numeric_type_code: NATURAL_8 = 1
	day_numeric_on_2_digits_type_code: NATURAL_8 = 2
	day_text_type_code: NATURAL_8 = 3
	year_on_4_digits_type_code: NATURAL_8 = 4
	year_on_2_digits_type_code: NATURAL_8 = 5
	month_numeric_type_code: NATURAL_8 = 6
	month_numeric_on_2_digits_type_code: NATURAL_8 = 7
	month_text_type_code: NATURAL_8 = 8
	hour_numeric_type_code: NATURAL_8 = 9
	hour_numeric_on_2_digits_type_code: NATURAL_8 = 10
	hour_12_clock_scale_type_code: NATURAL_8 = 11
	hour_12_clock_scale_on_2_digits_type_code: NATURAL_8 = 12
	minute_numeric_type_code: NATURAL_8 = 13
	minute_numeric_on_2_digits_type_code: NATURAL_8 = 14
	second_numeric_type_code: NATURAL_8 = 15
	second_numeric_on_2_digits_type_code: NATURAL_8 = 16
	fractional_second_numeric_type_code: NATURAL_8 = 17
	colon_type_code: NATURAL_8 = 18
	slash_type_code: NATURAL_8 = 19
	minus_type_code: NATURAL_8 = 20
	comma_type_code: NATURAL_8 = 21
	space_type_code: NATURAL_8 = 22
	dot_type_code: NATURAL_8 = 23
	meridiem_type_code: NATURAL_8 = 24
		-- Type code constants

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
