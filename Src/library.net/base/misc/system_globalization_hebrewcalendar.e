indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Globalization.HebrewCalendar"

external class
	SYSTEM_GLOBALIZATION_HEBREWCALENDAR

inherit
	SYSTEM_GLOBALIZATION_CALENDAR
		redefine
			to_four_digit_year,
			set_two_digit_year_max,
			get_two_digit_year_max
		end

create
	make_hebrewcalendar

feature {NONE} -- Initialization

	frozen make_hebrewcalendar is
		external
			"IL creator use System.Globalization.HebrewCalendar"
		end

feature -- Access

	get_eras: ARRAY [INTEGER] is
		external
			"IL signature (): System.Int32[] use System.Globalization.HebrewCalendar"
		alias
			"get_Eras"
		end

	get_two_digit_year_max: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.HebrewCalendar"
		alias
			"get_TwoDigitYearMax"
		end

	frozen hebrew_era: INTEGER is
		external
			"IL static_field signature :System.Int32 use System.Globalization.HebrewCalendar"
		alias
			"HebrewEra"
		end

feature -- Element Change

	set_two_digit_year_max (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Globalization.HebrewCalendar"
		alias
			"set_TwoDigitYearMax"
		end

feature -- Basic Operations

	add_years (time: SYSTEM_DATETIME; years: INTEGER): SYSTEM_DATETIME is
		external
			"IL signature (System.DateTime, System.Int32): System.DateTime use System.Globalization.HebrewCalendar"
		alias
			"AddYears"
		end

	get_day_of_year (time: SYSTEM_DATETIME): INTEGER is
		external
			"IL signature (System.DateTime): System.Int32 use System.Globalization.HebrewCalendar"
		alias
			"GetDayOfYear"
		end

	get_month (time: SYSTEM_DATETIME): INTEGER is
		external
			"IL signature (System.DateTime): System.Int32 use System.Globalization.HebrewCalendar"
		alias
			"GetMonth"
		end

	add_months (time: SYSTEM_DATETIME; months: INTEGER): SYSTEM_DATETIME is
		external
			"IL signature (System.DateTime, System.Int32): System.DateTime use System.Globalization.HebrewCalendar"
		alias
			"AddMonths"
		end

	is_leap_month_int32_int32_int32 (year: INTEGER; month: INTEGER; era: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32, System.Int32): System.Boolean use System.Globalization.HebrewCalendar"
		alias
			"IsLeapMonth"
		end

	is_leap_year_int32_int32 (year: INTEGER; era: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32): System.Boolean use System.Globalization.HebrewCalendar"
		alias
			"IsLeapYear"
		end

	get_day_of_week (time: SYSTEM_DATETIME): INTEGER is
		external
			"IL signature (System.DateTime): enum System.DayOfWeek use System.Globalization.HebrewCalendar"
		alias
			"GetDayOfWeek"
		end

	get_era (time: SYSTEM_DATETIME): INTEGER is
		external
			"IL signature (System.DateTime): System.Int32 use System.Globalization.HebrewCalendar"
		alias
			"GetEra"
		end

	get_day_of_month (time: SYSTEM_DATETIME): INTEGER is
		external
			"IL signature (System.DateTime): System.Int32 use System.Globalization.HebrewCalendar"
		alias
			"GetDayOfMonth"
		end

	get_months_in_year_int32_int32 (year: INTEGER; era: INTEGER): INTEGER is
		external
			"IL signature (System.Int32, System.Int32): System.Int32 use System.Globalization.HebrewCalendar"
		alias
			"GetMonthsInYear"
		end

	to_date_time_int32_int32_int32_int32_int32_int32_int32_int32 (year: INTEGER; month: INTEGER; day: INTEGER; hour: INTEGER; minute: INTEGER; second: INTEGER; millisecond: INTEGER; era: INTEGER): SYSTEM_DATETIME is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32): System.DateTime use System.Globalization.HebrewCalendar"
		alias
			"ToDateTime"
		end

	to_four_digit_year (year: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Globalization.HebrewCalendar"
		alias
			"ToFourDigitYear"
		end

	get_year (time: SYSTEM_DATETIME): INTEGER is
		external
			"IL signature (System.DateTime): System.Int32 use System.Globalization.HebrewCalendar"
		alias
			"GetYear"
		end

	get_days_in_month_int32_int32_int32 (year: INTEGER; month: INTEGER; era: INTEGER): INTEGER is
		external
			"IL signature (System.Int32, System.Int32, System.Int32): System.Int32 use System.Globalization.HebrewCalendar"
		alias
			"GetDaysInMonth"
		end

	get_days_in_year_int32_int32 (year: INTEGER; era: INTEGER): INTEGER is
		external
			"IL signature (System.Int32, System.Int32): System.Int32 use System.Globalization.HebrewCalendar"
		alias
			"GetDaysInYear"
		end

	is_leap_day_int32_int32_int32_int32 (year: INTEGER; month: INTEGER; day: INTEGER; era: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32): System.Boolean use System.Globalization.HebrewCalendar"
		alias
			"IsLeapDay"
		end

end -- class SYSTEM_GLOBALIZATION_HEBREWCALENDAR
