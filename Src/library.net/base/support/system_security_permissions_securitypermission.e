indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.SecurityPermission"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_SECURITYPERMISSION

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
	make_securitypermission,
	make_securitypermission_1

feature {NONE} -- Initialization

	frozen make_securitypermission (state: SYSTEM_SECURITY_PERMISSIONS_PERMISSIONSTATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Security.Permissions.SecurityPermission"
		end

	frozen make_securitypermission_1 (flag: SYSTEM_SECURITY_PERMISSIONS_SECURITYPERMISSIONFLAG) is
		external
			"IL creator signature (System.Security.Permissions.SecurityPermissionFlag) use System.Security.Permissions.SecurityPermission"
		end

feature -- Access

	frozen get_flags: SYSTEM_SECURITY_PERMISSIONS_SECURITYPERMISSIONFLAG is
		external
			"IL signature (): System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermission"
		alias
			"get_Flags"
		end

feature -- Element Change

	frozen set_flags (value: SYSTEM_SECURITY_PERMISSIONS_SECURITYPERMISSIONFLAG) is
		external
			"IL signature (System.Security.Permissions.SecurityPermissionFlag): System.Void use System.Security.Permissions.SecurityPermission"
		alias
			"set_Flags"
		end

feature -- Basic Operations

	intersect (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.SecurityPermission"
		alias
			"Intersect"
		end

	from_xml (esd: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.SecurityPermission"
		alias
			"FromXml"
		end

	to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Permissions.SecurityPermission"
		alias
			"ToXml"
		end

	frozen is_unrestricted: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.SecurityPermission"
		alias
			"IsUnrestricted"
		end

	is_subset_of (target: SYSTEM_SECURITY_IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.SecurityPermission"
		alias
			"IsSubsetOf"
		end

	union (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.SecurityPermission"
		alias
			"Union"
		end

	copy: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.SecurityPermission"
		alias
			"Copy"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_SECURITYPERMISSION
