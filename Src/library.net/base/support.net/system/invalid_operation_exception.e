indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.InvalidOperationException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	INVALID_OPERATION_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_invalid_operation_exception_2,
	make_invalid_operation_exception_1,
	make_invalid_operation_exception

feature {NONE} -- Initialization

	frozen make_invalid_operation_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.InvalidOperationException"
		end

	frozen make_invalid_operation_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.InvalidOperationException"
		end

	frozen make_invalid_operation_exception is
		external
			"IL creator use System.InvalidOperationException"
		end

end -- class INVALID_OPERATION_EXCEPTION
