indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.SiteIdentityPermissionAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SITE_IDENTITY_PERMISSION_ATTRIBUTE

inherit
	CODE_ACCESS_SECURITY_ATTRIBUTE

create
	make_site_identity_permission_attribute

feature {NONE} -- Initialization

	frozen make_site_identity_permission_attribute (action: SECURITY_ACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Security.Permissions.SiteIdentityPermissionAttribute"
		end

feature -- Access

	frozen get_site: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.SiteIdentityPermissionAttribute"
		alias
			"get_Site"
		end

feature -- Element Change

	frozen set_site (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.SiteIdentityPermissionAttribute"
		alias
			"set_Site"
		end

feature -- Basic Operations

	create_permission: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.SiteIdentityPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SITE_IDENTITY_PERMISSION_ATTRIBUTE
