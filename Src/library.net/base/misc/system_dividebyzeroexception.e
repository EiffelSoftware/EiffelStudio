indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.DivideByZeroException"

external class
	SYSTEM_DIVIDEBYZEROEXCEPTION

inherit
	SYSTEM_ARITHMETICEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_dividebyzeroexception_2,
	make_dividebyzeroexception,
	make_dividebyzeroexception_1

feature {NONE} -- Initialization

	frozen make_dividebyzeroexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.DivideByZeroException"
		end

	frozen make_dividebyzeroexception is
		external
			"IL creator use System.DivideByZeroException"
		end

	frozen make_dividebyzeroexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.DivideByZeroException"
		end

end -- class SYSTEM_DIVIDEBYZEROEXCEPTION
