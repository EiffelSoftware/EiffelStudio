indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Serialization.Formatters.ServerFault"

frozen external class
	SYSTEM_RUNTIME_SERIALIZATION_FORMATTERS_SERVERFAULT

create
	make

feature {NONE} -- Initialization

	frozen make (exceptionType2: STRING; message: STRING; stackTrace2: STRING) is
		external
			"IL creator signature (System.String, System.String, System.String) use System.Runtime.Serialization.Formatters.ServerFault"
		end

feature -- Access

	frozen get_exception_type: STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.Formatters.ServerFault"
		alias
			"get_ExceptionType"
		end

	frozen get_stack_trace: STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.Formatters.ServerFault"
		alias
			"get_StackTrace"
		end

	frozen get_exception_message: STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.Formatters.ServerFault"
		alias
			"get_ExceptionMessage"
		end

feature -- Element Change

	frozen set_stack_trace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Serialization.Formatters.ServerFault"
		alias
			"set_StackTrace"
		end

	frozen set_exception_message (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Serialization.Formatters.ServerFault"
		alias
			"set_ExceptionMessage"
		end

	frozen set_exception_type (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Serialization.Formatters.ServerFault"
		alias
			"set_ExceptionType"
		end

end -- class SYSTEM_RUNTIME_SERIALIZATION_FORMATTERS_SERVERFAULT
