indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Globalization.Calendar"

deferred external class
	SYSTEM_GLOBALIZATION_CALENDAR

feature -- Access

	get_eras: ARRAY [INTEGER] is
		external
			"IL deferred signature (): System.Int32[] use System.Globalization.Calendar"
		alias
			"get_Eras"
		end

	get_two_digit_year_max: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.Calendar"
		alias
			"get_TwoDigitYearMax"
		end

	frozen current_era: INTEGER is 0x0

feature -- Element Change

	set_two_digit_year_max (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Globalization.Calendar"
		alias
			"set_TwoDigitYearMax"
		end

feature -- Basic Operations

	add_months (time: SYSTEM_DATETIME; months: INTEGER): SYSTEM_DATETIME is
		external
			"IL deferred signature (System.DateTime, System.Int32): System.DateTime use System.Globalization.Calendar"
		alias
			"AddMonths"
		end

	is_leap_year_int32_int32 (year: INTEGER; era: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Boolean use System.Globalization.Calendar"
		alias
			"IsLeapYear"
		end

	add_years (time: SYSTEM_DATETIME; years: INTEGER): SYSTEM_DATETIME is
		external
			"IL deferred signature (System.DateTime, System.Int32): System.DateTime use System.Globalization.Calendar"
		alias
			"AddYears"
		end

	is_leap_day_int32_int32_int32_int32 (year: INTEGER; month: INTEGER; day: INTEGER; era: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32, System.Int32, System.Int32, System.Int32): System.Boolean use System.Globalization.Calendar"
		alias
			"IsLeapDay"
		end

	get_era (time: SYSTEM_DATETIME): INTEGER is
		external
			"IL deferred signature (System.DateTime): System.Int32 use System.Globalization.Calendar"
		alias
			"GetEra"
		end

	to_four_digit_year (year: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Globalization.Calendar"
		alias
			"ToFourDigitYear"
		end

	get_milliseconds (time: SYSTEM_DATETIME): DOUBLE is
		external
			"IL signature (System.DateTime): System.Double use System.Globalization.Calendar"
		alias
			"GetMilliseconds"
		end

	get_hour (time: SYSTEM_DATETIME): INTEGER is
		external
			"IL signature (System.DateTime): System.Int32 use System.Globalization.Calendar"
		alias
			"GetHour"
		end

	get_days_in_month (year: INTEGER; month: INTEGER): INTEGER is
		external
			"IL signature (System.Int32, System.Int32): System.Int32 use System.Globalization.Calendar"
		alias
			"GetDaysInMonth"
		end

	add_minutes (time: SYSTEM_DATETIME; minutes: INTEGER): SYSTEM_DATETIME is
		external
			"IL signature (System.DateTime, System.Int32): System.DateTime use System.Globalization.Calendar"
		alias
			"AddMinutes"
		end

	get_month (time: SYSTEM_DATETIME): INTEGER is
		external
			"IL deferred signature (System.DateTime): System.Int32 use System.Globalization.Calendar"
		alias
			"GetMonth"
		end

	get_second (time: SYSTEM_DATETIME): INTEGER is
		external
			"IL signature (System.DateTime): System.Int32 use System.Globalization.Calendar"
		alias
			"GetSecond"
		end

	is_leap_day (year: INTEGER; month: INTEGER; day: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32, System.Int32): System.Boolean use System.Globalization.Calendar"
		alias
			"IsLeapDay"
		end

	get_year (time: SYSTEM_DATETIME): INTEGER is
		external
			"IL deferred signature (System.DateTime): System.Int32 use System.Globalization.Calendar"
		alias
			"GetYear"
		end

	is_leap_month (year: INTEGER; month: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32): System.Boolean use System.Globalization.Calendar"
		alias
			"IsLeapMonth"
		end

	get_months_in_year_int32_int32 (year: INTEGER; era: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Int32 use System.Globalization.Calendar"
		alias
			"GetMonthsInYear"
		end

	get_day_of_year (time: SYSTEM_DATETIME): INTEGER is
		external
			"IL deferred signature (System.DateTime): System.Int32 use System.Globalization.Calendar"
		alias
			"GetDayOfYear"
		end

	get_days_in_year_int32_int32 (year: INTEGER; era: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Int32 use System.Globalization.Calendar"
		alias
			"GetDaysInYear"
		end

	add_days (time: SYSTEM_DATETIME; days: INTEGER): SYSTEM_DATETIME is
		external
			"IL signature (System.DateTime, System.Int32): System.DateTime use System.Globalization.Calendar"
		alias
			"AddDays"
		end

	add_hours (time: SYSTEM_DATETIME; hours: INTEGER): SYSTEM_DATETIME is
		external
			"IL signature (System.DateTime, System.Int32): System.DateTime use System.Globalization.Calendar"
		alias
			"AddHours"
		end

	add_milliseconds (time: SYSTEM_DATETIME; milliseconds: DOUBLE): SYSTEM_DATETIME is
		external
			"IL signature (System.DateTime, System.Double): System.DateTime use System.Globalization.Calendar"
		alias
			"AddMilliseconds"
		end

	add_seconds (time: SYSTEM_DATETIME; seconds: INTEGER): SYSTEM_DATETIME is
		external
			"IL signature (System.DateTime, System.Int32): System.DateTime use System.Globalization.Calendar"
		alias
			"AddSeconds"
		end

	get_days_in_month_int32_int32_int32 (year: INTEGER; month: INTEGER; era: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32, System.Int32, System.Int32): System.Int32 use System.Globalization.Calendar"
		alias
			"GetDaysInMonth"
		end

	get_day_of_week (time: SYSTEM_DATETIME): SYSTEM_DAYOFWEEK is
		external
			"IL deferred signature (System.DateTime): System.DayOfWeek use System.Globalization.Calendar"
		alias
			"GetDayOfWeek"
		end

	to_date_time_int32_int32_int32_int32_int32_int32_int32_int32 (year: INTEGER; month: INTEGER; day: INTEGER; hour: INTEGER; minute: INTEGER; second: INTEGER; millisecond: INTEGER; era: INTEGER): SYSTEM_DATETIME is
		external
			"IL deferred signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32): System.DateTime use System.Globalization.Calendar"
		alias
			"ToDateTime"
		end

	is_leap_month_int32_int32_int32 (year: INTEGER; month: INTEGER; era: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32, System.Int32, System.Int32): System.Boolean use System.Globalization.Calendar"
		alias
			"IsLeapMonth"
		end

	is_leap_year (year: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Globalization.Calendar"
		alias
			"IsLeapYear"
		end

	to_date_time (year: INTEGER; month: INTEGER; day: INTEGER; hour: INTEGER; minute: INTEGER; second: INTEGER; millisecond: INTEGER): SYSTEM_DATETIME is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32): System.DateTime use System.Globalization.Calendar"
		alias
			"ToDateTime"
		end

	get_week_of_year (time: SYSTEM_DATETIME; rule: SYSTEM_GLOBALIZATION_CALENDARWEEKRULE; first_day_of_week: SYSTEM_DAYOFWEEK): INTEGER is
		external
			"IL signature (System.DateTime, System.Globalization.CalendarWeekRule, System.DayOfWeek): System.Int32 use System.Globalization.Calendar"
		alias
			"GetWeekOfYear"
		end

	get_days_in_year (year: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Globalization.Calendar"
		alias
			"GetDaysInYear"
		end

	get_day_of_month (time: SYSTEM_DATETIME): INTEGER is
		external
			"IL deferred signature (System.DateTime): System.Int32 use System.Globalization.Calendar"
		alias
			"GetDayOfMonth"
		end

	get_minute (time: SYSTEM_DATETIME): INTEGER is
		external
			"IL signature (System.DateTime): System.Int32 use System.Globalization.Calendar"
		alias
			"GetMinute"
		end

	add_weeks (time: SYSTEM_DATETIME; weeks: INTEGER): SYSTEM_DATETIME is
		external
			"IL signature (System.DateTime, System.Int32): System.DateTime use System.Globalization.Calendar"
		alias
			"AddWeeks"
		end

	get_months_in_year (year: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Globalization.Calendar"
		alias
			"GetMonthsInYear"
		end

end -- class SYSTEM_GLOBALIZATION_CALENDAR
