indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.DateTime"

frozen expanded external class
	SYSTEM_DATETIME

inherit
	SYSTEM_VALUETYPE
		redefine
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_ICOMPARABLE
	SYSTEM_IFORMATTABLE



feature {NONE} -- Initialization

	frozen make_datetime_3 (year: INTEGER; month: INTEGER; day: INTEGER; hour: INTEGER; minute: INTEGER; second: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32) use System.DateTime"
		end

	frozen make_datetime_2 (year: INTEGER; month: INTEGER; day: INTEGER; calendar: SYSTEM_GLOBALIZATION_CALENDAR) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32, System.Globalization.Calendar) use System.DateTime"
		end

	frozen make_datetime_5 (year: INTEGER; month: INTEGER; day: INTEGER; hour: INTEGER; minute: INTEGER; second: INTEGER; millisecond: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32) use System.DateTime"
		end

	frozen make_datetime_4 (year: INTEGER; month: INTEGER; day: INTEGER; hour: INTEGER; minute: INTEGER; second: INTEGER; calendar: SYSTEM_GLOBALIZATION_CALENDAR) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Globalization.Calendar) use System.DateTime"
		end

	frozen make_datetime (ticks: INTEGER_64) is
		external
			"IL creator signature (System.Int64) use System.DateTime"
		end

	frozen make_datetime_6 (year: INTEGER; month: INTEGER; day: INTEGER; hour: INTEGER; minute: INTEGER; second: INTEGER; millisecond: INTEGER; calendar: SYSTEM_GLOBALIZATION_CALENDAR) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Globalization.Calendar) use System.DateTime"
		end

	frozen make_datetime_1 (year: INTEGER; month: INTEGER; day: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32) use System.DateTime"
		end

feature -- Access

	frozen get_utc_now: SYSTEM_DATETIME is
		external
			"IL static signature (): System.DateTime use System.DateTime"
		alias
			"get_UtcNow"
		end

	frozen get_second: INTEGER is
		external
			"IL signature (): System.Int32 use System.DateTime"
		alias
			"get_Second"
		end

	frozen get_month: INTEGER is
		external
			"IL signature (): System.Int32 use System.DateTime"
		alias
			"get_Month"
		end

	frozen get_day_of_year: INTEGER is
		external
			"IL signature (): System.Int32 use System.DateTime"
		alias
			"get_DayOfYear"
		end

	frozen get_date: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.DateTime"
		alias
			"get_Date"
		end

	frozen get_ticks: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.DateTime"
		alias
			"get_Ticks"
		end

	frozen get_time_of_day: SYSTEM_TIMESPAN is
		external
			"IL signature (): System.TimeSpan use System.DateTime"
		alias
			"get_TimeOfDay"
		end

	frozen get_millisecond: INTEGER is
		external
			"IL signature (): System.Int32 use System.DateTime"
		alias
			"get_Millisecond"
		end

	frozen get_now: SYSTEM_DATETIME is
		external
			"IL static signature (): System.DateTime use System.DateTime"
		alias
			"get_Now"
		end

	frozen get_today: SYSTEM_DATETIME is
		external
			"IL static signature (): System.DateTime use System.DateTime"
		alias
			"get_Today"
		end

	frozen get_hour: INTEGER is
		external
			"IL signature (): System.Int32 use System.DateTime"
		alias
			"get_Hour"
		end

	frozen min_value: SYSTEM_DATETIME is
		external
			"IL static_field signature :System.DateTime use System.DateTime"
		alias
			"MinValue"
		end

	frozen get_minute: INTEGER is
		external
			"IL signature (): System.Int32 use System.DateTime"
		alias
			"get_Minute"
		end

	frozen max_value: SYSTEM_DATETIME is
		external
			"IL static_field signature :System.DateTime use System.DateTime"
		alias
			"MaxValue"
		end

	frozen get_year: INTEGER is
		external
			"IL signature (): System.Int32 use System.DateTime"
		alias
			"get_Year"
		end

	frozen get_day_of_week: INTEGER is
		external
			"IL signature (): enum System.DayOfWeek use System.DateTime"
		alias
			"get_DayOfWeek"
		ensure
			valid_day_of_week: Result = 0 or Result = 1 or Result = 2 or Result = 3 or Result = 4 or Result = 5 or Result = 6
		end

	frozen get_day: INTEGER is
		external
			"IL signature (): System.Int32 use System.DateTime"
		alias
			"get_Day"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.DateTime"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.DateTime"
		alias
			"ToString"
		end

	frozen get_date_time_formats: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.DateTime"
		alias
			"GetDateTimeFormats"
		end

	frozen to_universal_time: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.DateTime"
		alias
			"ToUniversalTime"
		end

	frozen add_months (months: INTEGER): SYSTEM_DATETIME is
		external
			"IL signature (System.Int32): System.DateTime use System.DateTime"
		alias
			"AddMonths"
		end

	frozen parse_exact (s: STRING; format: STRING; provider: SYSTEM_IFORMATPROVIDER): SYSTEM_DATETIME is
		external
			"IL static signature (System.String, System.String, System.IFormatProvider): System.DateTime use System.DateTime"
		alias
			"ParseExact"
		end

	frozen to_string_with_format (format: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.DateTime"
		alias
			"ToString"
		end

	frozen to_oadate: DOUBLE is
		external
			"IL signature (): System.Double use System.DateTime"
		alias
			"ToOADate"
		end

	frozen to_string_with_provider (provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL signature (System.IFormatProvider): System.String use System.DateTime"
		alias
			"ToString"
		end

	frozen to_short_time_string: STRING is
		external
			"IL signature (): System.String use System.DateTime"
		alias
			"ToShortTimeString"
		end

	frozen parse (s: STRING): SYSTEM_DATETIME is
		external
			"IL static signature (System.String): System.DateTime use System.DateTime"
		alias
			"Parse"
		end

	frozen from_oadate (d: DOUBLE): SYSTEM_DATETIME is
		external
			"IL static signature (System.Double): System.DateTime use System.DateTime"
		alias
			"FromOADate"
		end

	frozen parse_exact_string_string_iformat_provider_date_time_styles (s: STRING; format: STRING; provider: SYSTEM_IFORMATPROVIDER; style: INTEGER): SYSTEM_DATETIME is
			-- Valid values for `style' are a combination of the following values:
			-- None = 0
			-- AllowLeadingWhite = 1
			-- AllowTrailingWhite = 2
			-- AllowInnerWhite = 4
			-- AllowWhiteSpaces = 7
			-- NoCurrentDateDefault = 8
		require
			valid_date_time_styles: (0 + 1 + 2 + 4 + 7 + 8) & style = 0 + 1 + 2 + 4 + 7 + 8
		external
			"IL static signature (System.String, System.String, System.IFormatProvider, enum System.Globalization.DateTimeStyles): System.DateTime use System.DateTime"
		alias
			"ParseExact"
		end

	frozen to_local_time: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.DateTime"
		alias
			"ToLocalTime"
		end

	frozen subtract_date_time (value: SYSTEM_DATETIME): SYSTEM_TIMESPAN is
		external
			"IL signature (System.DateTime): System.TimeSpan use System.DateTime"
		alias
			"Subtract"
		end

	frozen from_file_time (file_time: INTEGER_64): SYSTEM_DATETIME is
		external
			"IL static signature (System.Int64): System.DateTime use System.DateTime"
		alias
			"FromFileTime"
		end

	frozen parse_string_iformat_provider_date_time_styles (s: STRING; provider: SYSTEM_IFORMATPROVIDER; styles: INTEGER): SYSTEM_DATETIME is
			-- Valid values for `styles' are a combination of the following values:
			-- None = 0
			-- AllowLeadingWhite = 1
			-- AllowTrailingWhite = 2
			-- AllowInnerWhite = 4
			-- AllowWhiteSpaces = 7
			-- NoCurrentDateDefault = 8
		require
			valid_date_time_styles: (0 + 1 + 2 + 4 + 7 + 8) & styles = 0 + 1 + 2 + 4 + 7 + 8
		external
			"IL static signature (System.String, System.IFormatProvider, enum System.Globalization.DateTimeStyles): System.DateTime use System.DateTime"
		alias
			"Parse"
		end

	frozen is_leap_year (year: INTEGER): BOOLEAN is
		external
			"IL static signature (System.Int32): System.Boolean use System.DateTime"
		alias
			"IsLeapYear"
		end

	frozen to_short_date_string: STRING is
		external
			"IL signature (): System.String use System.DateTime"
		alias
			"ToShortDateString"
		end

	frozen add_years (value: INTEGER): SYSTEM_DATETIME is
		external
			"IL signature (System.Int32): System.DateTime use System.DateTime"
		alias
			"AddYears"
		end

	frozen get_date_time_formats_char (format: CHARACTER): ARRAY [STRING] is
		external
			"IL signature (System.Char): System.String[] use System.DateTime"
		alias
			"GetDateTimeFormats"
		end

	frozen add_days (value: DOUBLE): SYSTEM_DATETIME is
		external
			"IL signature (System.Double): System.DateTime use System.DateTime"
		alias
			"AddDays"
		end

	frozen to_file_time: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.DateTime"
		alias
			"ToFileTime"
		end

	frozen add (value: SYSTEM_TIMESPAN): SYSTEM_DATETIME is
		external
			"IL signature (System.TimeSpan): System.DateTime use System.DateTime"
		alias
			"Add"
		end

	frozen add_seconds (value: DOUBLE): SYSTEM_DATETIME is
		external
			"IL signature (System.Double): System.DateTime use System.DateTime"
		alias
			"AddSeconds"
		end

	frozen to_long_time_string: STRING is
		external
			"IL signature (): System.String use System.DateTime"
		alias
			"ToLongTimeString"
		end

	frozen add_hours (value: DOUBLE): SYSTEM_DATETIME is
		external
			"IL signature (System.Double): System.DateTime use System.DateTime"
		alias
			"AddHours"
		end

	frozen subtract (value: SYSTEM_TIMESPAN): SYSTEM_DATETIME is
		external
			"IL signature (System.TimeSpan): System.DateTime use System.DateTime"
		alias
			"Subtract"
		end

	frozen compare (t1: SYSTEM_DATETIME; t2: SYSTEM_DATETIME): INTEGER is
		external
			"IL static signature (System.DateTime, System.DateTime): System.Int32 use System.DateTime"
		alias
			"Compare"
		end

	frozen add_ticks (value: INTEGER_64): SYSTEM_DATETIME is
		external
			"IL signature (System.Int64): System.DateTime use System.DateTime"
		alias
			"AddTicks"
		end

	frozen parse_string_iformat_provider (s: STRING; provider: SYSTEM_IFORMATPROVIDER): SYSTEM_DATETIME is
		external
			"IL static signature (System.String, System.IFormatProvider): System.DateTime use System.DateTime"
		alias
			"Parse"
		end

	frozen to_string_with_format_and_provider (format: STRING; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL signature (System.String, System.IFormatProvider): System.String use System.DateTime"
		alias
			"ToString"
		end

	frozen get_type_code: INTEGER is
		external
			"IL signature (): enum System.TypeCode use System.DateTime"
		alias
			"GetTypeCode"
		ensure
			valid_type_code: Result = 0 or Result = 1 or Result = 2 or Result = 3 or Result = 4 or Result = 5 or Result = 6 or Result = 7 or Result = 8 or Result = 9 or Result = 10 or Result = 11 or Result = 12 or Result = 13 or Result = 14 or Result = 15 or Result = 16 or Result = 18
		end

	is_equal (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.DateTime"
		alias
			"Equals"
		end

	frozen add_minutes (value: DOUBLE): SYSTEM_DATETIME is
		external
			"IL signature (System.Double): System.DateTime use System.DateTime"
		alias
			"AddMinutes"
		end

	frozen days_in_month (year: INTEGER; month: INTEGER): INTEGER is
		external
			"IL static signature (System.Int32, System.Int32): System.Int32 use System.DateTime"
		alias
			"DaysInMonth"
		end

	frozen compare_to (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.DateTime"
		alias
			"CompareTo"
		end

	frozen add_milliseconds (value: DOUBLE): SYSTEM_DATETIME is
		external
			"IL signature (System.Double): System.DateTime use System.DateTime"
		alias
			"AddMilliseconds"
		end

	frozen parse_exact_string_array_string (s: STRING; formats: ARRAY [STRING]; provider: SYSTEM_IFORMATPROVIDER; style: INTEGER): SYSTEM_DATETIME is
			-- Valid values for `style' are a combination of the following values:
			-- None = 0
			-- AllowLeadingWhite = 1
			-- AllowTrailingWhite = 2
			-- AllowInnerWhite = 4
			-- AllowWhiteSpaces = 7
			-- NoCurrentDateDefault = 8
		require
			valid_date_time_styles: (0 + 1 + 2 + 4 + 7 + 8) & style = 0 + 1 + 2 + 4 + 7 + 8
		external
			"IL static signature (System.String, System.String[], System.IFormatProvider, enum System.Globalization.DateTimeStyles): System.DateTime use System.DateTime"
		alias
			"ParseExact"
		end

	frozen to_long_date_string: STRING is
		external
			"IL signature (): System.String use System.DateTime"
		alias
			"ToLongDateString"
		end

	frozen get_date_time_formats_iformat_provider (provider: SYSTEM_IFORMATPROVIDER): ARRAY [STRING] is
		external
			"IL signature (System.IFormatProvider): System.String[] use System.DateTime"
		alias
			"GetDateTimeFormats"
		end

	frozen get_date_time_formats_char_iformat_provider (format: CHARACTER; provider: SYSTEM_IFORMATPROVIDER): ARRAY [STRING] is
		external
			"IL signature (System.Char, System.IFormatProvider): System.String[] use System.DateTime"
		alias
			"GetDateTimeFormats"
		end

	frozen equals_date_time (t1: SYSTEM_DATETIME; t2: SYSTEM_DATETIME): BOOLEAN is
		external
			"IL static signature (System.DateTime, System.DateTime): System.Boolean use System.DateTime"
		alias
			"Equals"
		end

feature -- Binary Operators

	frozen infix "+" (t: SYSTEM_TIMESPAN): SYSTEM_DATETIME is
		external
			"IL operator signature (System.TimeSpan): System.DateTime use System.DateTime"
		alias
			"op_Addition"
		end

	frozen infix "|=" (d2: SYSTEM_DATETIME): BOOLEAN is
		external
			"IL operator signature (System.DateTime): System.Boolean use System.DateTime"
		alias
			"op_Inequality"
		end

	frozen infix ">=" (t2: SYSTEM_DATETIME): BOOLEAN is
		external
			"IL operator signature (System.DateTime): System.Boolean use System.DateTime"
		alias
			"op_GreaterThanOrEqual"
		end

	frozen infix "#==" (d2: SYSTEM_DATETIME): BOOLEAN is
		external
			"IL operator signature (System.DateTime): System.Boolean use System.DateTime"
		alias
			"op_Equality"
		end

	frozen op_subtraction_date_time_time_span (t: SYSTEM_TIMESPAN): SYSTEM_DATETIME is
		external
			"IL operator signature (System.TimeSpan): System.DateTime use System.DateTime"
		alias
			"op_Subtraction"
		end

	frozen infix "<=" (t2: SYSTEM_DATETIME): BOOLEAN is
		external
			"IL operator signature (System.DateTime): System.Boolean use System.DateTime"
		alias
			"op_LessThanOrEqual"
		end

	frozen infix "<" (t2: SYSTEM_DATETIME): BOOLEAN is
		external
			"IL operator signature (System.DateTime): System.Boolean use System.DateTime"
		alias
			"op_LessThan"
		end

	frozen infix ">" (t2: SYSTEM_DATETIME): BOOLEAN is
		external
			"IL operator signature (System.DateTime): System.Boolean use System.DateTime"
		alias
			"op_GreaterThan"
		end

	frozen infix "-" (d2: SYSTEM_DATETIME): SYSTEM_TIMESPAN is
		external
			"IL operator signature (System.DateTime): System.TimeSpan use System.DateTime"
		alias
			"op_Subtraction"
		end

end -- class SYSTEM_DATETIME
