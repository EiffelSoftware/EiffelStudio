indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Threading.ThreadExceptionEventArgs"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_THREAD_EXCEPTION_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_system_dll_thread_exception_event_args

feature {NONE} -- Initialization

	frozen make_system_dll_thread_exception_event_args (t: EXCEPTION) is
		external
			"IL creator signature (System.Exception) use System.Threading.ThreadExceptionEventArgs"
		end

feature -- Access

	frozen get_exception: EXCEPTION is
		external
			"IL signature (): System.Exception use System.Threading.ThreadExceptionEventArgs"
		alias
			"get_Exception"
		end

end -- class SYSTEM_DLL_THREAD_EXCEPTION_EVENT_ARGS
