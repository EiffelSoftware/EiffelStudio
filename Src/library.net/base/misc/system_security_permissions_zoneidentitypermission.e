indexing
	Generator: "Eiffel Emitter 2.5b2"
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

	frozen make_zoneidentitypermission (state: INTEGER) is
			-- Valid values for `state' are:
			-- Unrestricted = 1
			-- None = 0
		require
			valid_permission_state: state = 1 or state = 0
		external
			"IL creator signature (enum System.Security.Permissions.PermissionState) use System.Security.Permissions.ZoneIdentityPermission"
		end

	frozen make_zoneidentitypermission_1 (zone: INTEGER) is
			-- Valid values for `zone' are:
			-- MyComputer = 0
			-- Intranet = 1
			-- Trusted = 2
			-- Internet = 3
			-- Untrusted = 4
			-- NoZone = -1
		require
			valid_security_zone: zone = 0 or zone = 1 or zone = 2 or zone = 3 or zone = 4 or zone = -1
		external
			"IL creator signature (enum System.Security.SecurityZone) use System.Security.Permissions.ZoneIdentityPermission"
		end

feature -- Access

	frozen get_security_zone: INTEGER is
		external
			"IL signature (): enum System.Security.SecurityZone use System.Security.Permissions.ZoneIdentityPermission"
		alias
			"get_SecurityZone"
		ensure
			valid_security_zone: Result = 0 or Result = 1 or Result = 2 or Result = 3 or Result = 4 or Result = -1
		end

feature -- Element Change

	frozen set_security_zone (value: INTEGER) is
			-- Valid values for `value' are:
			-- MyComputer = 0
			-- Intranet = 1
			-- Trusted = 2
			-- Internet = 3
			-- Untrusted = 4
			-- NoZone = -1
		require
			valid_security_zone: value = 0 or value = 1 or value = 2 or value = 3 or value = 4 or value = -1
		external
			"IL signature (enum System.Security.SecurityZone): System.Void use System.Security.Permissions.ZoneIdentityPermission"
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
