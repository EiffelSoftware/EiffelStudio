indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.SocketPermissionAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_SOCKET_PERMISSION_ATTRIBUTE

inherit
	CODE_ACCESS_SECURITY_ATTRIBUTE

create
	make_system_dll_socket_permission_attribute

feature {NONE} -- Initialization

	frozen make_system_dll_socket_permission_attribute (action: SECURITY_ACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Net.SocketPermissionAttribute"
		end

feature -- Access

	frozen get_access: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.SocketPermissionAttribute"
		alias
			"get_Access"
		end

	frozen get_port: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.SocketPermissionAttribute"
		alias
			"get_Port"
		end

	frozen get_host: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.SocketPermissionAttribute"
		alias
			"get_Host"
		end

	frozen get_transport: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.SocketPermissionAttribute"
		alias
			"get_Transport"
		end

feature -- Element Change

	frozen set_port (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.SocketPermissionAttribute"
		alias
			"set_Port"
		end

	frozen set_transport (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.SocketPermissionAttribute"
		alias
			"set_Transport"
		end

	frozen set_host (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.SocketPermissionAttribute"
		alias
			"set_Host"
		end

	frozen set_access (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.SocketPermissionAttribute"
		alias
			"set_Access"
		end

feature -- Basic Operations

	create_permission: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Net.SocketPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_DLL_SOCKET_PERMISSION_ATTRIBUTE
