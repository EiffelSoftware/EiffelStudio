indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ArgumentNullException"

external class
	SYSTEM_ARGUMENTNULLEXCEPTION

inherit
	SYSTEM_ARGUMENTEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_argumentnullexception,
	make_argumentnullexception_2,
	make_argumentnullexception_1

feature {NONE} -- Initialization

	frozen make_argumentnullexception is
		external
			"IL creator use System.ArgumentNullException"
		end

	frozen make_argumentnullexception_2 (param_name: STRING; message: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.ArgumentNullException"
		end

	frozen make_argumentnullexception_1 (param_name: STRING) is
		external
			"IL creator signature (System.String) use System.ArgumentNullException"
		end

end -- class SYSTEM_ARGUMENTNULLEXCEPTION
