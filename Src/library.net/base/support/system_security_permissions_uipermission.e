indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.UIPermission"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_UIPERMISSION

inherit
	SYSTEM_SECURITY_CODEACCESSPERMISSION
		redefine
			union
		end
	SYSTEM_SECURITY_IPERMISSION
	SYSTEM_SECURITY_ISECURITYENCODABLE
	SYSTEM_SECURITY_ISTACKWALK
	SYSTEM_SECURITY_PERMISSIONS_IUNRESTRICTEDPERMISSION

create
	make_uipermission,
	make_uipermission_3,
	make_uipermission_2,
	make_uipermission_1

feature {NONE} -- Initialization

	frozen make_uipermission (state: SYSTEM_SECURITY_PERMISSIONS_PERMISSIONSTATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Security.Permissions.UIPermission"
		end

	frozen make_uipermission_3 (clipboard_flag: SYSTEM_SECURITY_PERMISSIONS_UIPERMISSIONCLIPBOARD) is
		external
			"IL creator signature (System.Security.Permissions.UIPermissionClipboard) use System.Security.Permissions.UIPermission"
		end

	frozen make_uipermission_2 (window_flag: SYSTEM_SECURITY_PERMISSIONS_UIPERMISSIONWINDOW) is
		external
			"IL creator signature (System.Security.Permissions.UIPermissionWindow) use System.Security.Permissions.UIPermission"
		end

	frozen make_uipermission_1 (window_flag: SYSTEM_SECURITY_PERMISSIONS_UIPERMISSIONWINDOW; clipboard_flag: SYSTEM_SECURITY_PERMISSIONS_UIPERMISSIONCLIPBOARD) is
		external
			"IL creator signature (System.Security.Permissions.UIPermissionWindow, System.Security.Permissions.UIPermissionClipboard) use System.Security.Permissions.UIPermission"
		end

feature -- Access

	frozen get_window: SYSTEM_SECURITY_PERMISSIONS_UIPERMISSIONWINDOW is
		external
			"IL signature (): System.Security.Permissions.UIPermissionWindow use System.Security.Permissions.UIPermission"
		alias
			"get_Window"
		end

	frozen get_clipboard: SYSTEM_SECURITY_PERMISSIONS_UIPERMISSIONCLIPBOARD is
		external
			"IL signature (): System.Security.Permissions.UIPermissionClipboard use System.Security.Permissions.UIPermission"
		alias
			"get_Clipboard"
		end

feature -- Element Change

	frozen set_window (value: SYSTEM_SECURITY_PERMISSIONS_UIPERMISSIONWINDOW) is
		external
			"IL signature (System.Security.Permissions.UIPermissionWindow): System.Void use System.Security.Permissions.UIPermission"
		alias
			"set_Window"
		end

	frozen set_clipboard (value: SYSTEM_SECURITY_PERMISSIONS_UIPERMISSIONCLIPBOARD) is
		external
			"IL signature (System.Security.Permissions.UIPermissionClipboard): System.Void use System.Security.Permissions.UIPermission"
		alias
			"set_Clipboard"
		end

feature -- Basic Operations

	intersect (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.UIPermission"
		alias
			"Intersect"
		end

	from_xml (esd: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.UIPermission"
		alias
			"FromXml"
		end

	to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
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

	is_subset_of (target: SYSTEM_SECURITY_IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.UIPermission"
		alias
			"IsSubsetOf"
		end

	union (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.UIPermission"
		alias
			"Union"
		end

	copy: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.UIPermission"
		alias
			"Copy"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_UIPERMISSION
