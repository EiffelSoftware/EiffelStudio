indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ApplicationException"

external class
	SYSTEM_APPLICATIONEXCEPTION

inherit
	SYSTEM_EXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_applicationexception_2,
	make_applicationexception,
	make_applicationexception_1

feature {NONE} -- Initialization

	frozen make_applicationexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.ApplicationException"
		end

	frozen make_applicationexception is
		external
			"IL creator use System.ApplicationException"
		end

	frozen make_applicationexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.ApplicationException"
		end

end -- class SYSTEM_APPLICATIONEXCEPTION
