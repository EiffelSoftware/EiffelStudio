indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.UnhandledExceptionEventArgs"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	UNHANDLED_EXCEPTION_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_unhandled_exception_event_args

feature {NONE} -- Initialization

	frozen make_unhandled_exception_event_args (exception: SYSTEM_OBJECT; is_terminating: BOOLEAN) is
		external
			"IL creator signature (System.Object, System.Boolean) use System.UnhandledExceptionEventArgs"
		end

feature -- Access

	frozen get_is_terminating: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.UnhandledExceptionEventArgs"
		alias
			"get_IsTerminating"
		end

	frozen get_exception_object: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.UnhandledExceptionEventArgs"
		alias
			"get_ExceptionObject"
		end

end -- class UNHANDLED_EXCEPTION_EVENT_ARGS
