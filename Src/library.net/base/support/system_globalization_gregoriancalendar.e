indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Globalization.GregorianCalendar"

external class
	SYSTEM_GLOBALIZATION_GREGORIANCALENDAR

inherit
	SYSTEM_GLOBALIZATION_CALENDAR
		redefine
			to_four_digit_year,
			set_two_digit_year_max,
			get_two_digit_year_max,
			add_weeks
		end

create
	make_gregoriancalendar_1,
	make_gregoriancalendar

feature {NONE} -- Initialization

	frozen make_gregoriancalendar_1 (type: SYSTEM_GLOBALIZATION_GREGORIANCALENDARTYPES) is
		external
			"IL creator signature (System.Globalization.GregorianCalendarTypes) use System.Globalization.GregorianCalendar"
		end

	frozen make_gregoriancalendar is
		external
			"IL creator use System.Globalization.GregorianCalendar"
		end

feature -- Access

	get_calendar_type: SYSTEM_GLOBALIZATION_GREGORIANCALENDARTYPES is
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

	get_eras: ARRAY [INTEGER] is
		external
			"IL signature (): System.Int32[] use System.Globalization.GregorianCalendar"
		alias
			"get_Eras"
		end

	frozen adera: INTEGER is 0x1

feature -- Element Change

	set_calendar_type (value: SYSTEM_GLOBALIZATION_GREGORIANCALENDARTYPES) is
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

	get_month (time: SYSTEM_DATETIME): INTEGER is
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

	get_era (time: SYSTEM_DATETIME): INTEGER is
		external
			"IL signature (System.DateTime): System.Int32 use System.Globalization.GregorianCalendar"
		alias
			"GetEra"
		end

	get_day_of_month (time: SYSTEM_DATETIME): INTEGER is
		external
			"IL signature (System.DateTime): System.Int32 use System.Globalization.GregorianCalendar"
		alias
			"GetDayOfMonth"
		end

	get_year (time: SYSTEM_DATETIME): INTEGER is
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

	to_date_time_int32_int32_int32_int32_int32_int32_int32_int32 (year: INTEGER; month: INTEGER; day: INTEGER; hour: INTEGER; minute: INTEGER; second: INTEGER; millisecond: INTEGER; era: INTEGER): SYSTEM_DATETIME is
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

	add_months (time: SYSTEM_DATETIME; months: INTEGER): SYSTEM_DATETIME is
		external
			"IL signature (System.DateTime, System.Int32): System.DateTime use System.Globalization.GregorianCalendar"
		alias
			"AddMonths"
		end

	get_day_of_week (time: SYSTEM_DATETIME): SYSTEM_DAYOFWEEK is
		external
			"IL signature (System.DateTime): System.DayOfWeek use System.Globalization.GregorianCalendar"
		alias
			"GetDayOfWeek"
		end

	add_weeks (time: SYSTEM_DATETIME; weeks: INTEGER): SYSTEM_DATETIME is
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

	add_years (time: SYSTEM_DATETIME; years: INTEGER): SYSTEM_DATETIME is
		external
			"IL signature (System.DateTime, System.Int32): System.DateTime use System.Globalization.GregorianCalendar"
		alias
			"AddYears"
		end

	get_day_of_year (time: SYSTEM_DATETIME): INTEGER is
		external
			"IL signature (System.DateTime): System.Int32 use System.Globalization.GregorianCalendar"
		alias
			"GetDayOfYear"
		end

end -- class SYSTEM_GLOBALIZATION_GREGORIANCALENDAR
