indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Globalization.DaylightTime"

external class
	SYSTEM_GLOBALIZATION_DAYLIGHTTIME

create
	make

feature {NONE} -- Initialization

	frozen make (start: SYSTEM_DATETIME; end_: SYSTEM_DATETIME; delta: SYSTEM_TIMESPAN) is
		external
			"IL creator signature (System.DateTime, System.DateTime, System.TimeSpan) use System.Globalization.DaylightTime"
		end

feature -- Access

	frozen get_delta: SYSTEM_TIMESPAN is
		external
			"IL signature (): System.TimeSpan use System.Globalization.DaylightTime"
		alias
			"get_Delta"
		end

	frozen get_end: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Globalization.DaylightTime"
		alias
			"get_End"
		end

	frozen get_start: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Globalization.DaylightTime"
		alias
			"get_Start"
		end

end -- class SYSTEM_GLOBALIZATION_DAYLIGHTTIME
