indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.FileDialogPermissionAccess"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	FILE_DIALOG_PERMISSION_ACCESS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen none: FILE_DIALOG_PERMISSION_ACCESS is
		external
			"IL enum signature :System.Security.Permissions.FileDialogPermissionAccess use System.Security.Permissions.FileDialogPermissionAccess"
		alias
			"0"
		end

	frozen open: FILE_DIALOG_PERMISSION_ACCESS is
		external
			"IL enum signature :System.Security.Permissions.FileDialogPermissionAccess use System.Security.Permissions.FileDialogPermissionAccess"
		alias
			"1"
		end

	frozen open_save: FILE_DIALOG_PERMISSION_ACCESS is
		external
			"IL enum signature :System.Security.Permissions.FileDialogPermissionAccess use System.Security.Permissions.FileDialogPermissionAccess"
		alias
			"3"
		end

	frozen save: FILE_DIALOG_PERMISSION_ACCESS is
		external
			"IL enum signature :System.Security.Permissions.FileDialogPermissionAccess use System.Security.Permissions.FileDialogPermissionAccess"
		alias
			"2"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class FILE_DIALOG_PERMISSION_ACCESS
