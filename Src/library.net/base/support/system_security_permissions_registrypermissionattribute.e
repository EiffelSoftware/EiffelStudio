indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.RegistryPermissionAttribute"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_REGISTRYPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

create
	make_registrypermissionattribute

feature {NONE} -- Initialization

	frozen make_registrypermissionattribute (action: SYSTEM_SECURITY_PERMISSIONS_SECURITYACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Security.Permissions.RegistryPermissionAttribute"
		end

feature -- Access

	frozen get_read: STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.RegistryPermissionAttribute"
		alias
			"get_Read"
		end

	frozen get_create: STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.RegistryPermissionAttribute"
		alias
			"get_Create"
		end

	frozen get_write: STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.RegistryPermissionAttribute"
		alias
			"get_Write"
		end

feature -- Element Change

	frozen set_read (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.RegistryPermissionAttribute"
		alias
			"set_Read"
		end

	frozen set_write (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.RegistryPermissionAttribute"
		alias
			"set_Write"
		end

	frozen set_create (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.RegistryPermissionAttribute"
		alias
			"set_Create"
		end

	frozen set_all (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.RegistryPermissionAttribute"
		alias
			"set_All"
		end

feature -- Basic Operations

	create_permission: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.RegistryPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_REGISTRYPERMISSIONATTRIBUTE
