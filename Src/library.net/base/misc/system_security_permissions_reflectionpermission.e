indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Permissions.ReflectionPermission"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_REFLECTIONPERMISSION

inherit
	SYSTEM_SECURITY_CODEACCESSPERMISSION
		redefine
			union
		end
	SYSTEM_SECURITY_IPERMISSION
	SYSTEM_SECURITY_ISECURITYENCODABLE
	SYSTEM_SECURITY_ISTACKWALK
	SYSTEM_SECURITY_PERMISSIONS_IUNRESTRICTEDPERMISSION

create
	make_reflectionpermission_1,
	make_reflectionpermission

feature {NONE} -- Initialization

	frozen make_reflectionpermission_1 (flag: INTEGER) is
			-- Valid values for `flag' are a combination of the following values:
			-- NoFlags = 0
			-- TypeInformation = 1
			-- MemberAccess = 2
			-- ReflectionEmit = 4
			-- AllFlags = 7
		require
			valid_reflection_permission_flag: (0 + 1 + 2 + 4 + 7) & flag = 0 + 1 + 2 + 4 + 7
		external
			"IL creator signature (enum System.Security.Permissions.ReflectionPermissionFlag) use System.Security.Permissions.ReflectionPermission"
		end

	frozen make_reflectionpermission (state: INTEGER) is
			-- Valid values for `state' are:
			-- Unrestricted = 1
			-- None = 0
		require
			valid_permission_state: state = 1 or state = 0
		external
			"IL creator signature (enum System.Security.Permissions.PermissionState) use System.Security.Permissions.ReflectionPermission"
		end

feature -- Access

	frozen get_flags: INTEGER is
		external
			"IL signature (): enum System.Security.Permissions.ReflectionPermissionFlag use System.Security.Permissions.ReflectionPermission"
		alias
			"get_Flags"
		ensure
			valid_reflection_permission_flag: Result = 0 or Result = 1 or Result = 2 or Result = 4 or Result = 7
		end

feature -- Element Change

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
			"IL signature (enum System.Security.Permissions.ReflectionPermissionFlag): System.Void use System.Security.Permissions.ReflectionPermission"
		alias
			"set_Flags"
		end

feature -- Basic Operations

	intersect (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.ReflectionPermission"
		alias
			"Intersect"
		end

	from_xml (esd: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.ReflectionPermission"
		alias
			"FromXml"
		end

	to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Permissions.ReflectionPermission"
		alias
			"ToXml"
		end

	frozen is_unrestricted: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.ReflectionPermission"
		alias
			"IsUnrestricted"
		end

	is_subset_of (target: SYSTEM_SECURITY_IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.ReflectionPermission"
		alias
			"IsSubsetOf"
		end

	union (other: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.ReflectionPermission"
		alias
			"Union"
		end

	copy: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.ReflectionPermission"
		alias
			"Copy"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_REFLECTIONPERMISSION
