indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.SecurityException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SECURITY_EXCEPTION

inherit
	SYSTEM_EXCEPTION
		redefine
			get_object_data,
			to_string
		end
	ISERIALIZABLE

create
	make_security_exception,
	make_security_exception_4,
	make_security_exception_2,
	make_security_exception_3,
	make_security_exception_1

feature {NONE} -- Initialization

	frozen make_security_exception is
		external
			"IL creator use System.Security.SecurityException"
		end

	frozen make_security_exception_4 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Security.SecurityException"
		end

	frozen make_security_exception_2 (message: SYSTEM_STRING; type: TYPE) is
		external
			"IL creator signature (System.String, System.Type) use System.Security.SecurityException"
		end

	frozen make_security_exception_3 (message: SYSTEM_STRING; type: TYPE; state: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.Type, System.String) use System.Security.SecurityException"
		end

	frozen make_security_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Security.SecurityException"
		end

feature -- Access

	frozen get_permission_state: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.SecurityException"
		alias
			"get_PermissionState"
		end

	frozen get_permission_type: TYPE is
		external
			"IL signature (): System.Type use System.Security.SecurityException"
		alias
			"get_PermissionType"
		end

feature -- Basic Operations

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Security.SecurityException"
		alias
			"GetObjectData"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.SecurityException"
		alias
			"ToString"
		end

end -- class SECURITY_EXCEPTION
