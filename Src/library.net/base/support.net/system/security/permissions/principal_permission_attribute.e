indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.PrincipalPermissionAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	PRINCIPAL_PERMISSION_ATTRIBUTE

inherit
	CODE_ACCESS_SECURITY_ATTRIBUTE

create
	make_principal_permission_attribute

feature {NONE} -- Initialization

	frozen make_principal_permission_attribute (action: SECURITY_ACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Security.Permissions.PrincipalPermissionAttribute"
		end

feature -- Access

	frozen get_authenticated: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.PrincipalPermissionAttribute"
		alias
			"get_Authenticated"
		end

	frozen get_role: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.PrincipalPermissionAttribute"
		alias
			"get_Role"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.PrincipalPermissionAttribute"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.PrincipalPermissionAttribute"
		alias
			"set_Name"
		end

	frozen set_authenticated (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Permissions.PrincipalPermissionAttribute"
		alias
			"set_Authenticated"
		end

	frozen set_role (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.PrincipalPermissionAttribute"
		alias
			"set_Role"
		end

feature -- Basic Operations

	create_permission: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.PrincipalPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class PRINCIPAL_PERMISSION_ATTRIBUTE
