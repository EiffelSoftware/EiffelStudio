indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.WebPermission"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_WEB_PERMISSION

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
	make_system_dll_web_permission,
	make_system_dll_web_permission_1,
	make_system_dll_web_permission_3,
	make_system_dll_web_permission_2

feature {NONE} -- Initialization

	frozen make_system_dll_web_permission (state: PERMISSION_STATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Net.WebPermission"
		end

	frozen make_system_dll_web_permission_1 is
		external
			"IL creator use System.Net.WebPermission"
		end

	frozen make_system_dll_web_permission_3 (access: SYSTEM_DLL_NETWORK_ACCESS; uri_string: SYSTEM_STRING) is
		external
			"IL creator signature (System.Net.NetworkAccess, System.String) use System.Net.WebPermission"
		end

	frozen make_system_dll_web_permission_2 (access: SYSTEM_DLL_NETWORK_ACCESS; uri_regex: SYSTEM_DLL_REGEX) is
		external
			"IL creator signature (System.Net.NetworkAccess, System.Text.RegularExpressions.Regex) use System.Net.WebPermission"
		end

feature -- Access

	frozen get_accept_list: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Net.WebPermission"
		alias
			"get_AcceptList"
		end

	frozen get_connect_list: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Net.WebPermission"
		alias
			"get_ConnectList"
		end

feature -- Basic Operations

	frozen add_permission_network_access_string (access: SYSTEM_DLL_NETWORK_ACCESS; uri_string: SYSTEM_STRING) is
		external
			"IL signature (System.Net.NetworkAccess, System.String): System.Void use System.Net.WebPermission"
		alias
			"AddPermission"
		end

	intersect (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Net.WebPermission"
		alias
			"Intersect"
		end

	from_xml (security_element: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Net.WebPermission"
		alias
			"FromXml"
		end

	union (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Net.WebPermission"
		alias
			"Union"
		end

	frozen add_permission (access: SYSTEM_DLL_NETWORK_ACCESS; uri_regex: SYSTEM_DLL_REGEX) is
		external
			"IL signature (System.Net.NetworkAccess, System.Text.RegularExpressions.Regex): System.Void use System.Net.WebPermission"
		alias
			"AddPermission"
		end

	frozen is_unrestricted: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.WebPermission"
		alias
			"IsUnrestricted"
		end

	to_xml: SECURITY_ELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Net.WebPermission"
		alias
			"ToXml"
		end

	copy_: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Net.WebPermission"
		alias
			"Copy"
		end

	is_subset_of (target: IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Net.WebPermission"
		alias
			"IsSubsetOf"
		end

end -- class SYSTEM_DLL_WEB_PERMISSION
