indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.WebPermissionAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_WEB_PERMISSION_ATTRIBUTE

inherit
	CODE_ACCESS_SECURITY_ATTRIBUTE

create
	make_system_dll_web_permission_attribute

feature {NONE} -- Initialization

	frozen make_system_dll_web_permission_attribute (action: SECURITY_ACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Net.WebPermissionAttribute"
		end

feature -- Access

	frozen get_accept_pattern: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.WebPermissionAttribute"
		alias
			"get_AcceptPattern"
		end

	frozen get_connect_pattern: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.WebPermissionAttribute"
		alias
			"get_ConnectPattern"
		end

	frozen get_accept: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.WebPermissionAttribute"
		alias
			"get_Accept"
		end

	frozen get_connect: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.WebPermissionAttribute"
		alias
			"get_Connect"
		end

feature -- Element Change

	frozen set_connect_pattern (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.WebPermissionAttribute"
		alias
			"set_ConnectPattern"
		end

	frozen set_connect (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.WebPermissionAttribute"
		alias
			"set_Connect"
		end

	frozen set_accept (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.WebPermissionAttribute"
		alias
			"set_Accept"
		end

	frozen set_accept_pattern (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.WebPermissionAttribute"
		alias
			"set_AcceptPattern"
		end

feature -- Basic Operations

	create_permission: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Net.WebPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_DLL_WEB_PERMISSION_ATTRIBUTE
