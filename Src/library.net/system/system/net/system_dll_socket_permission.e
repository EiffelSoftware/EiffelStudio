indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.SocketPermission"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_SOCKET_PERMISSION

inherit
	CODE_ACCESS_PERMISSION
		redefine
			union
		end
	IPERMISSION
	ISECURITY_ENCODABLE
	ISTACK_WALK
	IUNRESTRICTED_PERMISSION

create
	make_system_dll_socket_permission,
	make_system_dll_socket_permission_1

feature {NONE} -- Initialization

	frozen make_system_dll_socket_permission (state: PERMISSION_STATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Net.SocketPermission"
		end

	frozen make_system_dll_socket_permission_1 (access: SYSTEM_DLL_NETWORK_ACCESS; transport: SYSTEM_DLL_TRANSPORT_TYPE; host_name: SYSTEM_STRING; port_number: INTEGER) is
		external
			"IL creator signature (System.Net.NetworkAccess, System.Net.TransportType, System.String, System.Int32) use System.Net.SocketPermission"
		end

feature -- Access

	frozen get_accept_list: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Net.SocketPermission"
		alias
			"get_AcceptList"
		end

	frozen all_ports: INTEGER is 0xffffffff

	frozen get_connect_list: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Net.SocketPermission"
		alias
			"get_ConnectList"
		end

feature -- Basic Operations

	intersect (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Net.SocketPermission"
		alias
			"Intersect"
		end

	from_xml (security_element: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Net.SocketPermission"
		alias
			"FromXml"
		end

	union (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Net.SocketPermission"
		alias
			"Union"
		end

	frozen add_permission (access: SYSTEM_DLL_NETWORK_ACCESS; transport: SYSTEM_DLL_TRANSPORT_TYPE; host_name: SYSTEM_STRING; port_number: INTEGER) is
		external
			"IL signature (System.Net.NetworkAccess, System.Net.TransportType, System.String, System.Int32): System.Void use System.Net.SocketPermission"
		alias
			"AddPermission"
		end

	frozen is_unrestricted: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.SocketPermission"
		alias
			"IsUnrestricted"
		end

	to_xml: SECURITY_ELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Net.SocketPermission"
		alias
			"ToXml"
		end

	copy_: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Net.SocketPermission"
		alias
			"Copy"
		end

	is_subset_of (target: IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Net.SocketPermission"
		alias
			"IsSubsetOf"
		end

end -- class SYSTEM_DLL_SOCKET_PERMISSION
