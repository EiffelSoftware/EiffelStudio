indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.SiteIdentityPermission"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SITE_IDENTITY_PERMISSION

inherit
	CODE_ACCESS_PERMISSION
		redefine
			union
		end
	IPERMISSION
	ISECURITY_ENCODABLE
	ISTACK_WALK

create
	make_site_identity_permission,
	make_site_identity_permission_1

feature {NONE} -- Initialization

	frozen make_site_identity_permission (state: PERMISSION_STATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Security.Permissions.SiteIdentityPermission"
		end

	frozen make_site_identity_permission_1 (site: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Security.Permissions.SiteIdentityPermission"
		end

feature -- Access

	frozen get_site: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.SiteIdentityPermission"
		alias
			"get_Site"
		end

feature -- Element Change

	frozen set_site (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.SiteIdentityPermission"
		alias
			"set_Site"
		end

feature -- Basic Operations

	from_xml (esd: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.SiteIdentityPermission"
		alias
			"FromXml"
		end

	to_xml: SECURITY_ELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Permissions.SiteIdentityPermission"
		alias
			"ToXml"
		end

	intersect (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.SiteIdentityPermission"
		alias
			"Intersect"
		end

	copy_: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.SiteIdentityPermission"
		alias
			"Copy"
		end

	is_subset_of (target: IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.SiteIdentityPermission"
		alias
			"IsSubsetOf"
		end

	union (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.SiteIdentityPermission"
		alias
			"Union"
		end

end -- class SITE_IDENTITY_PERMISSION
