indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.StrongNameIdentityPermissionAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	STRONG_NAME_IDENTITY_PERMISSION_ATTRIBUTE

inherit
	CODE_ACCESS_SECURITY_ATTRIBUTE

create
	make_strong_name_identity_permission_attribute

feature {NONE} -- Initialization

	frozen make_strong_name_identity_permission_attribute (action: SECURITY_ACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Security.Permissions.StrongNameIdentityPermissionAttribute"
		end

feature -- Access

	frozen get_version: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.StrongNameIdentityPermissionAttribute"
		alias
			"get_Version"
		end

	frozen get_public_key: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.StrongNameIdentityPermissionAttribute"
		alias
			"get_PublicKey"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.StrongNameIdentityPermissionAttribute"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.StrongNameIdentityPermissionAttribute"
		alias
			"set_Name"
		end

	frozen set_version (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.StrongNameIdentityPermissionAttribute"
		alias
			"set_Version"
		end

	frozen set_public_key (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.StrongNameIdentityPermissionAttribute"
		alias
			"set_PublicKey"
		end

feature -- Basic Operations

	create_permission: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.StrongNameIdentityPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class STRONG_NAME_IDENTITY_PERMISSION_ATTRIBUTE
