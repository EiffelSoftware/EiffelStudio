indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.FieldAccessException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	FIELD_ACCESS_EXCEPTION

inherit
	MEMBER_ACCESS_EXCEPTION
	ISERIALIZABLE

create
	make_field_access_exception_1,
	make_field_access_exception,
	make_field_access_exception_2

feature {NONE} -- Initialization

	frozen make_field_access_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.FieldAccessException"
		end

	frozen make_field_access_exception is
		external
			"IL creator use System.FieldAccessException"
		end

	frozen make_field_access_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.FieldAccessException"
		end

end -- class FIELD_ACCESS_EXCEPTION
