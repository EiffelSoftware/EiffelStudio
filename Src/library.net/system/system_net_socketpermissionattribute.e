indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.SocketPermissionAttribute"

frozen external class
	SYSTEM_NET_SOCKETPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

create
	make_socketpermissionattribute

feature {NONE} -- Initialization

	frozen make_socketpermissionattribute (action: SYSTEM_SECURITY_PERMISSIONS_SECURITYACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Net.SocketPermissionAttribute"
		end

feature -- Access

	frozen get_access: STRING is
		external
			"IL signature (): System.String use System.Net.SocketPermissionAttribute"
		alias
			"get_Access"
		end

	frozen get_port: STRING is
		external
			"IL signature (): System.String use System.Net.SocketPermissionAttribute"
		alias
			"get_Port"
		end

	frozen get_host: STRING is
		external
			"IL signature (): System.String use System.Net.SocketPermissionAttribute"
		alias
			"get_Host"
		end

	frozen get_transport: STRING is
		external
			"IL signature (): System.String use System.Net.SocketPermissionAttribute"
		alias
			"get_Transport"
		end

feature -- Element Change

	frozen set_port (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.SocketPermissionAttribute"
		alias
			"set_Port"
		end

	frozen set_transport (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.SocketPermissionAttribute"
		alias
			"set_Transport"
		end

	frozen set_host (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.SocketPermissionAttribute"
		alias
			"set_Host"
		end

	frozen set_access (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.SocketPermissionAttribute"
		alias
			"set_Access"
		end

feature -- Basic Operations

	create_permission: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Net.SocketPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_NET_SOCKETPERMISSIONATTRIBUTE
