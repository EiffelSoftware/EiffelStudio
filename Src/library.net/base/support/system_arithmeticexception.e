indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.ArithmeticException"

external class
	SYSTEM_ARITHMETICEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_arithmetic_exception,
	make_arithmetic_exception_2,
	make_arithmetic_exception_1

feature {NONE} -- Initialization

	frozen make_arithmetic_exception is
		external
			"IL creator use System.ArithmeticException"
		end

	frozen make_arithmetic_exception_2 (message2: STRING; inner_exception2: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.ArithmeticException"
		end

	frozen make_arithmetic_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.ArithmeticException"
		end

end -- class SYSTEM_ARITHMETICEXCEPTION
