indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.SecurityException"

external class
	SYSTEM_SECURITY_SECURITYEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_securityexception,
	make_securityexception_1,
	make_securityexception_3,
	make_securityexception_2,
	make_securityexception_4

feature {NONE} -- Initialization

	frozen make_securityexception is
		external
			"IL creator use System.Security.SecurityException"
		end

	frozen make_securityexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Security.SecurityException"
		end

	frozen make_securityexception_3 (message: STRING; type: SYSTEM_TYPE; state: STRING) is
		external
			"IL creator signature (System.String, System.Type, System.String) use System.Security.SecurityException"
		end

	frozen make_securityexception_2 (message: STRING; type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.String, System.Type) use System.Security.SecurityException"
		end

	frozen make_securityexception_4 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Security.SecurityException"
		end

feature -- Access

	frozen get_permission_state: STRING is
		external
			"IL signature (): System.String use System.Security.SecurityException"
		alias
			"get_PermissionState"
		end

	frozen get_permission_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Security.SecurityException"
		alias
			"get_PermissionType"
		end

end -- class SYSTEM_SECURITY_SECURITYEXCEPTION
