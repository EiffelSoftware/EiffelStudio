indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.EnvironmentPermissionAccess"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	ENVIRONMENT_PERMISSION_ACCESS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen all_access: ENVIRONMENT_PERMISSION_ACCESS is
		external
			"IL enum signature :System.Security.Permissions.EnvironmentPermissionAccess use System.Security.Permissions.EnvironmentPermissionAccess"
		alias
			"3"
		end

	frozen no_access: ENVIRONMENT_PERMISSION_ACCESS is
		external
			"IL enum signature :System.Security.Permissions.EnvironmentPermissionAccess use System.Security.Permissions.EnvironmentPermissionAccess"
		alias
			"0"
		end

	frozen read: ENVIRONMENT_PERMISSION_ACCESS is
		external
			"IL enum signature :System.Security.Permissions.EnvironmentPermissionAccess use System.Security.Permissions.EnvironmentPermissionAccess"
		alias
			"1"
		end

	frozen write: ENVIRONMENT_PERMISSION_ACCESS is
		external
			"IL enum signature :System.Security.Permissions.EnvironmentPermissionAccess use System.Security.Permissions.EnvironmentPermissionAccess"
		alias
			"2"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class ENVIRONMENT_PERMISSION_ACCESS
