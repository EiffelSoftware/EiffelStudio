indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.RegistryPermissionAccess"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_SECURITY_PERMISSIONS_REGISTRYPERMISSIONACCESS

inherit
	ENUM
	SYSTEM_ICOMPARABLE
	SYSTEM_IFORMATTABLE

feature -- Access

	frozen all_access: SYSTEM_SECURITY_PERMISSIONS_REGISTRYPERMISSIONACCESS is
		external
			"IL enum signature :System.Security.Permissions.RegistryPermissionAccess use System.Security.Permissions.RegistryPermissionAccess"
		alias
			"7"
		end

	frozen no_access: SYSTEM_SECURITY_PERMISSIONS_REGISTRYPERMISSIONACCESS is
		external
			"IL enum signature :System.Security.Permissions.RegistryPermissionAccess use System.Security.Permissions.RegistryPermissionAccess"
		alias
			"0"
		end

	frozen Create_: SYSTEM_SECURITY_PERMISSIONS_REGISTRYPERMISSIONACCESS is
		external
			"IL enum signature :System.Security.Permissions.RegistryPermissionAccess use System.Security.Permissions.RegistryPermissionAccess"
		alias
			"4"
		end

	frozen read: SYSTEM_SECURITY_PERMISSIONS_REGISTRYPERMISSIONACCESS is
		external
			"IL enum signature :System.Security.Permissions.RegistryPermissionAccess use System.Security.Permissions.RegistryPermissionAccess"
		alias
			"1"
		end

	frozen write: SYSTEM_SECURITY_PERMISSIONS_REGISTRYPERMISSIONACCESS is
		external
			"IL enum signature :System.Security.Permissions.RegistryPermissionAccess use System.Security.Permissions.RegistryPermissionAccess"
		alias
			"2"
		end

feature -- Basic Operations

	infix "|" (o: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_REGISTRYPERMISSIONACCESS
