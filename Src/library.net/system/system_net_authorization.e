indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.Authorization"

external class
	SYSTEM_NET_AUTHORIZATION

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (token: STRING; finished: BOOLEAN; connection_group_id: STRING) is
		external
			"IL creator signature (System.String, System.Boolean, System.String) use System.Net.Authorization"
		end

	frozen make (token: STRING) is
		external
			"IL creator signature (System.String) use System.Net.Authorization"
		end

	frozen make_1 (token: STRING; finished: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Boolean) use System.Net.Authorization"
		end

feature -- Access

	frozen get_protection_realm: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Net.Authorization"
		alias
			"get_ProtectionRealm"
		end

	frozen get_connection_group_id: STRING is
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

	frozen get_message: STRING is
		external
			"IL signature (): System.String use System.Net.Authorization"
		alias
			"get_Message"
		end

feature -- Element Change

	frozen set_protection_realm (value: ARRAY [STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.Net.Authorization"
		alias
			"set_ProtectionRealm"
		end

end -- class SYSTEM_NET_AUTHORIZATION
