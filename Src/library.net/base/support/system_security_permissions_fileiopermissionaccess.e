indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.FileIOPermissionAccess"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_SECURITY_PERMISSIONS_FILEIOPERMISSIONACCESS

inherit
	ENUM
	SYSTEM_ICOMPARABLE
	SYSTEM_IFORMATTABLE

feature -- Access

	frozen all_access: SYSTEM_SECURITY_PERMISSIONS_FILEIOPERMISSIONACCESS is
		external
			"IL enum signature :System.Security.Permissions.FileIOPermissionAccess use System.Security.Permissions.FileIOPermissionAccess"
		alias
			"15"
		end

	frozen path_discovery: SYSTEM_SECURITY_PERMISSIONS_FILEIOPERMISSIONACCESS is
		external
			"IL enum signature :System.Security.Permissions.FileIOPermissionAccess use System.Security.Permissions.FileIOPermissionAccess"
		alias
			"8"
		end

	frozen write: SYSTEM_SECURITY_PERMISSIONS_FILEIOPERMISSIONACCESS is
		external
			"IL enum signature :System.Security.Permissions.FileIOPermissionAccess use System.Security.Permissions.FileIOPermissionAccess"
		alias
			"2"
		end

	frozen no_access: SYSTEM_SECURITY_PERMISSIONS_FILEIOPERMISSIONACCESS is
		external
			"IL enum signature :System.Security.Permissions.FileIOPermissionAccess use System.Security.Permissions.FileIOPermissionAccess"
		alias
			"0"
		end

	frozen read: SYSTEM_SECURITY_PERMISSIONS_FILEIOPERMISSIONACCESS is
		external
			"IL enum signature :System.Security.Permissions.FileIOPermissionAccess use System.Security.Permissions.FileIOPermissionAccess"
		alias
			"1"
		end

	frozen append: SYSTEM_SECURITY_PERMISSIONS_FILEIOPERMISSIONACCESS is
		external
			"IL enum signature :System.Security.Permissions.FileIOPermissionAccess use System.Security.Permissions.FileIOPermissionAccess"
		alias
			"4"
		end

feature -- Basic Operations

	infix "|" (o: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_FILEIOPERMISSIONACCESS
