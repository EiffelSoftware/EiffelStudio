indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Globalization.JulianCalendar"

external class
	SYSTEM_GLOBALIZATION_JULIANCALENDAR

inherit
	SYSTEM_GLOBALIZATION_CALENDAR
		redefine
			to_four_digit_year,
			set_two_digit_year_max,
			get_two_digit_year_max
		end

create
	make_juliancalendar

feature {NONE} -- Initialization

	frozen make_juliancalendar is
		external
			"IL creator use System.Globalization.JulianCalendar"
		end

feature -- Access

	frozen julian_era: INTEGER is
		external
			"IL static_field signature :System.Int32 use System.Globalization.JulianCalendar"
		alias
			"JulianEra"
		end

	get_eras: ARRAY [INTEGER] is
		external
			"IL signature (): System.Int32[] use System.Globalization.JulianCalendar"
		alias
			"get_Eras"
		end

	get_two_digit_year_max: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.JulianCalendar"
		alias
			"get_TwoDigitYearMax"
		end

feature -- Element Change

	set_two_digit_year_max (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Globalization.JulianCalendar"
		alias
			"set_TwoDigitYearMax"
		end

feature -- Basic Operations

	add_years (time: SYSTEM_DATETIME; years: INTEGER): SYSTEM_DATETIME is
		external
			"IL signature (System.DateTime, System.Int32): System.DateTime use System.Globalization.JulianCalendar"
		alias
			"AddYears"
		end

	get_day_of_year (time: SYSTEM_DATETIME): INTEGER is
		external
			"IL signature (System.DateTime): System.Int32 use System.Globalization.JulianCalendar"
		alias
			"GetDayOfYear"
		end

	get_month (time: SYSTEM_DATETIME): INTEGER is
		external
			"IL signature (System.DateTime): System.Int32 use System.Globalization.JulianCalendar"
		alias
			"GetMonth"
		end

	add_months (time: SYSTEM_DATETIME; months: INTEGER): SYSTEM_DATETIME is
		external
			"IL signature (System.DateTime, System.Int32): System.DateTime use System.Globalization.JulianCalendar"
		alias
			"AddMonths"
		end

	is_leap_month_int32_int32_int32 (year: INTEGER; month: INTEGER; era: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32, System.Int32): System.Boolean use System.Globalization.JulianCalendar"
		alias
			"IsLeapMonth"
		end

	is_leap_year_int32_int32 (year: INTEGER; era: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32): System.Boolean use System.Globalization.JulianCalendar"
		alias
			"IsLeapYear"
		end

	get_day_of_week (time: SYSTEM_DATETIME): INTEGER is
		external
			"IL signature (System.DateTime): enum System.DayOfWeek use System.Globalization.JulianCalendar"
		alias
			"GetDayOfWeek"
		end

	get_era (time: SYSTEM_DATETIME): INTEGER is
		external
			"IL signature (System.DateTime): System.Int32 use System.Globalization.JulianCalendar"
		alias
			"GetEra"
		end

	get_day_of_month (time: SYSTEM_DATETIME): INTEGER is
		external
			"IL signature (System.DateTime): System.Int32 use System.Globalization.JulianCalendar"
		alias
			"GetDayOfMonth"
		end

	get_months_in_year_int32_int32 (year: INTEGER; era: INTEGER): INTEGER is
		external
			"IL signature (System.Int32, System.Int32): System.Int32 use System.Globalization.JulianCalendar"
		alias
			"GetMonthsInYear"
		end

	to_date_time_int32_int32_int32_int32_int32_int32_int32_int32 (year: INTEGER; month: INTEGER; day: INTEGER; hour: INTEGER; minute: INTEGER; second: INTEGER; millisecond: INTEGER; era: INTEGER): SYSTEM_DATETIME is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32): System.DateTime use System.Globalization.JulianCalendar"
		alias
			"ToDateTime"
		end

	to_four_digit_year (year: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Globalization.JulianCalendar"
		alias
			"ToFourDigitYear"
		end

	get_year (time: SYSTEM_DATETIME): INTEGER is
		external
			"IL signature (System.DateTime): System.Int32 use System.Globalization.JulianCalendar"
		alias
			"GetYear"
		end

	get_days_in_month_int32_int32_int32 (year: INTEGER; month: INTEGER; era: INTEGER): INTEGER is
		external
			"IL signature (System.Int32, System.Int32, System.Int32): System.Int32 use System.Globalization.JulianCalendar"
		alias
			"GetDaysInMonth"
		end

	get_days_in_year_int32_int32 (year: INTEGER; era: INTEGER): INTEGER is
		external
			"IL signature (System.Int32, System.Int32): System.Int32 use System.Globalization.JulianCalendar"
		alias
			"GetDaysInYear"
		end

	is_leap_day_int32_int32_int32_int32 (year: INTEGER; month: INTEGER; day: INTEGER; era: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32): System.Boolean use System.Globalization.JulianCalendar"
		alias
			"IsLeapDay"
		end

end -- class SYSTEM_GLOBALIZATION_JULIANCALENDAR
