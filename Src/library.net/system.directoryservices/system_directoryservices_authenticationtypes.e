indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.DirectoryServices.AuthenticationTypes"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DIRECTORYSERVICES_AUTHENTICATIONTYPES

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen readonly_server: SYSTEM_DIRECTORYSERVICES_AUTHENTICATIONTYPES is
		external
			"IL enum signature :System.DirectoryServices.AuthenticationTypes use System.DirectoryServices.AuthenticationTypes"
		alias
			"4"
		end

	frozen fast_bind: SYSTEM_DIRECTORYSERVICES_AUTHENTICATIONTYPES is
		external
			"IL enum signature :System.DirectoryServices.AuthenticationTypes use System.DirectoryServices.AuthenticationTypes"
		alias
			"32"
		end

	frozen secure: SYSTEM_DIRECTORYSERVICES_AUTHENTICATIONTYPES is
		external
			"IL enum signature :System.DirectoryServices.AuthenticationTypes use System.DirectoryServices.AuthenticationTypes"
		alias
			"1"
		end

	frozen server_bind: SYSTEM_DIRECTORYSERVICES_AUTHENTICATIONTYPES is
		external
			"IL enum signature :System.DirectoryServices.AuthenticationTypes use System.DirectoryServices.AuthenticationTypes"
		alias
			"512"
		end

	frozen signing: SYSTEM_DIRECTORYSERVICES_AUTHENTICATIONTYPES is
		external
			"IL enum signature :System.DirectoryServices.AuthenticationTypes use System.DirectoryServices.AuthenticationTypes"
		alias
			"64"
		end

	frozen anonymous: SYSTEM_DIRECTORYSERVICES_AUTHENTICATIONTYPES is
		external
			"IL enum signature :System.DirectoryServices.AuthenticationTypes use System.DirectoryServices.AuthenticationTypes"
		alias
			"16"
		end

	frozen delegation: SYSTEM_DIRECTORYSERVICES_AUTHENTICATIONTYPES is
		external
			"IL enum signature :System.DirectoryServices.AuthenticationTypes use System.DirectoryServices.AuthenticationTypes"
		alias
			"256"
		end

	frozen secure_sockets_layer: SYSTEM_DIRECTORYSERVICES_AUTHENTICATIONTYPES is
		external
			"IL enum signature :System.DirectoryServices.AuthenticationTypes use System.DirectoryServices.AuthenticationTypes"
		alias
			"2"
		end

	frozen encription: SYSTEM_DIRECTORYSERVICES_AUTHENTICATIONTYPES is
		external
			"IL enum signature :System.DirectoryServices.AuthenticationTypes use System.DirectoryServices.AuthenticationTypes"
		alias
			"2"
		end

	frozen none: SYSTEM_DIRECTORYSERVICES_AUTHENTICATIONTYPES is
		external
			"IL enum signature :System.DirectoryServices.AuthenticationTypes use System.DirectoryServices.AuthenticationTypes"
		alias
			"0"
		end

	frozen sealing: SYSTEM_DIRECTORYSERVICES_AUTHENTICATIONTYPES is
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

end -- class SYSTEM_DIRECTORYSERVICES_AUTHENTICATIONTYPES
