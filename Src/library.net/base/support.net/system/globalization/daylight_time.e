indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Globalization.DaylightTime"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DAYLIGHT_TIME

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (start: SYSTEM_DATE_TIME; end_: SYSTEM_DATE_TIME; delta: TIME_SPAN) is
		external
			"IL creator signature (System.DateTime, System.DateTime, System.TimeSpan) use System.Globalization.DaylightTime"
		end

feature -- Access

	frozen get_delta: TIME_SPAN is
		external
			"IL signature (): System.TimeSpan use System.Globalization.DaylightTime"
		alias
			"get_Delta"
		end

	frozen get_end: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Globalization.DaylightTime"
		alias
			"get_End"
		end

	frozen get_start: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Globalization.DaylightTime"
		alias
			"get_Start"
		end

end -- class DAYLIGHT_TIME
