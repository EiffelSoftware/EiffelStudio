indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.DateRangeEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_DATE_RANGE_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_date_range_event_args

feature {NONE} -- Initialization

	frozen make_winforms_date_range_event_args (start: SYSTEM_DATE_TIME; end_: SYSTEM_DATE_TIME) is
		external
			"IL creator signature (System.DateTime, System.DateTime) use System.Windows.Forms.DateRangeEventArgs"
		end

feature -- Access

	frozen get_end: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Windows.Forms.DateRangeEventArgs"
		alias
			"get_End"
		end

	frozen get_start: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Windows.Forms.DateRangeEventArgs"
		alias
			"get_Start"
		end

end -- class WINFORMS_DATE_RANGE_EVENT_ARGS
