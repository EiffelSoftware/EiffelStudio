indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.DirectoryServices.AuthenticationTypes"
	assembly: "System.DirectoryServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	DIR_SERV_AUTHENTICATION_TYPES

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen readonly_server: DIR_SERV_AUTHENTICATION_TYPES is
		external
			"IL enum signature :System.DirectoryServices.AuthenticationTypes use System.DirectoryServices.AuthenticationTypes"
		alias
			"4"
		end

	frozen fast_bind: DIR_SERV_AUTHENTICATION_TYPES is
		external
			"IL enum signature :System.DirectoryServices.AuthenticationTypes use System.DirectoryServices.AuthenticationTypes"
		alias
			"32"
		end

	frozen encryption: DIR_SERV_AUTHENTICATION_TYPES is
		external
			"IL enum signature :System.DirectoryServices.AuthenticationTypes use System.DirectoryServices.AuthenticationTypes"
		alias
			"2"
		end

	frozen secure: DIR_SERV_AUTHENTICATION_TYPES is
		external
			"IL enum signature :System.DirectoryServices.AuthenticationTypes use System.DirectoryServices.AuthenticationTypes"
		alias
			"1"
		end

	frozen server_bind: DIR_SERV_AUTHENTICATION_TYPES is
		external
			"IL enum signature :System.DirectoryServices.AuthenticationTypes use System.DirectoryServices.AuthenticationTypes"
		alias
			"512"
		end

	frozen signing: DIR_SERV_AUTHENTICATION_TYPES is
		external
			"IL enum signature :System.DirectoryServices.AuthenticationTypes use System.DirectoryServices.AuthenticationTypes"
		alias
			"64"
		end

	frozen anonymous: DIR_SERV_AUTHENTICATION_TYPES is
		external
			"IL enum signature :System.DirectoryServices.AuthenticationTypes use System.DirectoryServices.AuthenticationTypes"
		alias
			"16"
		end

	frozen delegation: DIR_SERV_AUTHENTICATION_TYPES is
		external
			"IL enum signature :System.DirectoryServices.AuthenticationTypes use System.DirectoryServices.AuthenticationTypes"
		alias
			"256"
		end

	frozen secure_sockets_layer: DIR_SERV_AUTHENTICATION_TYPES is
		external
			"IL enum signature :System.DirectoryServices.AuthenticationTypes use System.DirectoryServices.AuthenticationTypes"
		alias
			"2"
		end

	frozen none: DIR_SERV_AUTHENTICATION_TYPES is
		external
			"IL enum signature :System.DirectoryServices.AuthenticationTypes use System.DirectoryServices.AuthenticationTypes"
		alias
			"0"
		end

	frozen sealing: DIR_SERV_AUTHENTICATION_TYPES is
		external
			"IL enum signature :System.DirectoryServices.AuthenticationTypes use System.DirectoryServices.AuthenticationTypes"
		alias
			"128"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class DIR_SERV_AUTHENTICATION_TYPES
