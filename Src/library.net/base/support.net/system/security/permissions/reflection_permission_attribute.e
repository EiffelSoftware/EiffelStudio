indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.ReflectionPermissionAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	REFLECTION_PERMISSION_ATTRIBUTE

inherit
	CODE_ACCESS_SECURITY_ATTRIBUTE

create
	make_reflection_permission_attribute

feature {NONE} -- Initialization

	frozen make_reflection_permission_attribute (action: SECURITY_ACTION) is
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

	frozen get_flags: REFLECTION_PERMISSION_FLAG is
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

	frozen set_flags (value: REFLECTION_PERMISSION_FLAG) is
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

	create_permission: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.ReflectionPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class REFLECTION_PERMISSION_ATTRIBUTE
