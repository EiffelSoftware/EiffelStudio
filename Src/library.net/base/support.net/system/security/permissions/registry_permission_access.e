indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.RegistryPermissionAccess"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	REGISTRY_PERMISSION_ACCESS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen all_access: REGISTRY_PERMISSION_ACCESS is
		external
			"IL enum signature :System.Security.Permissions.RegistryPermissionAccess use System.Security.Permissions.RegistryPermissionAccess"
		alias
			"7"
		end

	frozen create_: REGISTRY_PERMISSION_ACCESS is
		external
			"IL enum signature :System.Security.Permissions.RegistryPermissionAccess use System.Security.Permissions.RegistryPermissionAccess"
		alias
			"4"
		end

	frozen no_access: REGISTRY_PERMISSION_ACCESS is
		external
			"IL enum signature :System.Security.Permissions.RegistryPermissionAccess use System.Security.Permissions.RegistryPermissionAccess"
		alias
			"0"
		end

	frozen read: REGISTRY_PERMISSION_ACCESS is
		external
			"IL enum signature :System.Security.Permissions.RegistryPermissionAccess use System.Security.Permissions.RegistryPermissionAccess"
		alias
			"1"
		end

	frozen write: REGISTRY_PERMISSION_ACCESS is
		external
			"IL enum signature :System.Security.Permissions.RegistryPermissionAccess use System.Security.Permissions.RegistryPermissionAccess"
		alias
			"2"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class REGISTRY_PERMISSION_ACCESS
