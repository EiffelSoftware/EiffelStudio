indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.UrlIdentityPermissionAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	URL_IDENTITY_PERMISSION_ATTRIBUTE

inherit
	CODE_ACCESS_SECURITY_ATTRIBUTE

create
	make_url_identity_permission_attribute

feature {NONE} -- Initialization

	frozen make_url_identity_permission_attribute (action: SECURITY_ACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Security.Permissions.UrlIdentityPermissionAttribute"
		end

feature -- Access

	frozen get_url: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.UrlIdentityPermissionAttribute"
		alias
			"get_Url"
		end

feature -- Element Change

	frozen set_url (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.UrlIdentityPermissionAttribute"
		alias
			"set_Url"
		end

feature -- Basic Operations

	create_permission: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.UrlIdentityPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class URL_IDENTITY_PERMISSION_ATTRIBUTE
