indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.Authorization"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_AUTHORIZATION

inherit
	SYSTEM_OBJECT

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (token: SYSTEM_STRING; finished: BOOLEAN; connection_group_id: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.Boolean, System.String) use System.Net.Authorization"
		end

	frozen make (token: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Net.Authorization"
		end

	frozen make_1 (token: SYSTEM_STRING; finished: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Boolean) use System.Net.Authorization"
		end

feature -- Access

	frozen get_protection_realm: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Net.Authorization"
		alias
			"get_ProtectionRealm"
		end

	frozen get_connection_group_id: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.Authorization"
		alias
			"get_ConnectionGroupId"
		end

	frozen get_complete: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.Authorization"
		alias
			"get_Complete"
		end

	frozen get_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.Authorization"
		alias
			"get_Message"
		end

feature -- Element Change

	frozen set_protection_realm (value: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.Net.Authorization"
		alias
			"set_ProtectionRealm"
		end

end -- class SYSTEM_DLL_AUTHORIZATION
