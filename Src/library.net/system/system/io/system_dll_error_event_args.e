indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.ErrorEventArgs"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_ERROR_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_system_dll_error_event_args

feature {NONE} -- Initialization

	frozen make_system_dll_error_event_args (exception: EXCEPTION) is
		external
			"IL creator signature (System.Exception) use System.IO.ErrorEventArgs"
		end

feature -- Basic Operations

	get_exception: EXCEPTION is
		external
			"IL signature (): System.Exception use System.IO.ErrorEventArgs"
		alias
			"GetException"
		end

end -- class SYSTEM_DLL_ERROR_EVENT_ARGS
