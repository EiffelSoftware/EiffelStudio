indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.ArgumentNullException"

external class
	SYSTEM_ARGUMENTNULLEXCEPTION

inherit
	SYSTEM_ARGUMENTEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_argument_null_exception,
	make_argument_null_exception_2,
	make_argument_null_exception_1

feature {NONE} -- Initialization

	frozen make_argument_null_exception is
		external
			"IL creator use System.ArgumentNullException"
		end

	frozen make_argument_null_exception_2 (param_name2: STRING; message2: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.ArgumentNullException"
		end

	frozen make_argument_null_exception_1 (param_name2: STRING) is
		external
			"IL creator signature (System.String) use System.ArgumentNullException"
		end

end -- class SYSTEM_ARGUMENTNULLEXCEPTION
