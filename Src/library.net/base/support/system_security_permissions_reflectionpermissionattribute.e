indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.ReflectionPermissionAttribute"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_REFLECTIONPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

create
	make_reflectionpermissionattribute

feature {NONE} -- Initialization

	frozen make_reflectionpermissionattribute (action: SYSTEM_SECURITY_PERMISSIONS_SECURITYACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Security.Permissions.ReflectionPermissionAttribute"
		end

feature -- Access

	frozen get_type_information: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.ReflectionPermissionAttribute"
		alias
			"get_TypeInformation"
		end

	frozen get_flags: SYSTEM_SECURITY_PERMISSIONS_REFLECTIONPERMISSIONFLAG is
		external
			"IL signature (): System.Security.Permissions.ReflectionPermissionFlag use System.Security.Permissions.ReflectionPermissionAttribute"
		alias
			"get_Flags"
		end

	frozen get_reflection_emit: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.ReflectionPermissionAttribute"
		alias
			"get_ReflectionEmit"
		end

	frozen get_member_access: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.ReflectionPermissionAttribute"
		alias
			"get_MemberAccess"
		end

feature -- Element Change

	frozen set_reflection_emit (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Permissions.ReflectionPermissionAttribute"
		alias
			"set_ReflectionEmit"
		end

	frozen set_type_information (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Permissions.ReflectionPermissionAttribute"
		alias
			"set_TypeInformation"
		end

	frozen set_flags (value: SYSTEM_SECURITY_PERMISSIONS_REFLECTIONPERMISSIONFLAG) is
		external
			"IL signature (System.Security.Permissions.ReflectionPermissionFlag): System.Void use System.Security.Permissions.ReflectionPermissionAttribute"
		alias
			"set_Flags"
		end

	frozen set_member_access (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Permissions.ReflectionPermissionAttribute"
		alias
			"set_MemberAccess"
		end

feature -- Basic Operations

	create_permission: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.ReflectionPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_REFLECTIONPERMISSIONATTRIBUTE
