indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.MethodAccessException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	METHOD_ACCESS_EXCEPTION

inherit
	MEMBER_ACCESS_EXCEPTION
	ISERIALIZABLE

create
	make_method_access_exception_1,
	make_method_access_exception_2,
	make_method_access_exception

feature {NONE} -- Initialization

	frozen make_method_access_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.MethodAccessException"
		end

	frozen make_method_access_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.MethodAccessException"
		end

	frozen make_method_access_exception is
		external
			"IL creator use System.MethodAccessException"
		end

end -- class METHOD_ACCESS_EXCEPTION
