indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.SiteIdentityPermissionAttribute"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_SITEIDENTITYPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

create
	make_siteidentitypermissionattribute

feature {NONE} -- Initialization

	frozen make_siteidentitypermissionattribute (action: SYSTEM_SECURITY_PERMISSIONS_SECURITYACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Security.Permissions.SiteIdentityPermissionAttribute"
		end

feature -- Access

	frozen get_site: STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.SiteIdentityPermissionAttribute"
		alias
			"get_Site"
		end

feature -- Element Change

	frozen set_site (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.SiteIdentityPermissionAttribute"
		alias
			"set_Site"
		end

feature -- Basic Operations

	create_permission: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.SiteIdentityPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_SITEIDENTITYPERMISSIONATTRIBUTE
