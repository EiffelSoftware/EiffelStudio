indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "Microsoft.Win32.TimerElapsedEventArgs"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_TIMER_ELAPSED_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_system_dll_timer_elapsed_event_args

feature {NONE} -- Initialization

	frozen make_system_dll_timer_elapsed_event_args (timer_id: POINTER) is
		external
			"IL creator signature (System.IntPtr) use Microsoft.Win32.TimerElapsedEventArgs"
		end

feature -- Access

	frozen get_timer_id: POINTER is
		external
			"IL signature (): System.IntPtr use Microsoft.Win32.TimerElapsedEventArgs"
		alias
			"get_TimerId"
		end

end -- class SYSTEM_DLL_TIMER_ELAPSED_EVENT_ARGS
