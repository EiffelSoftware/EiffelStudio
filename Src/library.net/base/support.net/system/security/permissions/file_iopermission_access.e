indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.FileIOPermissionAccess"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	FILE_IOPERMISSION_ACCESS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen all_access: FILE_IOPERMISSION_ACCESS is
		external
			"IL enum signature :System.Security.Permissions.FileIOPermissionAccess use System.Security.Permissions.FileIOPermissionAccess"
		alias
			"15"
		end

	frozen path_discovery: FILE_IOPERMISSION_ACCESS is
		external
			"IL enum signature :System.Security.Permissions.FileIOPermissionAccess use System.Security.Permissions.FileIOPermissionAccess"
		alias
			"8"
		end

	frozen write: FILE_IOPERMISSION_ACCESS is
		external
			"IL enum signature :System.Security.Permissions.FileIOPermissionAccess use System.Security.Permissions.FileIOPermissionAccess"
		alias
			"2"
		end

	frozen no_access: FILE_IOPERMISSION_ACCESS is
		external
			"IL enum signature :System.Security.Permissions.FileIOPermissionAccess use System.Security.Permissions.FileIOPermissionAccess"
		alias
			"0"
		end

	frozen read: FILE_IOPERMISSION_ACCESS is
		external
			"IL enum signature :System.Security.Permissions.FileIOPermissionAccess use System.Security.Permissions.FileIOPermissionAccess"
		alias
			"1"
		end

	frozen append: FILE_IOPERMISSION_ACCESS is
		external
			"IL enum signature :System.Security.Permissions.FileIOPermissionAccess use System.Security.Permissions.FileIOPermissionAccess"
		alias
			"4"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class FILE_IOPERMISSION_ACCESS
