indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Timers.ElapsedEventArgs"

external class
	SYSTEM_TIMERS_ELAPSEDEVENTARGS

inherit
	SYSTEM_EVENTARGS

create {NONE}

feature -- Access

	frozen get_signal_time: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Timers.ElapsedEventArgs"
		alias
			"get_SignalTime"
		end

end -- class SYSTEM_TIMERS_ELAPSEDEVENTARGS
