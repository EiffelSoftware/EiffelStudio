indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Permissions.UrlIdentityPermission"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_URLIDENTITYPERMISSION

inherit
	SYSTEM_SECURITY_CODEACCESSPERMISSION
		redefine
			union
		end
	SYSTEM_SECURITY_IPERMISSION
	SYSTEM_SECURITY_ISECURITYENCODABLE
	SYSTEM_SECURITY_ISTACKWALK

create
	make_urlidentitypermission_1,
	make_urlidentitypermission

feature {NONE} -- Initialization

	frozen make_urlidentitypermission_1 (site: STRING) is
		external
			"IL creator signature (System.String) use System.Security.Permissions.UrlIdentityPermission"
		end

	frozen make_urlidentitypermission (state: INTEGER) is
			-- Valid values for `state' are:
			-- Unrestricted = 1
			-- None = 0
		require
			valid_permission_state: state = 1 or state = 0
		external
			"IL creator signature (enum System.Security.Permissions.PermissionState) use System.Security.Permissions.UrlIdentityPermission"
		end

feature -- Access

	frozen get_url: STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.UrlIdentityPermission"
		alias
			"get_Url"
		end

feature -- Element Change

	frozen set_url (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.UrlIdentityPermission"
		alias
			"set_Url"
		end

feature -- Basic Operations

	from_xml (esd: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.UrlIdentityPermission"
		alias
			"FromXml"
		end

	to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Permissions.UrlIdentityPermission"
		alias
			"ToXml"
		end

	intersect (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.UrlIdentityPermission"
		alias
			"Intersect"
		end

	is_subset_of (target: SYSTEM_SECURITY_IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.UrlIdentityPermission"
		alias
			"IsSubsetOf"
		end

	union (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.UrlIdentityPermission"
		alias
			"Union"
		end

	copy: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.UrlIdentityPermission"
		alias
			"Copy"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_URLIDENTITYPERMISSION
