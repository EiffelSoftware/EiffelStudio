indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.ZoneIdentityPermissionAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ZONE_IDENTITY_PERMISSION_ATTRIBUTE

inherit
	CODE_ACCESS_SECURITY_ATTRIBUTE

create
	make_zone_identity_permission_attribute

feature {NONE} -- Initialization

	frozen make_zone_identity_permission_attribute (action: SECURITY_ACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Security.Permissions.ZoneIdentityPermissionAttribute"
		end

feature -- Access

	frozen get_zone: SECURITY_ZONE is
		external
			"IL signature (): System.Security.SecurityZone use System.Security.Permissions.ZoneIdentityPermissionAttribute"
		alias
			"get_Zone"
		end

feature -- Element Change

	frozen set_zone (value: SECURITY_ZONE) is
		external
			"IL signature (System.Security.SecurityZone): System.Void use System.Security.Permissions.ZoneIdentityPermissionAttribute"
		alias
			"set_Zone"
		end

feature -- Basic Operations

	create_permission: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.ZoneIdentityPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class ZONE_IDENTITY_PERMISSION_ATTRIBUTE
