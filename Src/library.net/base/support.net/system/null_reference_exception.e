indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.NullReferenceException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	NULL_REFERENCE_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_null_reference_exception,
	make_null_reference_exception_2,
	make_null_reference_exception_1

feature {NONE} -- Initialization

	frozen make_null_reference_exception is
		external
			"IL creator use System.NullReferenceException"
		end

	frozen make_null_reference_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.NullReferenceException"
		end

	frozen make_null_reference_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.NullReferenceException"
		end

end -- class NULL_REFERENCE_EXCEPTION
