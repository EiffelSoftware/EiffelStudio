indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "Microsoft.Win32.SessionEndedEventArgs"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_SESSION_ENDED_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_system_dll_session_ended_event_args

feature {NONE} -- Initialization

	frozen make_system_dll_session_ended_event_args (reason: SYSTEM_DLL_SESSION_END_REASONS) is
		external
			"IL creator signature (Microsoft.Win32.SessionEndReasons) use Microsoft.Win32.SessionEndedEventArgs"
		end

feature -- Access

	frozen get_reason: SYSTEM_DLL_SESSION_END_REASONS is
		external
			"IL signature (): Microsoft.Win32.SessionEndReasons use Microsoft.Win32.SessionEndedEventArgs"
		alias
			"get_Reason"
		end

end -- class SYSTEM_DLL_SESSION_ENDED_EVENT_ARGS
