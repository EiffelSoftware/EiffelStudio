indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.UIPermissionAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	UIPERMISSION_ATTRIBUTE

inherit
	CODE_ACCESS_SECURITY_ATTRIBUTE

create
	make_uipermission_attribute

feature {NONE} -- Initialization

	frozen make_uipermission_attribute (action: SECURITY_ACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Security.Permissions.UIPermissionAttribute"
		end

feature -- Access

	frozen get_window: UIPERMISSION_WINDOW is
		external
			"IL signature (): System.Security.Permissions.UIPermissionWindow use System.Security.Permissions.UIPermissionAttribute"
		alias
			"get_Window"
		end

	frozen get_clipboard: UIPERMISSION_CLIPBOARD is
		external
			"IL signature (): System.Security.Permissions.UIPermissionClipboard use System.Security.Permissions.UIPermissionAttribute"
		alias
			"get_Clipboard"
		end

feature -- Element Change

	frozen set_window (value: UIPERMISSION_WINDOW) is
		external
			"IL signature (System.Security.Permissions.UIPermissionWindow): System.Void use System.Security.Permissions.UIPermissionAttribute"
		alias
			"set_Window"
		end

	frozen set_clipboard (value: UIPERMISSION_CLIPBOARD) is
		external
			"IL signature (System.Security.Permissions.UIPermissionClipboard): System.Void use System.Security.Permissions.UIPermissionAttribute"
		alias
			"set_Clipboard"
		end

feature -- Basic Operations

	create_permission: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.UIPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class UIPERMISSION_ATTRIBUTE
