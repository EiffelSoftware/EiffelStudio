indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.StackOverflowException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	STACK_OVERFLOW_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_stack_overflow_exception,
	make_stack_overflow_exception_1,
	make_stack_overflow_exception_2

feature {NONE} -- Initialization

	frozen make_stack_overflow_exception is
		external
			"IL creator use System.StackOverflowException"
		end

	frozen make_stack_overflow_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.StackOverflowException"
		end

	frozen make_stack_overflow_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.StackOverflowException"
		end

end -- class STACK_OVERFLOW_EXCEPTION
