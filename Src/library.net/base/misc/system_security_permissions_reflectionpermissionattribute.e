indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Permissions.ReflectionPermissionAttribute"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_REFLECTIONPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

create
	make_reflectionpermissionattribute

feature {NONE} -- Initialization

	frozen make_reflectionpermissionattribute (action: INTEGER) is
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
			"IL creator signature (enum System.Security.Permissions.SecurityAction) use System.Security.Permissions.ReflectionPermissionAttribute"
		end

feature -- Access

	frozen get_type_information: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.ReflectionPermissionAttribute"
		alias
			"get_TypeInformation"
		end

	frozen get_flags: INTEGER is
		external
			"IL signature (): enum System.Security.Permissions.ReflectionPermissionFlag use System.Security.Permissions.ReflectionPermissionAttribute"
		alias
			"get_Flags"
		ensure
			valid_reflection_permission_flag: Result = 0 or Result = 1 or Result = 2 or Result = 4 or Result = 7
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

	frozen set_flags (value: INTEGER) is
			-- Valid values for `value' are a combination of the following values:
			-- NoFlags = 0
			-- TypeInformation = 1
			-- MemberAccess = 2
			-- ReflectionEmit = 4
			-- AllFlags = 7
		require
			valid_reflection_permission_flag: (0 + 1 + 2 + 4 + 7) & value = 0 + 1 + 2 + 4 + 7
		external
			"IL signature (enum System.Security.Permissions.ReflectionPermissionFlag): System.Void use System.Security.Permissions.ReflectionPermissionAttribute"
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
