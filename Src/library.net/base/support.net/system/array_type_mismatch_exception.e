indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ArrayTypeMismatchException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	ARRAY_TYPE_MISMATCH_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_array_type_mismatch_exception_1,
	make_array_type_mismatch_exception_2,
	make_array_type_mismatch_exception

feature {NONE} -- Initialization

	frozen make_array_type_mismatch_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ArrayTypeMismatchException"
		end

	frozen make_array_type_mismatch_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.ArrayTypeMismatchException"
		end

	frozen make_array_type_mismatch_exception is
		external
			"IL creator use System.ArrayTypeMismatchException"
		end

end -- class ARRAY_TYPE_MISMATCH_EXCEPTION
