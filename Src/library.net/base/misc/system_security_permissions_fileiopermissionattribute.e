indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Permissions.FileIOPermissionAttribute"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_FILEIOPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

create
	make_fileiopermissionattribute

feature {NONE} -- Initialization

	frozen make_fileiopermissionattribute (action: INTEGER) is
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
			"IL creator signature (enum System.Security.Permissions.SecurityAction) use System.Security.Permissions.FileIOPermissionAttribute"
		end

feature -- Access

	frozen get_read: STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.FileIOPermissionAttribute"
		alias
			"get_Read"
		end

	frozen get_append: STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.FileIOPermissionAttribute"
		alias
			"get_Append"
		end

	frozen get_path_discovery: STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.FileIOPermissionAttribute"
		alias
			"get_PathDiscovery"
		end

	frozen get_write: STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.FileIOPermissionAttribute"
		alias
			"get_Write"
		end

feature -- Element Change

	frozen set_read (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.FileIOPermissionAttribute"
		alias
			"set_Read"
		end

	frozen set_write (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.FileIOPermissionAttribute"
		alias
			"set_Write"
		end

	frozen set_path_discovery (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.FileIOPermissionAttribute"
		alias
			"set_PathDiscovery"
		end

	frozen set_append (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.FileIOPermissionAttribute"
		alias
			"set_Append"
		end

	frozen set_all (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.FileIOPermissionAttribute"
		alias
			"set_All"
		end

feature -- Basic Operations

	create_permission: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.FileIOPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_FILEIOPERMISSIONATTRIBUTE
