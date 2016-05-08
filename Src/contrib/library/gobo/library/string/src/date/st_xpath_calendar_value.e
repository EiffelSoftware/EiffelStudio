note

	description:

		"Chronological values consistent with XPath 2.0"

	library: "Gobo Eiffel String Library"
	copyright: "Copyright (c) 2007-2013, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class ST_XPATH_CALENDAR_VALUE

inherit

	DT_GREGORIAN_CALENDAR

	KL_IMPORTED_BOOLEAN_ROUTINES
		export {NONE} all end

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

	KL_IMPORTED_ANY_ROUTINES
		export {NONE} all end

feature -- Access

	year: INTEGER
			-- Year component
		require
			not_time_value: not is_xpath_time
		do
			if is_xpath_date then
				Result := as_xpath_date.date.year
			else
				Result := as_xpath_date_time.date.year
			end
		end

	absolute_year: INTEGER
			-- Year component, ignoring sign
		require
			not_time_value: not is_xpath_time
		do
			if year > 0 then
				Result := year
			else
				Result := 1 - year
			end
		ensure
			strictly_positive_result: Result > 0
		end

	month: INTEGER
			-- Month component
		require
			not_time_value: not is_xpath_time
		do
			if is_xpath_date then
				Result := as_xpath_date.date.month
			else
				Result := as_xpath_date_time.date.month
			end
		ensure
			result_in_range: Result >= 1 and then Result <= 12
		end

	day_in_month: INTEGER
			-- Day within month
		require
			not_time_value: not is_xpath_time
		do
			if is_xpath_date then
				Result := as_xpath_date.date.day
			else
				Result := as_xpath_date_time.date.day
			end
		ensure
			result_in_range: Result >= 1 and then Result <= 31
		end

	day_in_year: INTEGER
			-- Day within year
		require
			not_time_value: not is_xpath_time
		do
			if is_xpath_date then
				Result := as_xpath_date.date.year_day
			else
				Result := as_xpath_date_time.date.year_day
			end
		ensure
			result_in_range: Result >= 1 and then Result <= 366
		end

	week_day_number: INTEGER
			-- ISO 8601 day within week;
			-- Monday = 1; Sunday = 7
		require
			not_time_value: not is_xpath_time
		do
			if is_xpath_date then
				Result := as_xpath_date.date.day_of_week.as_week_day_from_monday.code
			else
				Result := as_xpath_date_time.date.day_of_week.as_week_day_from_monday.code
			end
		ensure
			result_in_range: Result >= 1 and then Result <= 7
		end

	week_in_year: INTEGER
			-- ISO 8601 week within year
		require
			not_time_value: not is_xpath_time
		do
			Result := week_number (year, month, day_in_month)
		ensure
			result_in_range: Result >= 1 and then Result <= 53
		end

	week_in_month: INTEGER
			-- Week within month
		require
			not_time_value: not is_xpath_time
		do
			Result := (day_in_month + 6) // 7
		ensure
			result_in_range: Result >= 1 and then Result <= 5
		end

	hour: INTEGER
			-- Hour within day
		require
			not_date_value: not is_xpath_date
		do
			if is_xpath_time then
				Result := as_xpath_time.time.hour
			else
				Result := as_xpath_date_time.time.hour
			end
		ensure
			result_in_range: Result >= 0 and then Result <= 23
		end

	half_day_hour: INTEGER
			-- Hour within half-day
		require
			not_date_value: not is_xpath_date
		do
			Result := hour
			if Result > 11 then
				Result := Result - 12
			end
			if Result = 0 then
				Result := 12
			end
		ensure
			result_in_range: Result >= 1 and then Result <= 12
		end

	minutes_in_day: INTEGER
			-- Minutes within day
		require
			not_date_value: not is_xpath_date
		do
			Result := hour * 60 + minute
		ensure
			result_in_range: Result >= 0 and then Result <= 1439
		end

	minute: INTEGER
			-- Minutes within hour
		require
			not_date_value: not is_xpath_date
		do
			if is_xpath_time then
				Result := as_xpath_time.time.minute
			else
				Result := as_xpath_date_time.time.minute
			end
		ensure
			result_in_range: Result >= 0 and then Result <= 59
		end

	second: INTEGER
			-- Seconds within minute
		require
			not_date_value: not is_xpath_date
		do
			if is_xpath_time then
				Result := as_xpath_time.time.second
			else
				Result := as_xpath_date_time.time.second
			end
		ensure
			result_in_range: Result >= 0 and then Result <= 59
		end

	millisecond: INTEGER
			-- Milliseconds within second
		require
			not_date_value: not is_xpath_date
		do
			if is_xpath_time then
				Result := as_xpath_time.time.millisecond
			else
				Result := as_xpath_date_time.time.millisecond
			end
		ensure
			result_in_range: Result >= 0 and then Result <= 999
		end

	time_zone_description: STRING
			-- Description of time zone in format [+|-]hh:mm
		require
			zoned_value: zoned
		local
			l_time_zone: DT_FIXED_OFFSET_TIME_ZONE
			l_zoned_time: detachable DT_FIXED_OFFSET_ZONED_TIME
			l_zoned_date: detachable DT_FIXED_OFFSET_ZONED_DATE
			l_zoned_date_time: detachable DT_FIXED_OFFSET_ZONED_DATE_TIME
		do
			if is_xpath_time then
				l_zoned_time := as_xpath_time.zoned_time
				check
						-- precondition `zoned_value'
					zoned_value: l_zoned_time /= Void
				then
					l_time_zone := l_zoned_time.time_zone
				end
			elseif is_xpath_date then
				l_zoned_date := as_xpath_date.zoned_date
				check
						-- precondition `zoned_value'
					zoned_value: l_zoned_date /= Void
				then
					l_time_zone := l_zoned_date.time_zone
				end
			else
				l_zoned_date_time := as_xpath_date_time.zoned_date_time
				check
						-- precondition `zoned_value'
					zoned_value: l_zoned_date_time /= Void
				then
					l_time_zone := l_zoned_date_time.time_zone
				end
			end
			Result := l_time_zone.name
			if Result.count = 1 then
				check
					STRING_.same_string (Result, "Z")
				end
				Result := "+00:00"
			else
				check
					Result.count = 9
				end
					-- Result begins with UTC
				Result := Result.substring (4, 9)
			end
		ensure
			six_characters: Result /= Void and then Result.count = 6
		end

feature -- Status report

	zoned: BOOLEAN
			-- Is `Current' zoned?

	is_xpath_time: BOOLEAN
			-- Does `Current' have a time component and no date component?
		do
			Result := False
		end

	is_xpath_date: BOOLEAN
			-- Does `Current' have a date component and no time component?
		do
			Result := False
		end

	is_xpath_date_time: BOOLEAN
			-- Does `Current' have both a time component and a date component?
		do
			Result := False
		end

feature -- Conversion

	as_xpath_time: ST_XPATH_TIME_VALUE
			-- `Current' seen as a time value
		require
			is_xpath_time_value: is_xpath_time
		local
			v: detachable ST_XPATH_TIME_VALUE
		do
			check
					-- Fool the compiler for void-safety purpose
				should_not_occur: v /= Void
			then
				Result := v
			end
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_xpath_date: ST_XPATH_DATE_VALUE
			-- `Current' seen as a date value
		require
			is_xpath_date_value: is_xpath_date
		local
			v: detachable ST_XPATH_DATE_VALUE
		do
			check
					-- Fool the compiler for void-safety purpose
				should_not_occur: v /= Void
			then
				Result := v
			end
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_xpath_date_time: ST_XPATH_DATE_TIME_VALUE
			-- `Current' seen as a date-time value
		require
			is_xpath_date_time_value: is_xpath_date_time
		local
			v: detachable ST_XPATH_DATE_TIME_VALUE
		do
			check
					-- Fool the compiler for void-safety purpose
				should_not_occur: v /= Void
			then
				Result := v
			end
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

invariant

	time_or_date_or_date_time: BOOLEAN_.nxor (<<is_xpath_time, is_xpath_date, is_xpath_date_time>>)

end
