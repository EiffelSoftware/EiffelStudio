indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Permissions.SiteIdentityPermission"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_SITEIDENTITYPERMISSION

inherit
	SYSTEM_SECURITY_CODEACCESSPERMISSION
		redefine
			union
		end
	SYSTEM_SECURITY_IPERMISSION
	SYSTEM_SECURITY_ISECURITYENCODABLE
	SYSTEM_SECURITY_ISTACKWALK

create
	make_siteidentitypermission_1,
	make_siteidentitypermission

feature {NONE} -- Initialization

	frozen make_siteidentitypermission_1 (site: STRING) is
		external
			"IL creator signature (System.String) use System.Security.Permissions.SiteIdentityPermission"
		end

	frozen make_siteidentitypermission (state: INTEGER) is
			-- Valid values for `state' are:
			-- Unrestricted = 1
			-- None = 0
		require
			valid_permission_state: state = 1 or state = 0
		external
			"IL creator signature (enum System.Security.Permissions.PermissionState) use System.Security.Permissions.SiteIdentityPermission"
		end

feature -- Access

	frozen get_site: STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.SiteIdentityPermission"
		alias
			"get_Site"
		end

feature -- Element Change

	frozen set_site (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.SiteIdentityPermission"
		alias
			"set_Site"
		end

feature -- Basic Operations

	from_xml (esd: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.SiteIdentityPermission"
		alias
			"FromXml"
		end

	to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Permissions.SiteIdentityPermission"
		alias
			"ToXml"
		end

	intersect (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.SiteIdentityPermission"
		alias
			"Intersect"
		end

	is_subset_of (target: SYSTEM_SECURITY_IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.SiteIdentityPermission"
		alias
			"IsSubsetOf"
		end

	union (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.SiteIdentityPermission"
		alias
			"Union"
		end

	copy: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.SiteIdentityPermission"
		alias
			"Copy"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_SITEIDENTITYPERMISSION
