indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.MissingFieldException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	MISSING_FIELD_EXCEPTION

inherit
	MISSING_MEMBER_EXCEPTION
		redefine
			get_message
		end
	ISERIALIZABLE

create
	make_missing_field_exception_3,
	make_missing_field_exception_2,
	make_missing_field_exception,
	make_missing_field_exception_1

feature {NONE} -- Initialization

	frozen make_missing_field_exception_3 (class_name: SYSTEM_STRING; field_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.MissingFieldException"
		end

	frozen make_missing_field_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.MissingFieldException"
		end

	frozen make_missing_field_exception is
		external
			"IL creator use System.MissingFieldException"
		end

	frozen make_missing_field_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.MissingFieldException"
		end

feature -- Access

	get_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.MissingFieldException"
		alias
			"get_Message"
		end

end -- class MISSING_FIELD_EXCEPTION
