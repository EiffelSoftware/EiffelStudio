indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "Microsoft.Win32.SessionEndingEventArgs"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_SESSION_ENDING_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_system_dll_session_ending_event_args

feature {NONE} -- Initialization

	frozen make_system_dll_session_ending_event_args (reason: SYSTEM_DLL_SESSION_END_REASONS) is
		external
			"IL creator signature (Microsoft.Win32.SessionEndReasons) use Microsoft.Win32.SessionEndingEventArgs"
		end

feature -- Access

	frozen get_reason: SYSTEM_DLL_SESSION_END_REASONS is
		external
			"IL signature (): Microsoft.Win32.SessionEndReasons use Microsoft.Win32.SessionEndingEventArgs"
		alias
			"get_Reason"
		end

	frozen get_cancel: BOOLEAN is
		external
			"IL signature (): System.Boolean use Microsoft.Win32.SessionEndingEventArgs"
		alias
			"get_Cancel"
		end

feature -- Element Change

	frozen set_cancel (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Microsoft.Win32.SessionEndingEventArgs"
		alias
			"set_Cancel"
		end

end -- class SYSTEM_DLL_SESSION_ENDING_EVENT_ARGS
