indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.OutOfMemoryException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	OUT_OF_MEMORY_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_out_of_memory_exception,
	make_out_of_memory_exception_1,
	make_out_of_memory_exception_2

feature {NONE} -- Initialization

	frozen make_out_of_memory_exception is
		external
			"IL creator use System.OutOfMemoryException"
		end

	frozen make_out_of_memory_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.OutOfMemoryException"
		end

	frozen make_out_of_memory_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.OutOfMemoryException"
		end

end -- class OUT_OF_MEMORY_EXCEPTION
