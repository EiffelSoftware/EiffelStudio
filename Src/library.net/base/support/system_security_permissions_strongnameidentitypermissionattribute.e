indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.StrongNameIdentityPermissionAttribute"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_STRONGNAMEIDENTITYPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

create
	make_strongnameidentitypermissionattribute

feature {NONE} -- Initialization

	frozen make_strongnameidentitypermissionattribute (action: SYSTEM_SECURITY_PERMISSIONS_SECURITYACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Security.Permissions.StrongNameIdentityPermissionAttribute"
		end

feature -- Access

	frozen get_version: STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.StrongNameIdentityPermissionAttribute"
		alias
			"get_Version"
		end

	frozen get_public_key: STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.StrongNameIdentityPermissionAttribute"
		alias
			"get_PublicKey"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.StrongNameIdentityPermissionAttribute"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.StrongNameIdentityPermissionAttribute"
		alias
			"set_Name"
		end

	frozen set_version (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.StrongNameIdentityPermissionAttribute"
		alias
			"set_Version"
		end

	frozen set_public_key (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.StrongNameIdentityPermissionAttribute"
		alias
			"set_PublicKey"
		end

feature -- Basic Operations

	create_permission: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.StrongNameIdentityPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_STRONGNAMEIDENTITYPERMISSIONATTRIBUTE
