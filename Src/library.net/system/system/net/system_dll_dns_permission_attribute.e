indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.DnsPermissionAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_DNS_PERMISSION_ATTRIBUTE

inherit
	CODE_ACCESS_SECURITY_ATTRIBUTE

create
	make_system_dll_dns_permission_attribute

feature {NONE} -- Initialization

	frozen make_system_dll_dns_permission_attribute (action: SECURITY_ACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Net.DnsPermissionAttribute"
		end

feature -- Basic Operations

	create_permission: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Net.DnsPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_DLL_DNS_PERMISSION_ATTRIBUTE
