indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.ApplicationException"

external class
	SYSTEM_APPLICATIONEXCEPTION

inherit
	SYSTEM_EXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_application_exception_2,
	make_application_exception,
	make_application_exception_1

feature {NONE} -- Initialization

	frozen make_application_exception_2 (message2: STRING; innerException2: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.ApplicationException"
		end

	frozen make_application_exception is
		external
			"IL creator use System.ApplicationException"
		end

	frozen make_application_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.ApplicationException"
		end

end -- class SYSTEM_APPLICATIONEXCEPTION
