indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.UrlIdentityPermissionAttribute"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_URLIDENTITYPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

create
	make_urlidentitypermissionattribute

feature {NONE} -- Initialization

	frozen make_urlidentitypermissionattribute (action: SYSTEM_SECURITY_PERMISSIONS_SECURITYACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Security.Permissions.UrlIdentityPermissionAttribute"
		end

feature -- Access

	frozen get_url: STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.UrlIdentityPermissionAttribute"
		alias
			"get_Url"
		end

feature -- Element Change

	frozen set_url (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.UrlIdentityPermissionAttribute"
		alias
			"set_Url"
		end

feature -- Basic Operations

	create_permission: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.UrlIdentityPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_URLIDENTITYPERMISSIONATTRIBUTE
