indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.ZoneIdentityPermission"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_ZONEIDENTITYPERMISSION

inherit
	SYSTEM_SECURITY_CODEACCESSPERMISSION
		redefine
			union
		end
	SYSTEM_SECURITY_IPERMISSION
	SYSTEM_SECURITY_ISECURITYENCODABLE
	SYSTEM_SECURITY_ISTACKWALK

create
	make_zoneidentitypermission,
	make_zoneidentitypermission_1

feature {NONE} -- Initialization

	frozen make_zoneidentitypermission (state: SYSTEM_SECURITY_PERMISSIONS_PERMISSIONSTATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Security.Permissions.ZoneIdentityPermission"
		end

	frozen make_zoneidentitypermission_1 (zone: SYSTEM_SECURITY_SECURITYZONE) is
		external
			"IL creator signature (System.Security.SecurityZone) use System.Security.Permissions.ZoneIdentityPermission"
		end

feature -- Access

	frozen get_security_zone: SYSTEM_SECURITY_SECURITYZONE is
		external
			"IL signature (): System.Security.SecurityZone use System.Security.Permissions.ZoneIdentityPermission"
		alias
			"get_SecurityZone"
		end

feature -- Element Change

	frozen set_security_zone (value: SYSTEM_SECURITY_SECURITYZONE) is
		external
			"IL signature (System.Security.SecurityZone): System.Void use System.Security.Permissions.ZoneIdentityPermission"
		alias
			"set_SecurityZone"
		end

feature -- Basic Operations

	from_xml (esd: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.ZoneIdentityPermission"
		alias
			"FromXml"
		end

	to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Permissions.ZoneIdentityPermission"
		alias
			"ToXml"
		end

	intersect (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.ZoneIdentityPermission"
		alias
			"Intersect"
		end

	is_subset_of (target: SYSTEM_SECURITY_IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.ZoneIdentityPermission"
		alias
			"IsSubsetOf"
		end

	union (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.ZoneIdentityPermission"
		alias
			"Union"
		end

	copy: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.ZoneIdentityPermission"
		alias
			"Copy"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_ZONEIDENTITYPERMISSION
