indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.PathTooLongException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	PATH_TOO_LONG_EXCEPTION

inherit
	IOEXCEPTION
	ISERIALIZABLE

create
	make_path_too_long_exception_1,
	make_path_too_long_exception,
	make_path_too_long_exception_2

feature {NONE} -- Initialization

	frozen make_path_too_long_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.IO.PathTooLongException"
		end

	frozen make_path_too_long_exception is
		external
			"IL creator use System.IO.PathTooLongException"
		end

	frozen make_path_too_long_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.IO.PathTooLongException"
		end

end -- class PATH_TOO_LONG_EXCEPTION
