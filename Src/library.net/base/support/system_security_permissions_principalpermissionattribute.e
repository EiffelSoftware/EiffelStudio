indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.PrincipalPermissionAttribute"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_PRINCIPALPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

create
	make_principalpermissionattribute

feature {NONE} -- Initialization

	frozen make_principalpermissionattribute (action: SYSTEM_SECURITY_PERMISSIONS_SECURITYACTION) is
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

	frozen get_role: STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.PrincipalPermissionAttribute"
		alias
			"get_Role"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.PrincipalPermissionAttribute"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_name (value: STRING) is
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

	frozen set_role (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.PrincipalPermissionAttribute"
		alias
			"set_Role"
		end

feature -- Basic Operations

	create_permission: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.PrincipalPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_PRINCIPALPERMISSIONATTRIBUTE
