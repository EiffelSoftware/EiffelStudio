indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Globalization.DateTimeFormatInfo"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATE_TIME_FORMAT_INFO

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICLONEABLE
	IFORMAT_PROVIDER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Globalization.DateTimeFormatInfo"
		end

feature -- Access

	frozen get_day_names: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Globalization.DateTimeFormatInfo"
		alias
			"get_DayNames"
		end

	frozen get_month_day_pattern: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_MonthDayPattern"
		end

	frozen get_date_separator: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_DateSeparator"
		end

	frozen get_calendar_week_rule: CALENDAR_WEEK_RULE is
		external
			"IL signature (): System.Globalization.CalendarWeekRule use System.Globalization.DateTimeFormatInfo"
		alias
			"get_CalendarWeekRule"
		end

	frozen get_calendar: CALENDAR is
		external
			"IL signature (): System.Globalization.Calendar use System.Globalization.DateTimeFormatInfo"
		alias
			"get_Calendar"
		end

	frozen get_abbreviated_day_names: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Globalization.DateTimeFormatInfo"
		alias
			"get_AbbreviatedDayNames"
		end

	frozen get_abbreviated_month_names: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Globalization.DateTimeFormatInfo"
		alias
			"get_AbbreviatedMonthNames"
		end

	frozen get_short_time_pattern: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_ShortTimePattern"
		end

	frozen get_first_day_of_week: DAY_OF_WEEK is
		external
			"IL signature (): System.DayOfWeek use System.Globalization.DateTimeFormatInfo"
		alias
			"get_FirstDayOfWeek"
		end

	frozen get_long_time_pattern: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_LongTimePattern"
		end

	frozen get_full_date_time_pattern: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_FullDateTimePattern"
		end

	frozen get_pmdesignator: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_PMDesignator"
		end

	frozen get_long_date_pattern: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_LongDatePattern"
		end

	frozen get_time_separator: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_TimeSeparator"
		end

	frozen get_universal_sortable_date_time_pattern: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_UniversalSortableDateTimePattern"
		end

	frozen get_year_month_pattern: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_YearMonthPattern"
		end

	frozen get_month_names: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Globalization.DateTimeFormatInfo"
		alias
			"get_MonthNames"
		end

	frozen get_sortable_date_time_pattern: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_SortableDateTimePattern"
		end

	frozen get_current_info: DATE_TIME_FORMAT_INFO is
		external
			"IL static signature (): System.Globalization.DateTimeFormatInfo use System.Globalization.DateTimeFormatInfo"
		alias
			"get_CurrentInfo"
		end

	frozen get_amdesignator: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_AMDesignator"
		end

	frozen get_rfc1123_pattern: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_RFC1123Pattern"
		end

	frozen get_short_date_pattern: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_ShortDatePattern"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Globalization.DateTimeFormatInfo"
		alias
			"get_IsReadOnly"
		end

	frozen get_invariant_info: DATE_TIME_FORMAT_INFO is
		external
			"IL static signature (): System.Globalization.DateTimeFormatInfo use System.Globalization.DateTimeFormatInfo"
		alias
			"get_InvariantInfo"
		end

feature -- Element Change

	frozen set_date_separator (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_DateSeparator"
		end

	frozen set_month_day_pattern (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_MonthDayPattern"
		end

	frozen set_abbreviated_month_names (value: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_AbbreviatedMonthNames"
		end

	frozen set_long_time_pattern (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_LongTimePattern"
		end

	frozen set_time_separator (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_TimeSeparator"
		end

	frozen set_abbreviated_day_names (value: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_AbbreviatedDayNames"
		end

	frozen set_amdesignator (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_AMDesignator"
		end

	frozen set_day_names (value: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_DayNames"
		end

	frozen set_year_month_pattern (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_YearMonthPattern"
		end

	frozen set_month_names (value: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_MonthNames"
		end

	frozen set_short_date_pattern (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_ShortDatePattern"
		end

	frozen set_calendar (value: CALENDAR) is
		external
			"IL signature (System.Globalization.Calendar): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_Calendar"
		end

	frozen set_calendar_week_rule (value: CALENDAR_WEEK_RULE) is
		external
			"IL signature (System.Globalization.CalendarWeekRule): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_CalendarWeekRule"
		end

	frozen set_pmdesignator (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_PMDesignator"
		end

	frozen set_short_time_pattern (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_ShortTimePattern"
		end

	frozen set_first_day_of_week (value: DAY_OF_WEEK) is
		external
			"IL signature (System.DayOfWeek): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_FirstDayOfWeek"
		end

	frozen set_long_date_pattern (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_LongDatePattern"
		end

	frozen set_full_date_time_pattern (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_FullDateTimePattern"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"ToString"
		end

	frozen get_abbreviated_era_name (era: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"GetAbbreviatedEraName"
		end

	frozen get_month_name (month: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"GetMonthName"
		end

	frozen get_format (format_type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.Type): System.Object use System.Globalization.DateTimeFormatInfo"
		alias
			"GetFormat"
		end

	frozen clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Globalization.DateTimeFormatInfo"
		alias
			"Clone"
		end

	frozen read_only (dtfi: DATE_TIME_FORMAT_INFO): DATE_TIME_FORMAT_INFO is
		external
			"IL static signature (System.Globalization.DateTimeFormatInfo): System.Globalization.DateTimeFormatInfo use System.Globalization.DateTimeFormatInfo"
		alias
			"ReadOnly"
		end

	frozen get_abbreviated_month_name (month: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"GetAbbreviatedMonthName"
		end

	frozen get_era (era_name: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Globalization.DateTimeFormatInfo"
		alias
			"GetEra"
		end

	frozen get_all_date_time_patterns: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Globalization.DateTimeFormatInfo"
		alias
			"GetAllDateTimePatterns"
		end

	frozen get_instance (provider: IFORMAT_PROVIDER): DATE_TIME_FORMAT_INFO is
		external
			"IL static signature (System.IFormatProvider): System.Globalization.DateTimeFormatInfo use System.Globalization.DateTimeFormatInfo"
		alias
			"GetInstance"
		end

	frozen get_all_date_time_patterns_char (format: CHARACTER): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (System.Char): System.String[] use System.Globalization.DateTimeFormatInfo"
		alias
			"GetAllDateTimePatterns"
		end

	frozen get_era_name (era: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"GetEraName"
		end

	frozen get_abbreviated_day_name (dayofweek: DAY_OF_WEEK): SYSTEM_STRING is
		external
			"IL signature (System.DayOfWeek): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"GetAbbreviatedDayName"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Globalization.DateTimeFormatInfo"
		alias
			"Equals"
		end

	frozen get_day_name (dayofweek: DAY_OF_WEEK): SYSTEM_STRING is
		external
			"IL signature (System.DayOfWeek): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"GetDayName"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.DateTimeFormatInfo"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"Finalize"
		end

end -- class DATE_TIME_FORMAT_INFO
