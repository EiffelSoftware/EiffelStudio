indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.OverflowException"

external class
	SYSTEM_OVERFLOWEXCEPTION

inherit
	SYSTEM_ARITHMETICEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_overflowexception_2,
	make_overflowexception_1,
	make_overflowexception

feature {NONE} -- Initialization

	frozen make_overflowexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.OverflowException"
		end

	frozen make_overflowexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.OverflowException"
		end

	frozen make_overflowexception is
		external
			"IL creator use System.OverflowException"
		end

end -- class SYSTEM_OVERFLOWEXCEPTION
