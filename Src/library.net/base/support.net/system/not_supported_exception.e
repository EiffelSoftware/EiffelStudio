indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.NotSupportedException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	NOT_SUPPORTED_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_not_supported_exception,
	make_not_supported_exception_1,
	make_not_supported_exception_2

feature {NONE} -- Initialization

	frozen make_not_supported_exception is
		external
			"IL creator use System.NotSupportedException"
		end

	frozen make_not_supported_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.NotSupportedException"
		end

	frozen make_not_supported_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.NotSupportedException"
		end

end -- class NOT_SUPPORTED_EXCEPTION
