indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.TimeZone"

deferred external class
	SYSTEM_TIMEZONE

feature -- Access

	get_standard_name: STRING is
		external
			"IL deferred signature (): System.String use System.TimeZone"
		alias
			"get_StandardName"
		end

	frozen get_current_time_zone: SYSTEM_TIMEZONE is
		external
			"IL static signature (): System.TimeZone use System.TimeZone"
		alias
			"get_CurrentTimeZone"
		end

	get_daylight_name: STRING is
		external
			"IL deferred signature (): System.String use System.TimeZone"
		alias
			"get_DaylightName"
		end

feature -- Basic Operations

	get_utc_offset (time: SYSTEM_DATETIME): SYSTEM_TIMESPAN is
		external
			"IL deferred signature (System.DateTime): System.TimeSpan use System.TimeZone"
		alias
			"GetUtcOffset"
		end

	to_local_time (time: SYSTEM_DATETIME): SYSTEM_DATETIME is
		external
			"IL signature (System.DateTime): System.DateTime use System.TimeZone"
		alias
			"ToLocalTime"
		end

	get_daylight_changes (year: INTEGER): SYSTEM_GLOBALIZATION_DAYLIGHTTIME is
		external
			"IL deferred signature (System.Int32): System.Globalization.DaylightTime use System.TimeZone"
		alias
			"GetDaylightChanges"
		end

	is_daylight_saving_time (time: SYSTEM_DATETIME): BOOLEAN is
		external
			"IL signature (System.DateTime): System.Boolean use System.TimeZone"
		alias
			"IsDaylightSavingTime"
		end

	to_universal_time (time: SYSTEM_DATETIME): SYSTEM_DATETIME is
		external
			"IL signature (System.DateTime): System.DateTime use System.TimeZone"
		alias
			"ToUniversalTime"
		end

	frozen is_daylight_saving_time_date_time_daylight_time (time: SYSTEM_DATETIME; daylight_times: SYSTEM_GLOBALIZATION_DAYLIGHTTIME): BOOLEAN is
		external
			"IL static signature (System.DateTime, System.Globalization.DaylightTime): System.Boolean use System.TimeZone"
		alias
			"IsDaylightSavingTime"
		end

end -- class SYSTEM_TIMEZONE
