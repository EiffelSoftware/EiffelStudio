indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.Cookie"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_COOKIE

inherit
	SYSTEM_OBJECT
		redefine
			get_hash_code,
			equals,
			to_string
		end

create
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (name: SYSTEM_STRING; value: SYSTEM_STRING; path: SYSTEM_STRING; domain: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String, System.String, System.String) use System.Net.Cookie"
		end

	frozen make_2 (name: SYSTEM_STRING; value: SYSTEM_STRING; path: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String, System.String) use System.Net.Cookie"
		end

	frozen make is
		external
			"IL creator use System.Net.Cookie"
		end

	frozen make_1 (name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Net.Cookie"
		end

feature -- Access

	frozen get_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.Cookie"
		alias
			"get_Path"
		end

	frozen get_domain: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.Cookie"
		alias
			"get_Domain"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.Cookie"
		alias
			"get_Name"
		end

	frozen get_version: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.Cookie"
		alias
			"get_Version"
		end

	frozen get_expires: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Net.Cookie"
		alias
			"get_Expires"
		end

	frozen get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.Cookie"
		alias
			"get_Value"
		end

	frozen get_expired: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.Cookie"
		alias
			"get_Expired"
		end

	frozen get_secure: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.Cookie"
		alias
			"get_Secure"
		end

	frozen get_port: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.Cookie"
		alias
			"get_Port"
		end

	frozen get_discard: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.Cookie"
		alias
			"get_Discard"
		end

	frozen get_comment_uri: SYSTEM_DLL_URI is
		external
			"IL signature (): System.Uri use System.Net.Cookie"
		alias
			"get_CommentUri"
		end

	frozen get_comment: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.Cookie"
		alias
			"get_Comment"
		end

	frozen get_time_stamp: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Net.Cookie"
		alias
			"get_TimeStamp"
		end

feature -- Element Change

	frozen set_expires (value: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Net.Cookie"
		alias
			"set_Expires"
		end

	frozen set_discard (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.Cookie"
		alias
			"set_Discard"
		end

	frozen set_comment_uri (value: SYSTEM_DLL_URI) is
		external
			"IL signature (System.Uri): System.Void use System.Net.Cookie"
		alias
			"set_CommentUri"
		end

	frozen set_path (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.Cookie"
		alias
			"set_Path"
		end

	frozen set_version (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Net.Cookie"
		alias
			"set_Version"
		end

	frozen set_expired (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.Cookie"
		alias
			"set_Expired"
		end

	frozen set_comment (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.Cookie"
		alias
			"set_Comment"
		end

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.Cookie"
		alias
			"set_Name"
		end

	frozen set_domain (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.Cookie"
		alias
			"set_Domain"
		end

	frozen set_value (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.Cookie"
		alias
			"set_Value"
		end

	frozen set_secure (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.Cookie"
		alias
			"set_Secure"
		end

	frozen set_port (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.Cookie"
		alias
			"set_Port"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.Cookie"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.Cookie"
		alias
			"ToString"
		end

	equals (comparand: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Net.Cookie"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_COOKIE
