indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.UnauthorizedAccessException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	UNAUTHORIZED_ACCESS_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_unauthorized_access_exception,
	make_unauthorized_access_exception_2,
	make_unauthorized_access_exception_1

feature {NONE} -- Initialization

	frozen make_unauthorized_access_exception is
		external
			"IL creator use System.UnauthorizedAccessException"
		end

	frozen make_unauthorized_access_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.UnauthorizedAccessException"
		end

	frozen make_unauthorized_access_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.UnauthorizedAccessException"
		end

end -- class UNAUTHORIZED_ACCESS_EXCEPTION
