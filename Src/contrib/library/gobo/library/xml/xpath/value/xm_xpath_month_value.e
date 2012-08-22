note

	description:

		"Objects that represent XML Schema gMonth values"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2005, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPATH_MONTH_VALUE

inherit

	XM_XPATH_DATE_VALUE
		redefine
			make, make_from_date, make_from_zoned_date,
			is_date_value, item_type,
			is_date, same_expression,
			string_value, three_way_comparison,
			is_comparable, is_convertible,
			convert_to_type, display, is_calendar_value,
			is_month_value, as_month_value
		end

create

	make, make_from_date, make_from_zoned_date

feature {NONE} -- Initialization

	make (a_lexical_date: STRING)
			-- Create from lexical date.
		local
			a_date_time_parser: ST_XSD_DATE_TIME_PARSER
		do
			make_atomic_value
			create a_date_time_parser.make_1_1
			if a_date_time_parser.is_zoned_month (a_lexical_date) then
				zoned := True
				zoned_date := a_date_time_parser.string_to_zoned_month (a_lexical_date)
			else
				local_date := a_date_time_parser.string_to_month (a_lexical_date)
			end
			if not zoned then set_depends_upon_implicit_timezone end
		end

	make_from_date (a_date: DT_DATE)
			-- Create from date object.
		do
			Precursor (a_date)
			if local_date.day = 29 and local_date.month = 2 then
				local_date.set_year_month_day (1, 2, 1)
			else
				local_date.set_day (1)
				local_date.set_year (1)
			end
		end

	make_from_zoned_date (a_date: DT_FIXED_OFFSET_ZONED_DATE)
			-- Create from date object.
		do
			Precursor (a_date)
			if zoned_date.date.day = 29 and zoned_date.date.month = 2 then
				zoned_date.date.set_year_month_day (1, 2, 1)
			else
				zoned_date.date.set_day (1)
				zoned_date.date.set_year (1)
			end
		end

feature -- Access

	item_type: XM_XPATH_ITEM_TYPE
			-- Data type of the expression, where know
		do
			Result := type_factory.g_month_type
			if Result /= Void then
				-- Bug in SE 1.0 and 1.1: Make sure that
				-- that `Result' is not optimized away.
			end
		end

	string_value: STRING
			--Value of the item as a string
		local
			a_date_time_parser: ST_XSD_DATE_TIME_FORMAT
		do
			create a_date_time_parser.make_1_1
			if zoned then
				Result := a_date_time_parser.zoned_month_to_string (zoned_date)
			else
				Result := a_date_time_parser.month_to_string (local_date)
			end
		end

feature -- Comparison

	same_expression (other: XM_XPATH_EXPRESSION): BOOLEAN
			-- Are `Current' and `other' the same expression?
		do
			if other.is_month_value then
				Result := zoned = other.as_month_value.zoned
					and then utc_date.three_way_comparison (other.as_month_value.utc_date) = 0
			end
		end

	three_way_comparison (other: XM_XPATH_ATOMIC_VALUE; a_context: XM_XPATH_CONTEXT): INTEGER
			-- Comparison of `Current' to `other'
		local
			l_mv: XM_XPATH_MONTH_VALUE
			l_dt1, l_dt2: DT_DATE_TIME
			l_time: DT_TIME
		do
			l_mv := other.as_month_value
			if zoned = l_mv.zoned then
				create l_time.make (0,0,0)
				if zoned then
					create l_dt1.make_from_date_time (zoned_date.date, l_time)
					zoned_date.time_zone.convert_to_utc (l_dt1)
				else
					create l_dt1.make_from_date_time (local_date, l_time)
				end
				create l_time.make (0,0,0)
				if zoned then
					create l_dt2.make_from_date_time (l_mv.zoned_date.date, l_time)
					l_mv.zoned_date.time_zone.convert_to_utc (l_dt2)
				else
					create l_dt2.make_from_date_time (l_mv.local_date, l_time)
				end
				Result := l_dt1.three_way_comparison (l_dt2)
 			elseif zoned then
				create l_time.make (0,0,0)
				create l_dt2.make_from_date_time (l_mv.local_date, l_time)
				a_context.implicit_timezone.convert_to_utc (l_dt2)
				create l_time.make (0,0,0)
				create l_dt1.make_from_date_time (zoned_date.date, l_time)
				zoned_date.time_zone.convert_to_utc (l_dt1)
				Result := l_dt1.three_way_comparison (l_dt2)
			else -- `other' is zoned
				create l_time.make (0,0,0)
				create l_dt2.make_from_date_time (l_mv.zoned_date.date, l_time)
				l_mv.zoned_date.time_zone.convert_to_utc (l_dt2)
				create l_time.make (0,0,0)
				create l_dt1.make_from_date_time (local_date, l_time)
				a_context.implicit_timezone.convert_to_utc (l_dt1)
				Result := l_dt1.three_way_comparison (l_dt2)
			end
		end

feature -- Status report

	is_date_value: BOOLEAN
			-- Is `Current' a date value?
		do
			Result := False
		end

	is_calendar_value: BOOLEAN
			-- Is `Current' a calendar value?
		do
			Result := False
		end

	is_month_value: BOOLEAN
			-- Is `Current' a gMonth value?
		do
			Result := True
		end

	is_date (a_lexical_date: STRING): BOOLEAN
			-- Is `a_lexical_date' a valid date?
		local
			a_date_time_parser: ST_XSD_DATE_TIME_PARSER
		do
			create a_date_time_parser.make_1_1
			Result := a_date_time_parser.is_zoned_month (a_lexical_date)
				or else a_date_time_parser.is_month (a_lexical_date)
		end

	is_comparable (other: XM_XPATH_ATOMIC_VALUE): BOOLEAN
			-- Is `other' comparable to `Current'?
		do
			Result := other.is_month_value
		end

	is_convertible (a_required_type: XM_XPATH_ITEM_TYPE): BOOLEAN
			-- Is `Current' convertible to `a_required_type'?
		do
			if	a_required_type = any_item or else a_required_type = type_factory.any_atomic_type
				or else a_required_type = type_factory.g_month_type
				or else a_required_type = type_factory.string_type
				or else a_required_type = type_factory.untyped_atomic_type then
				Result := True
			end
		end

	display (a_level: INTEGER)
			-- Diagnostic print of expression structure to `std.error'
		local
			a_string: STRING
		do
			a_string := STRING_.appended_string (indentation (a_level), "gMonth (")
			a_string := STRING_.appended_string (a_string, string_value)
			a_string := STRING_.appended_string (a_string, ")")
			std.error.put_string (a_string)
			std.error.put_new_line
		end

feature -- Conversions

	as_month_value: XM_XPATH_MONTH_VALUE
			-- `Current' seen as a gMonth value
		do
			Result := Current
		end

	convert_to_type (a_required_type: XM_XPATH_ITEM_TYPE)
			-- Convert `Current' to `a_required_type'
		do
			if	a_required_type = any_item or a_required_type = type_factory.any_atomic_type or
				a_required_type = type_factory.g_month_type then
				converted_value := Current
			elseif a_required_type = type_factory.string_type then
				create {XM_XPATH_STRING_VALUE} converted_value.make (string_value)
			elseif a_required_type = type_factory.untyped_atomic_type then
				create {XM_XPATH_STRING_VALUE} converted_value.make_untyped_atomic (string_value)
			end
		end

end
