indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.Cookie"

frozen external class
	SYSTEM_NET_COOKIE

inherit
	ANY
		rename
			is_equal as equals_object
		redefine
			get_hash_code,
			equals_object,
			to_string
		end

create
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (name: STRING; value: STRING; path: STRING; domain: STRING) is
		external
			"IL creator signature (System.String, System.String, System.String, System.String) use System.Net.Cookie"
		end

	frozen make_2 (name: STRING; value: STRING; path: STRING) is
		external
			"IL creator signature (System.String, System.String, System.String) use System.Net.Cookie"
		end

	frozen make is
		external
			"IL creator use System.Net.Cookie"
		end

	frozen make_1 (name: STRING; value: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Net.Cookie"
		end

feature -- Access

	frozen get_path: STRING is
		external
			"IL signature (): System.String use System.Net.Cookie"
		alias
			"get_Path"
		end

	frozen get_domain: STRING is
		external
			"IL signature (): System.String use System.Net.Cookie"
		alias
			"get_Domain"
		end

	frozen get_name: STRING is
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

	frozen get_expires: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Net.Cookie"
		alias
			"get_Expires"
		end

	frozen get_value: STRING is
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

	frozen get_port: STRING is
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

	frozen get_comment_uri: SYSTEM_URI is
		external
			"IL signature (): System.Uri use System.Net.Cookie"
		alias
			"get_CommentUri"
		end

	frozen get_comment: STRING is
		external
			"IL signature (): System.String use System.Net.Cookie"
		alias
			"get_Comment"
		end

	frozen get_time_stamp: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Net.Cookie"
		alias
			"get_TimeStamp"
		end

feature -- Element Change

	frozen set_expires (value: SYSTEM_DATETIME) is
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

	frozen set_comment_uri (value: SYSTEM_URI) is
		external
			"IL signature (System.Uri): System.Void use System.Net.Cookie"
		alias
			"set_CommentUri"
		end

	frozen set_path (value: STRING) is
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

	frozen set_comment (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.Cookie"
		alias
			"set_Comment"
		end

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.Cookie"
		alias
			"set_Name"
		end

	frozen set_domain (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.Cookie"
		alias
			"set_Domain"
		end

	frozen set_value (value: STRING) is
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

	frozen set_port (value: STRING) is
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

	equals_object (comparand: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Net.Cookie"
		alias
			"Equals"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Net.Cookie"
		alias
			"ToString"
		end

end -- class SYSTEM_NET_COOKIE
