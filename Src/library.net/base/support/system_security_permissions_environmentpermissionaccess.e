indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.EnvironmentPermissionAccess"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_SECURITY_PERMISSIONS_ENVIRONMENTPERMISSIONACCESS

inherit
	ENUM
	SYSTEM_ICOMPARABLE
	SYSTEM_IFORMATTABLE

feature -- Access

	frozen all_access: SYSTEM_SECURITY_PERMISSIONS_ENVIRONMENTPERMISSIONACCESS is
		external
			"IL enum signature :System.Security.Permissions.EnvironmentPermissionAccess use System.Security.Permissions.EnvironmentPermissionAccess"
		alias
			"3"
		end

	frozen no_access: SYSTEM_SECURITY_PERMISSIONS_ENVIRONMENTPERMISSIONACCESS is
		external
			"IL enum signature :System.Security.Permissions.EnvironmentPermissionAccess use System.Security.Permissions.EnvironmentPermissionAccess"
		alias
			"0"
		end

	frozen read: SYSTEM_SECURITY_PERMISSIONS_ENVIRONMENTPERMISSIONACCESS is
		external
			"IL enum signature :System.Security.Permissions.EnvironmentPermissionAccess use System.Security.Permissions.EnvironmentPermissionAccess"
		alias
			"1"
		end

	frozen write: SYSTEM_SECURITY_PERMISSIONS_ENVIRONMENTPERMISSIONACCESS is
		external
			"IL enum signature :System.Security.Permissions.EnvironmentPermissionAccess use System.Security.Permissions.EnvironmentPermissionAccess"
		alias
			"2"
		end

feature -- Basic Operations

	infix "|" (o: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_ENVIRONMENTPERMISSIONACCESS
