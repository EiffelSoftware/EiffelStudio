indexing
	Generator: "Eiffel Emitter 2.5b2"
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

	frozen make_uipermission (state: INTEGER) is
			-- Valid values for `state' are:
			-- Unrestricted = 1
			-- None = 0
		require
			valid_permission_state: state = 1 or state = 0
		external
			"IL creator signature (enum System.Security.Permissions.PermissionState) use System.Security.Permissions.UIPermission"
		end

	frozen make_uipermission_3 (clipboard_flag: INTEGER) is
			-- Valid values for `clipboard_flag' are:
			-- NoClipboard = 0
			-- OwnClipboard = 1
			-- AllClipboard = 2
		require
			valid_uipermission_clipboard: clipboard_flag = 0 or clipboard_flag = 1 or clipboard_flag = 2
		external
			"IL creator signature (enum System.Security.Permissions.UIPermissionClipboard) use System.Security.Permissions.UIPermission"
		end

	frozen make_uipermission_2 (window_flag: INTEGER) is
			-- Valid values for `window_flag' are:
			-- NoWindows = 0
			-- SafeSubWindows = 1
			-- SafeTopLevelWindows = 2
			-- AllWindows = 3
		require
			valid_uipermission_window: window_flag = 0 or window_flag = 1 or window_flag = 2 or window_flag = 3
		external
			"IL creator signature (enum System.Security.Permissions.UIPermissionWindow) use System.Security.Permissions.UIPermission"
		end

	frozen make_uipermission_1 (window_flag: INTEGER; clipboard_flag: INTEGER) is
			-- Valid values for `clipboard_flag' are:
			-- NoClipboard = 0
			-- OwnClipboard = 1
			-- AllClipboard = 2
		require
			valid_uipermission_clipboard: clipboard_flag = 0 or clipboard_flag = 1 or clipboard_flag = 2
		external
			"IL creator signature (enum System.Security.Permissions.UIPermissionWindow, enum System.Security.Permissions.UIPermissionClipboard) use System.Security.Permissions.UIPermission"
		end

feature -- Access

	frozen get_window: INTEGER is
		external
			"IL signature (): enum System.Security.Permissions.UIPermissionWindow use System.Security.Permissions.UIPermission"
		alias
			"get_Window"
		ensure
			valid_uipermission_window: Result = 0 or Result = 1 or Result = 2 or Result = 3
		end

	frozen get_clipboard: INTEGER is
		external
			"IL signature (): enum System.Security.Permissions.UIPermissionClipboard use System.Security.Permissions.UIPermission"
		alias
			"get_Clipboard"
		ensure
			valid_uipermission_clipboard: Result = 0 or Result = 1 or Result = 2
		end

feature -- Element Change

	frozen set_window (value: INTEGER) is
			-- Valid values for `value' are:
			-- NoWindows = 0
			-- SafeSubWindows = 1
			-- SafeTopLevelWindows = 2
			-- AllWindows = 3
		require
			valid_uipermission_window: value = 0 or value = 1 or value = 2 or value = 3
		external
			"IL signature (enum System.Security.Permissions.UIPermissionWindow): System.Void use System.Security.Permissions.UIPermission"
		alias
			"set_Window"
		end

	frozen set_clipboard (value: INTEGER) is
			-- Valid values for `value' are:
			-- NoClipboard = 0
			-- OwnClipboard = 1
			-- AllClipboard = 2
		require
			valid_uipermission_clipboard: value = 0 or value = 1 or value = 2
		external
			"IL signature (enum System.Security.Permissions.UIPermissionClipboard): System.Void use System.Security.Permissions.UIPermission"
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
