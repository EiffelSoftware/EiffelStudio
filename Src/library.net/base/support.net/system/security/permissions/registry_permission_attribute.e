indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.RegistryPermissionAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	REGISTRY_PERMISSION_ATTRIBUTE

inherit
	CODE_ACCESS_SECURITY_ATTRIBUTE

create
	make_registry_permission_attribute

feature {NONE} -- Initialization

	frozen make_registry_permission_attribute (action: SECURITY_ACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Security.Permissions.RegistryPermissionAttribute"
		end

feature -- Access

	frozen get_read: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.RegistryPermissionAttribute"
		alias
			"get_Read"
		end

	frozen get_create: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.RegistryPermissionAttribute"
		alias
			"get_Create"
		end

	frozen get_write: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.RegistryPermissionAttribute"
		alias
			"get_Write"
		end

feature -- Element Change

	frozen set_read (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.RegistryPermissionAttribute"
		alias
			"set_Read"
		end

	frozen set_write (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.RegistryPermissionAttribute"
		alias
			"set_Write"
		end

	frozen set_create (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.RegistryPermissionAttribute"
		alias
			"set_Create"
		end

	frozen set_all (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.RegistryPermissionAttribute"
		alias
			"set_All"
		end

feature -- Basic Operations

	create_permission: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.RegistryPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class REGISTRY_PERMISSION_ATTRIBUTE
