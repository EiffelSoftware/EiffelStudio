indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.FileDialogPermissionAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	FILE_DIALOG_PERMISSION_ATTRIBUTE

inherit
	CODE_ACCESS_SECURITY_ATTRIBUTE

create
	make_file_dialog_permission_attribute

feature {NONE} -- Initialization

	frozen make_file_dialog_permission_attribute (action: SECURITY_ACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Security.Permissions.FileDialogPermissionAttribute"
		end

feature -- Access

	frozen get_save: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.FileDialogPermissionAttribute"
		alias
			"get_Save"
		end

	frozen get_open: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.FileDialogPermissionAttribute"
		alias
			"get_Open"
		end

feature -- Element Change

	frozen set_save (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Permissions.FileDialogPermissionAttribute"
		alias
			"set_Save"
		end

	frozen set_open (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Permissions.FileDialogPermissionAttribute"
		alias
			"set_Open"
		end

feature -- Basic Operations

	create_permission: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.FileDialogPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class FILE_DIALOG_PERMISSION_ATTRIBUTE
