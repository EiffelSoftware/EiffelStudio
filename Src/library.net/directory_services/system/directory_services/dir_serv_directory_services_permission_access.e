indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.DirectoryServices.DirectoryServicesPermissionAccess"
	assembly: "System.DirectoryServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ACCESS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen browse: DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ACCESS is
		external
			"IL enum signature :System.DirectoryServices.DirectoryServicesPermissionAccess use System.DirectoryServices.DirectoryServicesPermissionAccess"
		alias
			"2"
		end

	frozen none: DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ACCESS is
		external
			"IL enum signature :System.DirectoryServices.DirectoryServicesPermissionAccess use System.DirectoryServices.DirectoryServicesPermissionAccess"
		alias
			"0"
		end

	frozen write: DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ACCESS is
		external
			"IL enum signature :System.DirectoryServices.DirectoryServicesPermissionAccess use System.DirectoryServices.DirectoryServicesPermissionAccess"
		alias
			"6"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ACCESS
