indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.DnsPermissionAttribute"

frozen external class
	SYSTEM_NET_DNSPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

create
	make_dnspermissionattribute

feature {NONE} -- Initialization

	frozen make_dnspermissionattribute (action: SYSTEM_SECURITY_PERMISSIONS_SECURITYACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Net.DnsPermissionAttribute"
		end

feature -- Basic Operations

	create_permission: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Net.DnsPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_NET_DNSPERMISSIONATTRIBUTE
