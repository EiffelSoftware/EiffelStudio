indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Permissions.ZoneIdentityPermissionAttribute"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_ZONEIDENTITYPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

create
	make_zoneidentitypermissionattribute

feature {NONE} -- Initialization

	frozen make_zoneidentitypermissionattribute (action: INTEGER) is
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
			"IL creator signature (enum System.Security.Permissions.SecurityAction) use System.Security.Permissions.ZoneIdentityPermissionAttribute"
		end

feature -- Access

	frozen get_zone: INTEGER is
		external
			"IL signature (): enum System.Security.SecurityZone use System.Security.Permissions.ZoneIdentityPermissionAttribute"
		alias
			"get_Zone"
		ensure
			valid_security_zone: Result = 0 or Result = 1 or Result = 2 or Result = 3 or Result = 4 or Result = -1
		end

feature -- Element Change

	frozen set_zone (value: INTEGER) is
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
			"IL signature (enum System.Security.SecurityZone): System.Void use System.Security.Permissions.ZoneIdentityPermissionAttribute"
		alias
			"set_Zone"
		end

feature -- Basic Operations

	create_permission: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.ZoneIdentityPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_ZONEIDENTITYPERMISSIONATTRIBUTE
