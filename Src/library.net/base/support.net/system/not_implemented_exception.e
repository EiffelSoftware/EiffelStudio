indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.NotImplementedException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	NOT_IMPLEMENTED_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_not_implemented_exception_1,
	make_not_implemented_exception_2,
	make_not_implemented_exception

feature {NONE} -- Initialization

	frozen make_not_implemented_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.NotImplementedException"
		end

	frozen make_not_implemented_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.NotImplementedException"
		end

	frozen make_not_implemented_exception is
		external
			"IL creator use System.NotImplementedException"
		end

end -- class NOT_IMPLEMENTED_EXCEPTION
