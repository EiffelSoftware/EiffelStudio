indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.UIPermission"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	UIPERMISSION

inherit
	CODE_ACCESS_PERMISSION
		redefine
			union
		end
	IPERMISSION
	ISECURITY_ENCODABLE
	ISTACK_WALK
	IUNRESTRICTED_PERMISSION

create
	make_uipermission,
	make_uipermission_3,
	make_uipermission_2,
	make_uipermission_1

feature {NONE} -- Initialization

	frozen make_uipermission (state: PERMISSION_STATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Security.Permissions.UIPermission"
		end

	frozen make_uipermission_3 (clipboard_flag: UIPERMISSION_CLIPBOARD) is
		external
			"IL creator signature (System.Security.Permissions.UIPermissionClipboard) use System.Security.Permissions.UIPermission"
		end

	frozen make_uipermission_2 (window_flag: UIPERMISSION_WINDOW) is
		external
			"IL creator signature (System.Security.Permissions.UIPermissionWindow) use System.Security.Permissions.UIPermission"
		end

	frozen make_uipermission_1 (window_flag: UIPERMISSION_WINDOW; clipboard_flag: UIPERMISSION_CLIPBOARD) is
		external
			"IL creator signature (System.Security.Permissions.UIPermissionWindow, System.Security.Permissions.UIPermissionClipboard) use System.Security.Permissions.UIPermission"
		end

feature -- Access

	frozen get_window: UIPERMISSION_WINDOW is
		external
			"IL signature (): System.Security.Permissions.UIPermissionWindow use System.Security.Permissions.UIPermission"
		alias
			"get_Window"
		end

	frozen get_clipboard: UIPERMISSION_CLIPBOARD is
		external
			"IL signature (): System.Security.Permissions.UIPermissionClipboard use System.Security.Permissions.UIPermission"
		alias
			"get_Clipboard"
		end

feature -- Element Change

	frozen set_window (value: UIPERMISSION_WINDOW) is
		external
			"IL signature (System.Security.Permissions.UIPermissionWindow): System.Void use System.Security.Permissions.UIPermission"
		alias
			"set_Window"
		end

	frozen set_clipboard (value: UIPERMISSION_CLIPBOARD) is
		external
			"IL signature (System.Security.Permissions.UIPermissionClipboard): System.Void use System.Security.Permissions.UIPermission"
		alias
			"set_Clipboard"
		end

feature -- Basic Operations

	intersect (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.UIPermission"
		alias
			"Intersect"
		end

	from_xml (esd: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.UIPermission"
		alias
			"FromXml"
		end

	to_xml: SECURITY_ELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Permissions.UIPermission"
		alias
			"ToXml"
		end

	frozen is_unrestricted: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.UIPermission"
		alias
			"IsUnrestricted"
		end

	copy_: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.UIPermission"
		alias
			"Copy"
		end

	is_subset_of (target: IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.UIPermission"
		alias
			"IsSubsetOf"
		end

	union (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.UIPermission"
		alias
			"Union"
		end

end -- class UIPERMISSION
