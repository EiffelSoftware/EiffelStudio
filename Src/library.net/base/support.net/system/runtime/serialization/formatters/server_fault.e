indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Serialization.Formatters.ServerFault"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SERVER_FAULT

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (exception_type: SYSTEM_STRING; message: SYSTEM_STRING; stack_trace: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String, System.String) use System.Runtime.Serialization.Formatters.ServerFault"
		end

feature -- Access

	frozen get_stack_trace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.Formatters.ServerFault"
		alias
			"get_StackTrace"
		end

	frozen get_exception_type: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.Formatters.ServerFault"
		alias
			"get_ExceptionType"
		end

	frozen get_exception_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.Formatters.ServerFault"
		alias
			"get_ExceptionMessage"
		end

feature -- Element Change

	frozen set_stack_trace (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Serialization.Formatters.ServerFault"
		alias
			"set_StackTrace"
		end

	frozen set_exception_message (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Serialization.Formatters.ServerFault"
		alias
			"set_ExceptionMessage"
		end

	frozen set_exception_type (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Serialization.Formatters.ServerFault"
		alias
			"set_ExceptionType"
		end

end -- class SERVER_FAULT
