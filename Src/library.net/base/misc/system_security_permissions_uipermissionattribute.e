indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Permissions.UIPermissionAttribute"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_UIPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

create
	make_uipermissionattribute

feature {NONE} -- Initialization

	frozen make_uipermissionattribute (action: INTEGER) is
			-- Valid values for `action' are:
			-- Demand = 2
			-- Assert = 3
			-- Deny = 4
			-- PermitOnly = 5
			-- LinkDemand = 6
			-- InheritanceDemand = 7
			-- RequestMinimum = 8
			-- RequestOptional = 9
			-- RequestRefuse = 10
		require
			valid_security_action: action = 2 or action = 3 or action = 4 or action = 5 or action = 6 or action = 7 or action = 8 or action = 9 or action = 10
		external
			"IL creator signature (enum System.Security.Permissions.SecurityAction) use System.Security.Permissions.UIPermissionAttribute"
		end

feature -- Access

	frozen get_window: INTEGER is
		external
			"IL signature (): enum System.Security.Permissions.UIPermissionWindow use System.Security.Permissions.UIPermissionAttribute"
		alias
			"get_Window"
		ensure
			valid_uipermission_window: Result = 0 or Result = 1 or Result = 2 or Result = 3
		end

	frozen get_clipboard: INTEGER is
		external
			"IL signature (): enum System.Security.Permissions.UIPermissionClipboard use System.Security.Permissions.UIPermissionAttribute"
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
			"IL signature (enum System.Security.Permissions.UIPermissionWindow): System.Void use System.Security.Permissions.UIPermissionAttribute"
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
			"IL signature (enum System.Security.Permissions.UIPermissionClipboard): System.Void use System.Security.Permissions.UIPermissionAttribute"
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
