indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.MissingMethodException"

external class
	SYSTEM_MISSINGMETHODEXCEPTION

inherit
	SYSTEM_MISSINGMEMBEREXCEPTION
		redefine
			get_message
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_missingmethodexception_1,
	make_missingmethodexception_2,
	make_missingmethodexception_3,
	make_missingmethodexception

feature {NONE} -- Initialization

	frozen make_missingmethodexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.MissingMethodException"
		end

	frozen make_missingmethodexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.MissingMethodException"
		end

	frozen make_missingmethodexception_3 (class_name: STRING; method_name: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.MissingMethodException"
		end

	frozen make_missingmethodexception is
		external
			"IL creator use System.MissingMethodException"
		end

feature -- Access

	get_message: STRING is
		external
			"IL signature (): System.String use System.MissingMethodException"
		alias
			"get_Message"
		end

end -- class SYSTEM_MISSINGMETHODEXCEPTION
