indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.OverflowException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	OVERFLOW_EXCEPTION

inherit
	ARITHMETIC_EXCEPTION
	ISERIALIZABLE

create
	make_overflow_exception,
	make_overflow_exception_1,
	make_overflow_exception_2

feature {NONE} -- Initialization

	frozen make_overflow_exception is
		external
			"IL creator use System.OverflowException"
		end

	frozen make_overflow_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.OverflowException"
		end

	frozen make_overflow_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.OverflowException"
		end

end -- class OVERFLOW_EXCEPTION
