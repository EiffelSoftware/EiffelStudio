indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.DivideByZeroException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DIVIDE_BY_ZERO_EXCEPTION

inherit
	ARITHMETIC_EXCEPTION
	ISERIALIZABLE

create
	make_divide_by_zero_exception_2,
	make_divide_by_zero_exception,
	make_divide_by_zero_exception_1

feature {NONE} -- Initialization

	frozen make_divide_by_zero_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.DivideByZeroException"
		end

	frozen make_divide_by_zero_exception is
		external
			"IL creator use System.DivideByZeroException"
		end

	frozen make_divide_by_zero_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.DivideByZeroException"
		end

end -- class DIVIDE_BY_ZERO_EXCEPTION
