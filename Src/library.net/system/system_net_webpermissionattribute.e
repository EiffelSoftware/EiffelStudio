indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.WebPermissionAttribute"

frozen external class
	SYSTEM_NET_WEBPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

create
	make_webpermissionattribute

feature {NONE} -- Initialization

	frozen make_webpermissionattribute (action: SYSTEM_SECURITY_PERMISSIONS_SECURITYACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Net.WebPermissionAttribute"
		end

feature -- Access

	frozen get_accept_pattern: STRING is
		external
			"IL signature (): System.String use System.Net.WebPermissionAttribute"
		alias
			"get_AcceptPattern"
		end

	frozen get_connect_pattern: STRING is
		external
			"IL signature (): System.String use System.Net.WebPermissionAttribute"
		alias
			"get_ConnectPattern"
		end

	frozen get_accept: STRING is
		external
			"IL signature (): System.String use System.Net.WebPermissionAttribute"
		alias
			"get_Accept"
		end

	frozen get_connect: STRING is
		external
			"IL signature (): System.String use System.Net.WebPermissionAttribute"
		alias
			"get_Connect"
		end

feature -- Element Change

	frozen set_connect_pattern (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.WebPermissionAttribute"
		alias
			"set_ConnectPattern"
		end

	frozen set_connect (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.WebPermissionAttribute"
		alias
			"set_Connect"
		end

	frozen set_accept (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.WebPermissionAttribute"
		alias
			"set_Accept"
		end

	frozen set_accept_pattern (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.WebPermissionAttribute"
		alias
			"set_AcceptPattern"
		end

feature -- Basic Operations

	create_permission: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Net.WebPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_NET_WEBPERMISSIONATTRIBUTE
