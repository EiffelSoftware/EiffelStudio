indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.NetworkCredential"

external class
	SYSTEM_NET_NETWORKCREDENTIAL

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_NET_ICREDENTIALS

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (user_name: STRING; password: STRING; domain: STRING) is
		external
			"IL creator signature (System.String, System.String, System.String) use System.Net.NetworkCredential"
		end

	frozen make is
		external
			"IL creator use System.Net.NetworkCredential"
		end

	frozen make_1 (user_name: STRING; password: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Net.NetworkCredential"
		end

feature -- Access

	frozen get_password: STRING is
		external
			"IL signature (): System.String use System.Net.NetworkCredential"
		alias
			"get_Password"
		end

	frozen get_domain: STRING is
		external
			"IL signature (): System.String use System.Net.NetworkCredential"
		alias
			"get_Domain"
		end

	frozen get_user_name: STRING is
		external
			"IL signature (): System.String use System.Net.NetworkCredential"
		alias
			"get_UserName"
		end

feature -- Element Change

	frozen set_domain (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.NetworkCredential"
		alias
			"set_Domain"
		end

	frozen set_password (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.NetworkCredential"
		alias
			"set_Password"
		end

	frozen set_user_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.NetworkCredential"
		alias
			"set_UserName"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.NetworkCredential"
		alias
			"GetHashCode"
		end

	frozen get_credential (uri: SYSTEM_URI; auth_type: STRING): SYSTEM_NET_NETWORKCREDENTIAL is
		external
			"IL signature (System.Uri, System.String): System.Net.NetworkCredential use System.Net.NetworkCredential"
		alias
			"GetCredential"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Net.NetworkCredential"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Net.NetworkCredential"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Net.NetworkCredential"
		alias
			"Finalize"
		end

end -- class SYSTEM_NET_NETWORKCREDENTIAL
