indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.ZoneIdentityPermission"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ZONE_IDENTITY_PERMISSION

inherit
	CODE_ACCESS_PERMISSION
		redefine
			union
		end
	IPERMISSION
	ISECURITY_ENCODABLE
	ISTACK_WALK

create
	make_zone_identity_permission_1,
	make_zone_identity_permission

feature {NONE} -- Initialization

	frozen make_zone_identity_permission_1 (zone: SECURITY_ZONE) is
		external
			"IL creator signature (System.Security.SecurityZone) use System.Security.Permissions.ZoneIdentityPermission"
		end

	frozen make_zone_identity_permission (state: PERMISSION_STATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Security.Permissions.ZoneIdentityPermission"
		end

feature -- Access

	frozen get_security_zone: SECURITY_ZONE is
		external
			"IL signature (): System.Security.SecurityZone use System.Security.Permissions.ZoneIdentityPermission"
		alias
			"get_SecurityZone"
		end

feature -- Element Change

	frozen set_security_zone (value: SECURITY_ZONE) is
		external
			"IL signature (System.Security.SecurityZone): System.Void use System.Security.Permissions.ZoneIdentityPermission"
		alias
			"set_SecurityZone"
		end

feature -- Basic Operations

	from_xml (esd: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.ZoneIdentityPermission"
		alias
			"FromXml"
		end

	to_xml: SECURITY_ELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Permissions.ZoneIdentityPermission"
		alias
			"ToXml"
		end

	intersect (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.ZoneIdentityPermission"
		alias
			"Intersect"
		end

	copy_: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.ZoneIdentityPermission"
		alias
			"Copy"
		end

	is_subset_of (target: IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.ZoneIdentityPermission"
		alias
			"IsSubsetOf"
		end

	union (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.ZoneIdentityPermission"
		alias
			"Union"
		end

end -- class ZONE_IDENTITY_PERMISSION
