indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.InvalidProgramException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	INVALID_PROGRAM_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_invalid_program_exception_2,
	make_invalid_program_exception_1,
	make_invalid_program_exception

feature {NONE} -- Initialization

	frozen make_invalid_program_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.InvalidProgramException"
		end

	frozen make_invalid_program_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.InvalidProgramException"
		end

	frozen make_invalid_program_exception is
		external
			"IL creator use System.InvalidProgramException"
		end

end -- class INVALID_PROGRAM_EXCEPTION
