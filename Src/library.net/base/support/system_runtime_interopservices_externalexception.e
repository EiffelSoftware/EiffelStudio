indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.ExternalException"

external class
	SYSTEM_RUNTIME_INTEROPSERVICES_EXTERNALEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_external_exception_2,
	make_external_exception_3,
	make_external_exception_1,
	make_external_exception

feature {NONE} -- Initialization

	frozen make_external_exception_2 (message2: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.InteropServices.ExternalException"
		end

	frozen make_external_exception_3 (message2: STRING; errorCode2: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.Runtime.InteropServices.ExternalException"
		end

	frozen make_external_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.ExternalException"
		end

	frozen make_external_exception is
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
