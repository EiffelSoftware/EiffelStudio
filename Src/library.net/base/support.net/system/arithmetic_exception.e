indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ArithmeticException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	ARITHMETIC_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_arithmetic_exception,
	make_arithmetic_exception_1,
	make_arithmetic_exception_2

feature {NONE} -- Initialization

	frozen make_arithmetic_exception is
		external
			"IL creator use System.ArithmeticException"
		end

	frozen make_arithmetic_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ArithmeticException"
		end

	frozen make_arithmetic_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.ArithmeticException"
		end

end -- class ARITHMETIC_EXCEPTION
