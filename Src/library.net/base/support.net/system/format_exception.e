indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.FormatException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	FORMAT_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_format_exception_1,
	make_format_exception_2,
	make_format_exception

feature {NONE} -- Initialization

	frozen make_format_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.FormatException"
		end

	frozen make_format_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.FormatException"
		end

	frozen make_format_exception is
		external
			"IL creator use System.FormatException"
		end

end -- class FORMAT_EXCEPTION
