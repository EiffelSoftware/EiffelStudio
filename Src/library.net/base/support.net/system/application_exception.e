indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ApplicationException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	APPLICATION_EXCEPTION

inherit
	EXCEPTION
	ISERIALIZABLE

create
	make_application_exception,
	make_application_exception_2,
	make_application_exception_1

feature {NONE} -- Initialization

	frozen make_application_exception is
		external
			"IL creator use System.ApplicationException"
		end

	frozen make_application_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.ApplicationException"
		end

	frozen make_application_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ApplicationException"
		end

end -- class APPLICATION_EXCEPTION
