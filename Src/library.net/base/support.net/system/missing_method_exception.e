indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.MissingMethodException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	MISSING_METHOD_EXCEPTION

inherit
	MISSING_MEMBER_EXCEPTION
		redefine
			get_message
		end
	ISERIALIZABLE

create
	make_missing_method_exception,
	make_missing_method_exception_1,
	make_missing_method_exception_2,
	make_missing_method_exception_3

feature {NONE} -- Initialization

	frozen make_missing_method_exception is
		external
			"IL creator use System.MissingMethodException"
		end

	frozen make_missing_method_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.MissingMethodException"
		end

	frozen make_missing_method_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.MissingMethodException"
		end

	frozen make_missing_method_exception_3 (class_name: SYSTEM_STRING; method_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.MissingMethodException"
		end

feature -- Access

	get_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.MissingMethodException"
		alias
			"get_Message"
		end

end -- class MISSING_METHOD_EXCEPTION
