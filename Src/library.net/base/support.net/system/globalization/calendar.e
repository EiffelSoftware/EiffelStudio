indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Globalization.Calendar"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	CALENDAR

inherit
	SYSTEM_OBJECT

feature -- Access

	get_eras: NATIVE_ARRAY [INTEGER] is
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

	add_months (time: SYSTEM_DATE_TIME; months: INTEGER): SYSTEM_DATE_TIME is
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

	add_years (time: SYSTEM_DATE_TIME; years: INTEGER): SYSTEM_DATE_TIME is
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

	get_era (time: SYSTEM_DATE_TIME): INTEGER is
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

	get_milliseconds (time: SYSTEM_DATE_TIME): DOUBLE is
		external
			"IL signature (System.DateTime): System.Double use System.Globalization.Calendar"
		alias
			"GetMilliseconds"
		end

	get_hour (time: SYSTEM_DATE_TIME): INTEGER is
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

	add_minutes (time: SYSTEM_DATE_TIME; minutes: INTEGER): SYSTEM_DATE_TIME is
		external
			"IL signature (System.DateTime, System.Int32): System.DateTime use System.Globalization.Calendar"
		alias
			"AddMinutes"
		end

	get_month (time: SYSTEM_DATE_TIME): INTEGER is
		external
			"IL deferred signature (System.DateTime): System.Int32 use System.Globalization.Calendar"
		alias
			"GetMonth"
		end

	get_second (time: SYSTEM_DATE_TIME): INTEGER is
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

	get_year (time: SYSTEM_DATE_TIME): INTEGER is
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

	get_day_of_year (time: SYSTEM_DATE_TIME): INTEGER is
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

	add_days (time: SYSTEM_DATE_TIME; days: INTEGER): SYSTEM_DATE_TIME is
		external
			"IL signature (System.DateTime, System.Int32): System.DateTime use System.Globalization.Calendar"
		alias
			"AddDays"
		end

	add_hours (time: SYSTEM_DATE_TIME; hours: INTEGER): SYSTEM_DATE_TIME is
		external
			"IL signature (System.DateTime, System.Int32): System.DateTime use System.Globalization.Calendar"
		alias
			"AddHours"
		end

	add_milliseconds (time: SYSTEM_DATE_TIME; milliseconds: DOUBLE): SYSTEM_DATE_TIME is
		external
			"IL signature (System.DateTime, System.Double): System.DateTime use System.Globalization.Calendar"
		alias
			"AddMilliseconds"
		end

	add_seconds (time: SYSTEM_DATE_TIME; seconds: INTEGER): SYSTEM_DATE_TIME is
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

	get_day_of_week (time: SYSTEM_DATE_TIME): DAY_OF_WEEK is
		external
			"IL deferred signature (System.DateTime): System.DayOfWeek use System.Globalization.Calendar"
		alias
			"GetDayOfWeek"
		end

	to_date_time_int32_int32_int32_int32_int32_int32_int32_int32 (year: INTEGER; month: INTEGER; day: INTEGER; hour: INTEGER; minute: INTEGER; second: INTEGER; millisecond: INTEGER; era: INTEGER): SYSTEM_DATE_TIME is
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

	to_date_time (year: INTEGER; month: INTEGER; day: INTEGER; hour: INTEGER; minute: INTEGER; second: INTEGER; millisecond: INTEGER): SYSTEM_DATE_TIME is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32): System.DateTime use System.Globalization.Calendar"
		alias
			"ToDateTime"
		end

	get_week_of_year (time: SYSTEM_DATE_TIME; rule: CALENDAR_WEEK_RULE; first_day_of_week: DAY_OF_WEEK): INTEGER is
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

	get_day_of_month (time: SYSTEM_DATE_TIME): INTEGER is
		external
			"IL deferred signature (System.DateTime): System.Int32 use System.Globalization.Calendar"
		alias
			"GetDayOfMonth"
		end

	get_minute (time: SYSTEM_DATE_TIME): INTEGER is
		external
			"IL signature (System.DateTime): System.Int32 use System.Globalization.Calendar"
		alias
			"GetMinute"
		end

	add_weeks (time: SYSTEM_DATE_TIME; weeks: INTEGER): SYSTEM_DATE_TIME is
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

end -- class CALENDAR
