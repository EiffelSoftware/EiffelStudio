indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.TimeZone"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	TIME_ZONE

inherit
	SYSTEM_OBJECT

feature -- Access

	get_standard_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.TimeZone"
		alias
			"get_StandardName"
		end

	frozen get_current_time_zone: TIME_ZONE is
		external
			"IL static signature (): System.TimeZone use System.TimeZone"
		alias
			"get_CurrentTimeZone"
		end

	get_daylight_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.TimeZone"
		alias
			"get_DaylightName"
		end

feature -- Basic Operations

	get_utc_offset (time: SYSTEM_DATE_TIME): TIME_SPAN is
		external
			"IL deferred signature (System.DateTime): System.TimeSpan use System.TimeZone"
		alias
			"GetUtcOffset"
		end

	to_local_time (time: SYSTEM_DATE_TIME): SYSTEM_DATE_TIME is
		external
			"IL signature (System.DateTime): System.DateTime use System.TimeZone"
		alias
			"ToLocalTime"
		end

	get_daylight_changes (year: INTEGER): DAYLIGHT_TIME is
		external
			"IL deferred signature (System.Int32): System.Globalization.DaylightTime use System.TimeZone"
		alias
			"GetDaylightChanges"
		end

	is_daylight_saving_time (time: SYSTEM_DATE_TIME): BOOLEAN is
		external
			"IL signature (System.DateTime): System.Boolean use System.TimeZone"
		alias
			"IsDaylightSavingTime"
		end

	to_universal_time (time: SYSTEM_DATE_TIME): SYSTEM_DATE_TIME is
		external
			"IL signature (System.DateTime): System.DateTime use System.TimeZone"
		alias
			"ToUniversalTime"
		end

	frozen is_daylight_saving_time_date_time_daylight_time (time: SYSTEM_DATE_TIME; daylight_times: DAYLIGHT_TIME): BOOLEAN is
		external
			"IL static signature (System.DateTime, System.Globalization.DaylightTime): System.Boolean use System.TimeZone"
		alias
			"IsDaylightSavingTime"
		end

end -- class TIME_ZONE
