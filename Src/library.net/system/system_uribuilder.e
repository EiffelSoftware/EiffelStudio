indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.UriBuilder"

external class
	SYSTEM_URIBUILDER

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
	make_6,
	make_5,
	make_4,
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_6 (scheme: STRING; host: STRING; port: INTEGER; path: STRING; extra_value: STRING) is
		external
			"IL creator signature (System.String, System.String, System.Int32, System.String, System.String) use System.UriBuilder"
		end

	frozen make_5 (scheme: STRING; host: STRING; port: INTEGER; path_value: STRING) is
		external
			"IL creator signature (System.String, System.String, System.Int32, System.String) use System.UriBuilder"
		end

	frozen make_4 (scheme: STRING; host: STRING; port_number: INTEGER) is
		external
			"IL creator signature (System.String, System.String, System.Int32) use System.UriBuilder"
		end

	frozen make_3 (scheme_name: STRING; host_name: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.UriBuilder"
		end

	frozen make_2 (uri: SYSTEM_URI) is
		external
			"IL creator signature (System.Uri) use System.UriBuilder"
		end

	frozen make is
		external
			"IL creator use System.UriBuilder"
		end

	frozen make_1 (uri: STRING) is
		external
			"IL creator signature (System.String) use System.UriBuilder"
		end

feature -- Access

	frozen get_uri: SYSTEM_URI is
		external
			"IL signature (): System.Uri use System.UriBuilder"
		alias
			"get_Uri"
		end

	frozen get_path: STRING is
		external
			"IL signature (): System.String use System.UriBuilder"
		alias
			"get_Path"
		end

	frozen get_query: STRING is
		external
			"IL signature (): System.String use System.UriBuilder"
		alias
			"get_Query"
		end

	frozen get_user_name: STRING is
		external
			"IL signature (): System.String use System.UriBuilder"
		alias
			"get_UserName"
		end

	frozen get_fragment: STRING is
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

	frozen get_host: STRING is
		external
			"IL signature (): System.String use System.UriBuilder"
		alias
			"get_Host"
		end

	frozen get_password: STRING is
		external
			"IL signature (): System.String use System.UriBuilder"
		alias
			"get_Password"
		end

	frozen get_scheme: STRING is
		external
			"IL signature (): System.String use System.UriBuilder"
		alias
			"get_Scheme"
		end

feature -- Element Change

	frozen set_user_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.UriBuilder"
		alias
			"set_UserName"
		end

	frozen set_path (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.UriBuilder"
		alias
			"set_Path"
		end

	frozen set_fragment (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.UriBuilder"
		alias
			"set_Fragment"
		end

	frozen set_scheme (value: STRING) is
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

	frozen set_host (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.UriBuilder"
		alias
			"set_Host"
		end

	frozen set_password (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.UriBuilder"
		alias
			"set_Password"
		end

	frozen set_query (value: STRING) is
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

	equals_object (rparam: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.UriBuilder"
		alias
			"Equals"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.UriBuilder"
		alias
			"ToString"
		end

end -- class SYSTEM_URIBUILDER
