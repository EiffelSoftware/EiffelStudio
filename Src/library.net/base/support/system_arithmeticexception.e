indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ArithmeticException"

external class
	SYSTEM_ARITHMETICEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_arithmeticexception,
	make_arithmeticexception_2,
	make_arithmeticexception_1

feature {NONE} -- Initialization

	frozen make_arithmeticexception is
		external
			"IL creator use System.ArithmeticException"
		end

	frozen make_arithmeticexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.ArithmeticException"
		end

	frozen make_arithmeticexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.ArithmeticException"
		end

end -- class SYSTEM_ARITHMETICEXCEPTION
