indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Permissions.FileDialogPermissionAttribute"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_FILEDIALOGPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

create
	make_filedialogpermissionattribute

feature {NONE} -- Initialization

	frozen make_filedialogpermissionattribute (action: INTEGER) is
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
			"IL creator signature (enum System.Security.Permissions.SecurityAction) use System.Security.Permissions.FileDialogPermissionAttribute"
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
