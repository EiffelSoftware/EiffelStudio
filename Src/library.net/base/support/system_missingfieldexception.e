indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.MissingFieldException"

external class
	SYSTEM_MISSINGFIELDEXCEPTION

inherit
	SYSTEM_MISSINGMEMBEREXCEPTION
		redefine
			get_message
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_missingfieldexception,
	make_missingfieldexception_3,
	make_missingfieldexception_2,
	make_missingfieldexception_1

feature {NONE} -- Initialization

	frozen make_missingfieldexception is
		external
			"IL creator use System.MissingFieldException"
		end

	frozen make_missingfieldexception_3 (class_name: STRING; field_name: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.MissingFieldException"
		end

	frozen make_missingfieldexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.MissingFieldException"
		end

	frozen make_missingfieldexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.MissingFieldException"
		end

feature -- Access

	get_message: STRING is
		external
			"IL signature (): System.String use System.MissingFieldException"
		alias
			"get_Message"
		end

end -- class SYSTEM_MISSINGFIELDEXCEPTION
