indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.DuplicateWaitObjectException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DUPLICATE_WAIT_OBJECT_EXCEPTION

inherit
	ARGUMENT_EXCEPTION
	ISERIALIZABLE

create
	make_duplicate_wait_object_exception_2,
	make_duplicate_wait_object_exception,
	make_duplicate_wait_object_exception_1

feature {NONE} -- Initialization

	frozen make_duplicate_wait_object_exception_2 (parameter_name: SYSTEM_STRING; message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.DuplicateWaitObjectException"
		end

	frozen make_duplicate_wait_object_exception is
		external
			"IL creator use System.DuplicateWaitObjectException"
		end

	frozen make_duplicate_wait_object_exception_1 (parameter_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.DuplicateWaitObjectException"
		end

end -- class DUPLICATE_WAIT_OBJECT_EXCEPTION
