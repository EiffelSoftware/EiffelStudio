indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Globalization.GregorianCalendar"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	GREGORIAN_CALENDAR

inherit
	CALENDAR
		redefine
			to_four_digit_year,
			set_two_digit_year_max,
			get_two_digit_year_max,
			add_weeks
		end

create
	make_gregorian_calendar_1,
	make_gregorian_calendar

feature {NONE} -- Initialization

	frozen make_gregorian_calendar_1 (type: GREGORIAN_CALENDAR_TYPES) is
		external
			"IL creator signature (System.Globalization.GregorianCalendarTypes) use System.Globalization.GregorianCalendar"
		end

	frozen make_gregorian_calendar is
		external
			"IL creator use System.Globalization.GregorianCalendar"
		end

feature -- Access

	get_calendar_type: GREGORIAN_CALENDAR_TYPES is
		external
			"IL signature (): System.Globalization.GregorianCalendarTypes use System.Globalization.GregorianCalendar"
		alias
			"get_CalendarType"
		end

	get_two_digit_year_max: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.GregorianCalendar"
		alias
			"get_TwoDigitYearMax"
		end

	get_eras: NATIVE_ARRAY [INTEGER] is
		external
			"IL signature (): System.Int32[] use System.Globalization.GregorianCalendar"
		alias
			"get_Eras"
		end

	frozen adera: INTEGER is 0x1

feature -- Element Change

	set_calendar_type (value: GREGORIAN_CALENDAR_TYPES) is
		external
			"IL signature (System.Globalization.GregorianCalendarTypes): System.Void use System.Globalization.GregorianCalendar"
		alias
			"set_CalendarType"
		end

	set_two_digit_year_max (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Globalization.GregorianCalendar"
		alias
			"set_TwoDigitYearMax"
		end

feature -- Basic Operations

	is_leap_month_int32_int32_int32 (year: INTEGER; month: INTEGER; era: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32, System.Int32): System.Boolean use System.Globalization.GregorianCalendar"
		alias
			"IsLeapMonth"
		end

	get_month (time: SYSTEM_DATE_TIME): INTEGER is
		external
			"IL signature (System.DateTime): System.Int32 use System.Globalization.GregorianCalendar"
		alias
			"GetMonth"
		end

	is_leap_day_int32_int32_int32_int32 (year: INTEGER; month: INTEGER; day: INTEGER; era: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32): System.Boolean use System.Globalization.GregorianCalendar"
		alias
			"IsLeapDay"
		end

	is_leap_year_int32_int32 (year: INTEGER; era: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32): System.Boolean use System.Globalization.GregorianCalendar"
		alias
			"IsLeapYear"
		end

	get_era (time: SYSTEM_DATE_TIME): INTEGER is
		external
			"IL signature (System.DateTime): System.Int32 use System.Globalization.GregorianCalendar"
		alias
			"GetEra"
		end

	get_day_of_month (time: SYSTEM_DATE_TIME): INTEGER is
		external
			"IL signature (System.DateTime): System.Int32 use System.Globalization.GregorianCalendar"
		alias
			"GetDayOfMonth"
		end

	get_year (time: SYSTEM_DATE_TIME): INTEGER is
		external
			"IL signature (System.DateTime): System.Int32 use System.Globalization.GregorianCalendar"
		alias
			"GetYear"
		end

	get_days_in_year_int32_int32 (year: INTEGER; era: INTEGER): INTEGER is
		external
			"IL signature (System.Int32, System.Int32): System.Int32 use System.Globalization.GregorianCalendar"
		alias
			"GetDaysInYear"
		end

	to_date_time_int32_int32_int32_int32_int32_int32_int32_int32 (year: INTEGER; month: INTEGER; day: INTEGER; hour: INTEGER; minute: INTEGER; second: INTEGER; millisecond: INTEGER; era: INTEGER): SYSTEM_DATE_TIME is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32): System.DateTime use System.Globalization.GregorianCalendar"
		alias
			"ToDateTime"
		end

	to_four_digit_year (year: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Globalization.GregorianCalendar"
		alias
			"ToFourDigitYear"
		end

	get_months_in_year_int32_int32 (year: INTEGER; era: INTEGER): INTEGER is
		external
			"IL signature (System.Int32, System.Int32): System.Int32 use System.Globalization.GregorianCalendar"
		alias
			"GetMonthsInYear"
		end

	add_months (time: SYSTEM_DATE_TIME; months: INTEGER): SYSTEM_DATE_TIME is
		external
			"IL signature (System.DateTime, System.Int32): System.DateTime use System.Globalization.GregorianCalendar"
		alias
			"AddMonths"
		end

	get_day_of_week (time: SYSTEM_DATE_TIME): DAY_OF_WEEK is
		external
			"IL signature (System.DateTime): System.DayOfWeek use System.Globalization.GregorianCalendar"
		alias
			"GetDayOfWeek"
		end

	add_weeks (time: SYSTEM_DATE_TIME; weeks: INTEGER): SYSTEM_DATE_TIME is
		external
			"IL signature (System.DateTime, System.Int32): System.DateTime use System.Globalization.GregorianCalendar"
		alias
			"AddWeeks"
		end

	get_days_in_month_int32_int32_int32 (year: INTEGER; month: INTEGER; era: INTEGER): INTEGER is
		external
			"IL signature (System.Int32, System.Int32, System.Int32): System.Int32 use System.Globalization.GregorianCalendar"
		alias
			"GetDaysInMonth"
		end

	add_years (time: SYSTEM_DATE_TIME; years: INTEGER): SYSTEM_DATE_TIME is
		external
			"IL signature (System.DateTime, System.Int32): System.DateTime use System.Globalization.GregorianCalendar"
		alias
			"AddYears"
		end

	get_day_of_year (time: SYSTEM_DATE_TIME): INTEGER is
		external
			"IL signature (System.DateTime): System.Int32 use System.Globalization.GregorianCalendar"
		alias
			"GetDayOfYear"
		end

end -- class GREGORIAN_CALENDAR
