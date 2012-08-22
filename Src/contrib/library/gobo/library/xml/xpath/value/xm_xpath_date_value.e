note

	description:

		"Objects that represent XPath date values"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2005, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPATH_DATE_VALUE

inherit

	XM_XPATH_CALENDAR_VALUE
		undefine
			is_xpath_date, as_xpath_date
		redefine
			is_date_value, as_date_value, hash_code
		end

	ST_XPATH_DATE_VALUE
		redefine
			make, make_from_date, make_from_zoned_date
		end

create

	make, make_from_date, make_from_zoned_date

feature {NONE} -- Initialization

	make (a_lexical_date: STRING)
			-- Create from lexical date.
		do
			make_atomic_value
			Precursor (a_lexical_date)
			if not zoned then
				set_depends_upon_implicit_timezone
			end
		end

	make_from_date (a_date: DT_DATE)
			-- Create from date object.
		do
			make_atomic_value
			Precursor (a_date)
			set_depends_upon_implicit_timezone
		end

	make_from_zoned_date (a_date: DT_FIXED_OFFSET_ZONED_DATE)
			-- Create from date object.
		do
			make_atomic_value
			Precursor (a_date)
		end

feature -- Access

	item_type: XM_XPATH_ITEM_TYPE
			-- Data type of the expression, where know
		do
			Result := type_factory.date_type
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
				Result := a_date_time_parser.zoned_date_to_string (zoned_date)
			else
				Result := a_date_time_parser.date_to_string (local_date)
			end
		end

	as_zoneless: XM_XPATH_DATE_VALUE
			-- Same value as `Current', but without a time zone
		do
			if zoned then
				create Result.make_from_date (zoned_date.date)
			else
				Result := Current
			end
		ensure
			result_not_void: Result /= Void
		end

	to_another_time_zone (an_offset: XM_XPATH_SECONDS_DURATION_VALUE): XM_XPATH_DATE_VALUE
			-- Same date as `Current', but in `a_time_zone'
		require
			time_zone_not_void: an_offset /= Void
		local
			a_zone: DT_FIXED_OFFSET_TIME_ZONE
			a_zoned_dt: DT_FIXED_OFFSET_ZONED_DATE
			a_dt: DT_DATE_TIME
		do
			create a_zone.make (an_offset.duration.time_duration)
			if not zoned then
				create a_zoned_dt.make (local_date, a_zone)
				create Result.make_from_zoned_date (a_zoned_dt)
			else
				create a_dt.make_from_date (zoned_date.date)
				a_dt := a_zone.date_time_from (a_dt, zoned_date.time_zone)
				create a_zoned_dt.make (a_dt.date, a_zone)
				create Result.make_from_zoned_date (a_zoned_dt)
			end
		ensure
			result_not_void: Result /= Void
		end

	hash_code: INTEGER
			-- Hash code value
		do
			if zoned_date = Void then
				Result := local_date.hash_code
			else

				-- Equality implies same `hash_code', but
				--  not vice-versa:

				Result := utc_date.hash_code
			end
		end

	utc_date_time: DT_DATE_TIME
			-- Date_Time adjusted to UTC
		local
			a_zoned_date_time: DT_FIXED_OFFSET_ZONED_DATE_TIME
		do
			create a_zoned_date_time.make_from_zoned_date (zoned_date)
			Result := a_zoned_date_time.date_time_to_utc
		end

	implicitly_zoned_date_time (a_context: XM_XPATH_CONTEXT): DT_DATE_TIME
			-- Date_Time adjusted to UTC via implicit time zone
		local
			a_date_time: DT_DATE_TIME
		do
			create a_date_time.make_from_date (local_date)
			Result := a_context.implicit_timezone.date_time_to_utc (a_date_time)
		end

	utc_date: DT_DATE
			-- Date adjusted to UTC;
			-- Ignores implicit time zone.
		do
			if zoned_date = Void then
				Result := local_date
			elseif cached_utc_date /= Void then
				Result := cached_utc_date
			else
				cached_utc_date := zoned_date.date_to_utc
				Result := cached_utc_date
			end
		ensure
			result_not_void: Result /= Void
		end

feature -- Comparison

	same_expression (other: XM_XPATH_EXPRESSION): BOOLEAN
			-- Are `Current' and `other' the same expression?
		do
			if other.is_date_value then
				Result := zoned = other.as_date_value.zoned
					and then utc_date.three_way_comparison (other.as_date_value.utc_date) = 0
			end
		end

	three_way_comparison (other: XM_XPATH_ATOMIC_VALUE; a_context: XM_XPATH_CONTEXT): INTEGER
			-- Comparison of `Current' to `other'
		local
			a_date: XM_XPATH_DATE_VALUE
			dt1, dt2: DT_DATE_TIME
			a_time: DT_TIME
		do
			a_date := other.as_date_value
			if zoned = a_date.zoned then
				create a_time.make (0,0,0)
				if zoned then
					create dt1.make_from_date_time (zoned_date.date, a_time)
					zoned_date.time_zone.convert_to_utc (dt1)
					create a_time.make (0,0,0)
					create dt2.make_from_date_time (a_date.zoned_date.date, a_time)
					a_date.zoned_date.time_zone.convert_to_utc (dt2)
					Result := dt1.three_way_comparison (dt2)
				else
					create dt2.make_from_date_time (a_date.local_date, a_time)
					create dt1.make_from_date_time (local_date, a_time)
					Result := dt1.three_way_comparison (dt2)
				end
 			elseif zoned then
				create a_time.make (0,0,0)
				create dt2.make_from_date_time (a_date.local_date, a_time)
				a_context.implicit_timezone.convert_to_utc (dt2)
				create a_time.make (0,0,0)
				create dt1.make_from_date_time (zoned_date.date, a_time)
				zoned_date.time_zone.convert_to_utc (dt1)
				Result := dt1.three_way_comparison (dt2)
			else -- `other' is zoned
				create a_time.make (0,0,0)
				create dt2.make_from_date_time (a_date.zoned_date.date, a_time)
				a_date.zoned_date.time_zone.convert_to_utc (dt2)
				create a_time.make (0,0,0)
				create dt1.make_from_date_time (local_date, a_time)
				a_context.implicit_timezone.convert_to_utc (dt1)
				Result := dt1.three_way_comparison (dt2)
			end
		end

feature -- Status report

	is_date_value: BOOLEAN
			-- Is `Current' a date value?
		do
			Result := True
		end

	is_comparable (other: XM_XPATH_ATOMIC_VALUE): BOOLEAN
			-- Is `other' comparable to `Current'?
		do
			Result := other.is_date_value
		end

	is_convertible (a_required_type: XM_XPATH_ITEM_TYPE): BOOLEAN
			-- Is `Current' convertible to `a_required_type'?
		do
			if	a_required_type = any_item or else a_required_type = type_factory.any_atomic_type
				or else a_required_type = type_factory.date_type
				or else a_required_type = type_factory.date_time_type
				or else a_required_type = type_factory.g_year_month_type
				or else a_required_type = type_factory.g_year_type
				or else a_required_type = type_factory.g_month_type
				or else a_required_type = type_factory.g_month_day_type
				or else a_required_type = type_factory.g_day_type
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
			a_string := STRING_.appended_string (indentation (a_level), "date (")
			a_string := STRING_.appended_string (a_string, string_value)
			a_string := STRING_.appended_string (a_string, ")")
			std.error.put_string (a_string)
			std.error.put_new_line
		end

feature -- Conversions

	as_date_value: XM_XPATH_DATE_VALUE
			-- `Current' seen as a date value
		do
			Result := Current
		end

	convert_to_type (a_required_type: XM_XPATH_ITEM_TYPE)
			-- Convert `Current' to `a_required_type'
		do
			if	a_required_type = any_item or else a_required_type = type_factory.any_atomic_type
				or else a_required_type = type_factory.date_type then
				converted_value := Current
			elseif a_required_type = type_factory.string_type then
				create {XM_XPATH_STRING_VALUE} converted_value.make (string_value)
			elseif a_required_type = type_factory.untyped_atomic_type then
				create {XM_XPATH_STRING_VALUE} converted_value.make_untyped_atomic (string_value)
			elseif a_required_type = type_factory.date_time_type then
				if zoned then
					create {XM_XPATH_DATE_TIME_VALUE} converted_value.make_from_zoned_date (zoned_date)
				else
					create {XM_XPATH_DATE_TIME_VALUE} converted_value.make_from_date (local_date)
				end
			elseif a_required_type = type_factory.g_year_month_type then
				if zoned then
					create {XM_XPATH_YEAR_MONTH_VALUE} converted_value.make_from_zoned_date (zoned_date)
				else
					create {XM_XPATH_YEAR_MONTH_VALUE} converted_value.make_from_date (local_date)
				end
			elseif a_required_type = type_factory.g_year_type then
				if zoned then
					create {XM_XPATH_YEAR_VALUE} converted_value.make_from_zoned_date (zoned_date)
				else
					create {XM_XPATH_YEAR_VALUE} converted_value.make_from_date (local_date)
				end
			elseif a_required_type = type_factory.g_month_type then
				if zoned then
					create {XM_XPATH_MONTH_VALUE} converted_value.make_from_zoned_date (zoned_date)
				else
					create {XM_XPATH_MONTH_VALUE} converted_value.make_from_date (local_date)
				end
			elseif a_required_type = type_factory.g_month_day_type then
				if zoned then
					create {XM_XPATH_MONTH_DAY_VALUE} converted_value.make_from_zoned_date (zoned_date)
				else
					create {XM_XPATH_MONTH_DAY_VALUE} converted_value.make_from_date (local_date)
				end
			elseif a_required_type = type_factory.g_day_type then
				if zoned then
					create {XM_XPATH_DAY_VALUE} converted_value.make_from_zoned_date (zoned_date)
				else
					create {XM_XPATH_DAY_VALUE} converted_value.make_from_date (local_date)
				end
			end
		end

feature -- Basic operations

	plus (a_duration: XM_XPATH_DURATION_VALUE): like Current
			-- Addition of `a_duration' to `Current'
		local
			a_date: DT_DATE
			a_date_time: DT_DATE_TIME
			a_zoned_date: like zoned_date
		do
			if zoned then
				a_date := zoned_date.date.twin
			else
				a_date := local_date.twin
			end
			create a_date_time.make_from_date (a_date)
			a_date_time.add_duration (a_duration.duration)
			if zoned then
				create a_zoned_date.make (a_date_time.date, zoned_date.time_zone.twin)
				create Result.make_from_zoned_date (a_zoned_date)
			else
				create Result.make_from_date (a_date_time.date)
			end
		end

feature {NONE} -- Implementation

	cached_utc_date: DT_DATE
			-- Cached `Result' for `utc_date'

invariant

	zoned_date: zoned implies zoned_date /= Void
	unzoned_date: not zoned implies local_date /= Void

end
