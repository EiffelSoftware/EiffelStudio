indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.SocketPermission"

external class
	SYSTEM_NET_SOCKETPERMISSION

inherit
	SYSTEM_SECURITY_IPERMISSION
	SYSTEM_SECURITY_PERMISSIONS_IUNRESTRICTEDPERMISSION
	SYSTEM_SECURITY_ISECURITYENCODABLE
	SYSTEM_SECURITY_CODEACCESSPERMISSION
		redefine
			union
		end
	SYSTEM_SECURITY_ISTACKWALK

create
	make_socketpermission_1,
	make_socketpermission

feature {NONE} -- Initialization

	frozen make_socketpermission_1 (access: SYSTEM_NET_NETWORKACCESS; transport: SYSTEM_NET_TRANSPORTTYPE; host_name: STRING; port_number: INTEGER) is
		external
			"IL creator signature (System.Net.NetworkAccess, System.Net.TransportType, System.String, System.Int32) use System.Net.SocketPermission"
		end

	frozen make_socketpermission (state: SYSTEM_SECURITY_PERMISSIONS_PERMISSIONSTATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Net.SocketPermission"
		end

feature -- Access

	frozen get_accept_list: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Net.SocketPermission"
		alias
			"get_AcceptList"
		end

	frozen all_ports: INTEGER is 0xffffffff

	frozen get_connect_list: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Net.SocketPermission"
		alias
			"get_ConnectList"
		end

feature -- Basic Operations

	intersect (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Net.SocketPermission"
		alias
			"Intersect"
		end

	from_xml (security_element: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Net.SocketPermission"
		alias
			"FromXml"
		end

	copy: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Net.SocketPermission"
		alias
			"Copy"
		end

	union (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Net.SocketPermission"
		alias
			"Union"
		end

	frozen add_permission (access: SYSTEM_NET_NETWORKACCESS; transport: SYSTEM_NET_TRANSPORTTYPE; host_name: STRING; port_number: INTEGER) is
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

	to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Net.SocketPermission"
		alias
			"ToXml"
		end

	is_subset_of (target: SYSTEM_SECURITY_IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Net.SocketPermission"
		alias
			"IsSubsetOf"
		end

end -- class SYSTEM_NET_SOCKETPERMISSION
