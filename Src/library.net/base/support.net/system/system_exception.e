indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.SystemException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_EXCEPTION

inherit
	EXCEPTION
	ISERIALIZABLE

create
	make_system_exception_2,
	make_system_exception,
	make_system_exception_1

feature {NONE} -- Initialization

	frozen make_system_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.SystemException"
		end

	frozen make_system_exception is
		external
			"IL creator use System.SystemException"
		end

	frozen make_system_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.SystemException"
		end

end -- class SYSTEM_EXCEPTION
