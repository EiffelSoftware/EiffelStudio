indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.UIPermissionAttribute"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_UIPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

create
	make_uipermissionattribute

feature {NONE} -- Initialization

	frozen make_uipermissionattribute (action: SYSTEM_SECURITY_PERMISSIONS_SECURITYACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Security.Permissions.UIPermissionAttribute"
		end

feature -- Access

	frozen get_window: SYSTEM_SECURITY_PERMISSIONS_UIPERMISSIONWINDOW is
		external
			"IL signature (): System.Security.Permissions.UIPermissionWindow use System.Security.Permissions.UIPermissionAttribute"
		alias
			"get_Window"
		end

	frozen get_clipboard: SYSTEM_SECURITY_PERMISSIONS_UIPERMISSIONCLIPBOARD is
		external
			"IL signature (): System.Security.Permissions.UIPermissionClipboard use System.Security.Permissions.UIPermissionAttribute"
		alias
			"get_Clipboard"
		end

feature -- Element Change

	frozen set_window (value: SYSTEM_SECURITY_PERMISSIONS_UIPERMISSIONWINDOW) is
		external
			"IL signature (System.Security.Permissions.UIPermissionWindow): System.Void use System.Security.Permissions.UIPermissionAttribute"
		alias
			"set_Window"
		end

	frozen set_clipboard (value: SYSTEM_SECURITY_PERMISSIONS_UIPERMISSIONCLIPBOARD) is
		external
			"IL signature (System.Security.Permissions.UIPermissionClipboard): System.Void use System.Security.Permissions.UIPermissionAttribute"
		alias
			"set_Clipboard"
		end

feature -- Basic Operations

	create_permission: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.UIPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_UIPERMISSIONATTRIBUTE
