indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ArgumentNullException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	ARGUMENT_NULL_EXCEPTION

inherit
	ARGUMENT_EXCEPTION
	ISERIALIZABLE

create
	make_argument_null_exception_2,
	make_argument_null_exception_1,
	make_argument_null_exception

feature {NONE} -- Initialization

	frozen make_argument_null_exception_2 (param_name: SYSTEM_STRING; message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.ArgumentNullException"
		end

	frozen make_argument_null_exception_1 (param_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ArgumentNullException"
		end

	frozen make_argument_null_exception is
		external
			"IL creator use System.ArgumentNullException"
		end

end -- class ARGUMENT_NULL_EXCEPTION
