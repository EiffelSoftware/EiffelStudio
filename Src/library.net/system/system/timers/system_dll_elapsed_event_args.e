indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Timers.ElapsedEventArgs"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_ELAPSED_EVENT_ARGS

inherit
	EVENT_ARGS

create {NONE}

feature -- Access

	frozen get_signal_time: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Timers.ElapsedEventArgs"
		alias
			"get_SignalTime"
		end

end -- class SYSTEM_DLL_ELAPSED_EVENT_ARGS
