indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.ExternalException"

external class
	SYSTEM_RUNTIME_INTEROPSERVICES_EXTERNALEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_externalexception_2,
	make_externalexception_3,
	make_externalexception_1,
	make_externalexception

feature {NONE} -- Initialization

	frozen make_externalexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.InteropServices.ExternalException"
		end

	frozen make_externalexception_3 (message: STRING; error_code: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.Runtime.InteropServices.ExternalException"
		end

	frozen make_externalexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.ExternalException"
		end

	frozen make_externalexception is
		external
			"IL creator use System.Runtime.InteropServices.ExternalException"
		end

feature -- Access

	get_error_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.InteropServices.ExternalException"
		alias
			"get_ErrorCode"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_EXTERNALEXCEPTION
