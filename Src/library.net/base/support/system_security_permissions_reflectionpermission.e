indexing
	Generator: "Eiffel Emitter 2.7b2"
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

	frozen make_reflectionpermission_1 (flag: SYSTEM_SECURITY_PERMISSIONS_REFLECTIONPERMISSIONFLAG) is
		external
			"IL creator signature (System.Security.Permissions.ReflectionPermissionFlag) use System.Security.Permissions.ReflectionPermission"
		end

	frozen make_reflectionpermission (state: SYSTEM_SECURITY_PERMISSIONS_PERMISSIONSTATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Security.Permissions.ReflectionPermission"
		end

feature -- Access

	frozen get_flags: SYSTEM_SECURITY_PERMISSIONS_REFLECTIONPERMISSIONFLAG is
		external
			"IL signature (): System.Security.Permissions.ReflectionPermissionFlag use System.Security.Permissions.ReflectionPermission"
		alias
			"get_Flags"
		end

feature -- Element Change

	frozen set_flags (value: SYSTEM_SECURITY_PERMISSIONS_REFLECTIONPERMISSIONFLAG) is
		external
			"IL signature (System.Security.Permissions.ReflectionPermissionFlag): System.Void use System.Security.Permissions.ReflectionPermission"
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
