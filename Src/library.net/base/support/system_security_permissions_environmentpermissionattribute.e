indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.EnvironmentPermissionAttribute"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_ENVIRONMENTPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

create
	make_environmentpermissionattribute

feature {NONE} -- Initialization

	frozen make_environmentpermissionattribute (action: SYSTEM_SECURITY_PERMISSIONS_SECURITYACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Security.Permissions.EnvironmentPermissionAttribute"
		end

feature -- Access

	frozen get_read: STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.EnvironmentPermissionAttribute"
		alias
			"get_Read"
		end

	frozen get_write: STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.EnvironmentPermissionAttribute"
		alias
			"get_Write"
		end

feature -- Element Change

	frozen set_read (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.EnvironmentPermissionAttribute"
		alias
			"set_Read"
		end

	frozen set_write (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.EnvironmentPermissionAttribute"
		alias
			"set_Write"
		end

	frozen set_all (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.EnvironmentPermissionAttribute"
		alias
			"set_All"
		end

feature -- Basic Operations

	create_permission: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.EnvironmentPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_ENVIRONMENTPERMISSIONATTRIBUTE
