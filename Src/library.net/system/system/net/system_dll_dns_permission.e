indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.DnsPermission"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_DNS_PERMISSION

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
	make_system_dll_dns_permission

feature {NONE} -- Initialization

	frozen make_system_dll_dns_permission (state: PERMISSION_STATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Net.DnsPermission"
		end

feature -- Basic Operations

	intersect (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Net.DnsPermission"
		alias
			"Intersect"
		end

	from_xml (security_element: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Net.DnsPermission"
		alias
			"FromXml"
		end

	to_xml: SECURITY_ELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Net.DnsPermission"
		alias
			"ToXml"
		end

	frozen is_unrestricted: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.DnsPermission"
		alias
			"IsUnrestricted"
		end

	copy_: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Net.DnsPermission"
		alias
			"Copy"
		end

	is_subset_of (target: IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Net.DnsPermission"
		alias
			"IsSubsetOf"
		end

	union (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Net.DnsPermission"
		alias
			"Union"
		end

end -- class SYSTEM_DLL_DNS_PERMISSION
