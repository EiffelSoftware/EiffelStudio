indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.UnhandledExceptionEventArgs"

external class
	SYSTEM_UNHANDLEDEXCEPTIONEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_unhandledexceptioneventargs

feature {NONE} -- Initialization

	frozen make_unhandledexceptioneventargs (exception: ANY; is_terminating: BOOLEAN) is
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

	frozen get_exception_object: ANY is
		external
			"IL signature (): System.Object use System.UnhandledExceptionEventArgs"
		alias
			"get_ExceptionObject"
		end

end -- class SYSTEM_UNHANDLEDEXCEPTIONEVENTARGS
