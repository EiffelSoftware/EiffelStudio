indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.ZoneIdentityPermissionAttribute"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_ZONEIDENTITYPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

create
	make_zoneidentitypermissionattribute

feature {NONE} -- Initialization

	frozen make_zoneidentitypermissionattribute (action: SYSTEM_SECURITY_PERMISSIONS_SECURITYACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Security.Permissions.ZoneIdentityPermissionAttribute"
		end

feature -- Access

	frozen get_zone: SYSTEM_SECURITY_SECURITYZONE is
		external
			"IL signature (): System.Security.SecurityZone use System.Security.Permissions.ZoneIdentityPermissionAttribute"
		alias
			"get_Zone"
		end

feature -- Element Change

	frozen set_zone (value: SYSTEM_SECURITY_SECURITYZONE) is
		external
			"IL signature (System.Security.SecurityZone): System.Void use System.Security.Permissions.ZoneIdentityPermissionAttribute"
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
