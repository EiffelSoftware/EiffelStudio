indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.ExternalException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	EXTERNAL_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_external_exception,
	make_external_exception_2,
	make_external_exception_1,
	make_external_exception_3

feature {NONE} -- Initialization

	frozen make_external_exception is
		external
			"IL creator use System.Runtime.InteropServices.ExternalException"
		end

	frozen make_external_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.InteropServices.ExternalException"
		end

	frozen make_external_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.ExternalException"
		end

	frozen make_external_exception_3 (message: SYSTEM_STRING; error_code: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.Runtime.InteropServices.ExternalException"
		end

feature -- Access

	get_error_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.InteropServices.ExternalException"
		alias
			"get_ErrorCode"
		end

end -- class EXTERNAL_EXCEPTION
