indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.PermissionState"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	PERMISSION_STATE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen unrestricted: PERMISSION_STATE is
		external
			"IL enum signature :System.Security.Permissions.PermissionState use System.Security.Permissions.PermissionState"
		alias
			"1"
		end

	frozen none: PERMISSION_STATE is
		external
			"IL enum signature :System.Security.Permissions.PermissionState use System.Security.Permissions.PermissionState"
		alias
			"0"
		end

end -- class PERMISSION_STATE
