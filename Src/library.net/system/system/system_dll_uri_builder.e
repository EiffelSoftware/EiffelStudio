indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.UriBuilder"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_URI_BUILDER

inherit
	SYSTEM_OBJECT
		redefine
			get_hash_code,
			equals,
			to_string
		end

create
	make_6,
	make_5,
	make_4,
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_6 (scheme: SYSTEM_STRING; host: SYSTEM_STRING; port: INTEGER; path: SYSTEM_STRING; extra_value: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String, System.Int32, System.String, System.String) use System.UriBuilder"
		end

	frozen make_5 (scheme: SYSTEM_STRING; host: SYSTEM_STRING; port: INTEGER; path_value: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String, System.Int32, System.String) use System.UriBuilder"
		end

	frozen make_4 (scheme: SYSTEM_STRING; host: SYSTEM_STRING; port_number: INTEGER) is
		external
			"IL creator signature (System.String, System.String, System.Int32) use System.UriBuilder"
		end

	frozen make_3 (scheme_name: SYSTEM_STRING; host_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.UriBuilder"
		end

	frozen make_2 (uri: SYSTEM_DLL_URI) is
		external
			"IL creator signature (System.Uri) use System.UriBuilder"
		end

	frozen make is
		external
			"IL creator use System.UriBuilder"
		end

	frozen make_1 (uri: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.UriBuilder"
		end

feature -- Access

	frozen get_uri: SYSTEM_DLL_URI is
		external
			"IL signature (): System.Uri use System.UriBuilder"
		alias
			"get_Uri"
		end

	frozen get_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.UriBuilder"
		alias
			"get_Path"
		end

	frozen get_query: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.UriBuilder"
		alias
			"get_Query"
		end

	frozen get_user_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.UriBuilder"
		alias
			"get_UserName"
		end

	frozen get_fragment: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.UriBuilder"
		alias
			"get_Fragment"
		end

	frozen get_port: INTEGER is
		external
			"IL signature (): System.Int32 use System.UriBuilder"
		alias
			"get_Port"
		end

	frozen get_host: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.UriBuilder"
		alias
			"get_Host"
		end

	frozen get_password: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.UriBuilder"
		alias
			"get_Password"
		end

	frozen get_scheme: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.UriBuilder"
		alias
			"get_Scheme"
		end

feature -- Element Change

	frozen set_user_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.UriBuilder"
		alias
			"set_UserName"
		end

	frozen set_path (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.UriBuilder"
		alias
			"set_Path"
		end

	frozen set_fragment (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.UriBuilder"
		alias
			"set_Fragment"
		end

	frozen set_scheme (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.UriBuilder"
		alias
			"set_Scheme"
		end

	frozen set_port (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.UriBuilder"
		alias
			"set_Port"
		end

	frozen set_host (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.UriBuilder"
		alias
			"set_Host"
		end

	frozen set_password (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.UriBuilder"
		alias
			"set_Password"
		end

	frozen set_query (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.UriBuilder"
		alias
			"set_Query"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.UriBuilder"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.UriBuilder"
		alias
			"ToString"
		end

	equals (rparam: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.UriBuilder"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_URI_BUILDER
