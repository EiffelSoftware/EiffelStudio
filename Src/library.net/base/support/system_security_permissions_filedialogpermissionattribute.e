indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.FileDialogPermissionAttribute"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_FILEDIALOGPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

create
	make_filedialogpermissionattribute

feature {NONE} -- Initialization

	frozen make_filedialogpermissionattribute (action: SYSTEM_SECURITY_PERMISSIONS_SECURITYACTION) is
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

	create_permission: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.FileDialogPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_FILEDIALOGPERMISSIONATTRIBUTE
