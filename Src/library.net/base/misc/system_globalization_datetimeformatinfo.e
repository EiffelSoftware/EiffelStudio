indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Globalization.DateTimeFormatInfo"

frozen external class
	SYSTEM_GLOBALIZATION_DATETIMEFORMATINFO

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_ICLONEABLE
	SYSTEM_IFORMATPROVIDER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Globalization.DateTimeFormatInfo"
		end

feature -- Access

	frozen get_day_names: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Globalization.DateTimeFormatInfo"
		alias
			"get_DayNames"
		end

	frozen get_month_day_pattern: STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_MonthDayPattern"
		end

	frozen get_date_separator: STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_DateSeparator"
		end

	frozen get_calendar_week_rule: INTEGER is
		external
			"IL signature (): enum System.Globalization.CalendarWeekRule use System.Globalization.DateTimeFormatInfo"
		alias
			"get_CalendarWeekRule"
		ensure
			valid_calendar_week_rule: Result = 0 or Result = 1 or Result = 2
		end

	frozen get_calendar: SYSTEM_GLOBALIZATION_CALENDAR is
		external
			"IL signature (): System.Globalization.Calendar use System.Globalization.DateTimeFormatInfo"
		alias
			"get_Calendar"
		end

	frozen get_abbreviated_day_names: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Globalization.DateTimeFormatInfo"
		alias
			"get_AbbreviatedDayNames"
		end

	frozen get_abbreviated_month_names: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Globalization.DateTimeFormatInfo"
		alias
			"get_AbbreviatedMonthNames"
		end

	frozen get_short_time_pattern: STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_ShortTimePattern"
		end

	frozen get_first_day_of_week: INTEGER is
		external
			"IL signature (): enum System.DayOfWeek use System.Globalization.DateTimeFormatInfo"
		alias
			"get_FirstDayOfWeek"
		ensure
			valid_day_of_week: Result = 0 or Result = 1 or Result = 2 or Result = 3 or Result = 4 or Result = 5 or Result = 6
		end

	frozen get_long_time_pattern: STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_LongTimePattern"
		end

	frozen get_full_date_time_pattern: STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_FullDateTimePattern"
		end

	frozen get_pmdesignator: STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_PMDesignator"
		end

	frozen get_long_date_pattern: STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_LongDatePattern"
		end

	frozen get_time_separator: STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_TimeSeparator"
		end

	frozen get_universal_sortable_date_time_pattern: STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_UniversalSortableDateTimePattern"
		end

	frozen get_year_month_pattern: STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_YearMonthPattern"
		end

	frozen get_month_names: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Globalization.DateTimeFormatInfo"
		alias
			"get_MonthNames"
		end

	frozen get_sortable_date_time_pattern: STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_SortableDateTimePattern"
		end

	frozen get_current_info: SYSTEM_GLOBALIZATION_DATETIMEFORMATINFO is
		external
			"IL static signature (): System.Globalization.DateTimeFormatInfo use System.Globalization.DateTimeFormatInfo"
		alias
			"get_CurrentInfo"
		end

	frozen get_amdesignator: STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_AMDesignator"
		end

	frozen get_rfc1123_pattern: STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"get_RFC1123Pattern"
		end

	frozen get_short_date_pattern: STRING is
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

	frozen get_invariant_info: SYSTEM_GLOBALIZATION_DATETIMEFORMATINFO is
		external
			"IL static signature (): System.Globalization.DateTimeFormatInfo use System.Globalization.DateTimeFormatInfo"
		alias
			"get_InvariantInfo"
		end

feature -- Element Change

	frozen set_date_separator (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_DateSeparator"
		end

	frozen set_month_day_pattern (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_MonthDayPattern"
		end

	frozen set_abbreviated_month_names (value: ARRAY [STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_AbbreviatedMonthNames"
		end

	frozen set_long_time_pattern (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_LongTimePattern"
		end

	frozen set_time_separator (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_TimeSeparator"
		end

	frozen set_abbreviated_day_names (value: ARRAY [STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_AbbreviatedDayNames"
		end

	frozen set_amdesignator (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_AMDesignator"
		end

	frozen set_day_names (value: ARRAY [STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_DayNames"
		end

	frozen set_year_month_pattern (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_YearMonthPattern"
		end

	frozen set_month_names (value: ARRAY [STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_MonthNames"
		end

	frozen set_short_date_pattern (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_ShortDatePattern"
		end

	frozen set_calendar (value: SYSTEM_GLOBALIZATION_CALENDAR) is
		external
			"IL signature (System.Globalization.Calendar): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_Calendar"
		end

	frozen set_calendar_week_rule (value: INTEGER) is
			-- Valid values for `value' are:
			-- FirstDay = 0
			-- FirstFullWeek = 1
			-- FirstFourDayWeek = 2
		require
			valid_calendar_week_rule: value = 0 or value = 1 or value = 2
		external
			"IL signature (enum System.Globalization.CalendarWeekRule): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_CalendarWeekRule"
		end

	frozen set_pmdesignator (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_PMDesignator"
		end

	frozen set_short_time_pattern (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_ShortTimePattern"
		end

	frozen set_first_day_of_week (value: INTEGER) is
			-- Valid values for `value' are:
			-- Sunday = 0
			-- Monday = 1
			-- Tuesday = 2
			-- Wednesday = 3
			-- Thursday = 4
			-- Friday = 5
			-- Saturday = 6
		require
			valid_day_of_week: value = 0 or value = 1 or value = 2 or value = 3 or value = 4 or value = 5 or value = 6
		external
			"IL signature (enum System.DayOfWeek): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_FirstDayOfWeek"
		end

	frozen set_long_date_pattern (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_LongDatePattern"
		end

	frozen set_full_date_time_pattern (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.DateTimeFormatInfo"
		alias
			"set_FullDateTimePattern"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"ToString"
		end

	frozen get_all_date_time_patterns: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Globalization.DateTimeFormatInfo"
		alias
			"GetAllDateTimePatterns"
		end

	frozen clone: ANY is
		external
			"IL signature (): System.Object use System.Globalization.DateTimeFormatInfo"
		alias
			"Clone"
		end

	frozen get_month_name (month: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"GetMonthName"
		end

	frozen get_format (format_type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.Type): System.Object use System.Globalization.DateTimeFormatInfo"
		alias
			"GetFormat"
		end

	frozen get_all_date_time_patterns_char (format: CHARACTER): ARRAY [STRING] is
		external
			"IL signature (System.Char): System.String[] use System.Globalization.DateTimeFormatInfo"
		alias
			"GetAllDateTimePatterns"
		end

	frozen get_abbreviated_month_name (month: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"GetAbbreviatedMonthName"
		end

	frozen get_era (era_name: STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Globalization.DateTimeFormatInfo"
		alias
			"GetEra"
		end

	frozen get_instance (provider: SYSTEM_IFORMATPROVIDER): SYSTEM_GLOBALIZATION_DATETIMEFORMATINFO is
		external
			"IL static signature (System.IFormatProvider): System.Globalization.DateTimeFormatInfo use System.Globalization.DateTimeFormatInfo"
		alias
			"GetInstance"
		end

	frozen read_only (dtfi: SYSTEM_GLOBALIZATION_DATETIMEFORMATINFO): SYSTEM_GLOBALIZATION_DATETIMEFORMATINFO is
		external
			"IL static signature (System.Globalization.DateTimeFormatInfo): System.Globalization.DateTimeFormatInfo use System.Globalization.DateTimeFormatInfo"
		alias
			"ReadOnly"
		end

	frozen get_era_name (era: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"GetEraName"
		end

	frozen get_abbreviated_day_name (dayofweek: INTEGER): STRING is
			-- Valid values for `dayofweek' are:
			-- Sunday = 0
			-- Monday = 1
			-- Tuesday = 2
			-- Wednesday = 3
			-- Thursday = 4
			-- Friday = 5
			-- Saturday = 6
		require
			valid_day_of_week: dayofweek = 0 or dayofweek = 1 or dayofweek = 2 or dayofweek = 3 or dayofweek = 4 or dayofweek = 5 or dayofweek = 6
		external
			"IL signature (enum System.DayOfWeek): System.String use System.Globalization.DateTimeFormatInfo"
		alias
			"GetAbbreviatedDayName"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Globalization.DateTimeFormatInfo"
		alias
			"Equals"
		end

	frozen get_day_name (dayofweek: INTEGER): STRING is
			-- Valid values for `dayofweek' are:
			-- Sunday = 0
			-- Monday = 1
			-- Tuesday = 2
			-- Wednesday = 3
			-- Thursday = 4
			-- Friday = 5
			-- Saturday = 6
		require
			valid_day_of_week: dayofweek = 0 or dayofweek = 1 or dayofweek = 2 or dayofweek = 3 or dayofweek = 4 or dayofweek = 5 or dayofweek = 6
		external
			"IL signature (enum System.DayOfWeek): System.String use System.Globalization.DateTimeFormatInfo"
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

end -- class SYSTEM_GLOBALIZATION_DATETIMEFORMATINFO
