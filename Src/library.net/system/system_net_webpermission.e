indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.WebPermission"

external class
	SYSTEM_NET_WEBPERMISSION

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
	make_webpermission_3,
	make_webpermission_2,
	make_webpermission_1,
	make_webpermission

feature {NONE} -- Initialization

	frozen make_webpermission_3 (access: SYSTEM_NET_NETWORKACCESS; uri_string: STRING) is
		external
			"IL creator signature (System.Net.NetworkAccess, System.String) use System.Net.WebPermission"
		end

	frozen make_webpermission_2 (access: SYSTEM_NET_NETWORKACCESS; uri_regex: SYSTEM_TEXT_REGULAREXPRESSIONS_REGEX) is
		external
			"IL creator signature (System.Net.NetworkAccess, System.Text.RegularExpressions.Regex) use System.Net.WebPermission"
		end

	frozen make_webpermission_1 is
		external
			"IL creator use System.Net.WebPermission"
		end

	frozen make_webpermission (state: SYSTEM_SECURITY_PERMISSIONS_PERMISSIONSTATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Net.WebPermission"
		end

feature -- Access

	frozen get_accept_list: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Net.WebPermission"
		alias
			"get_AcceptList"
		end

	frozen get_connect_list: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Net.WebPermission"
		alias
			"get_ConnectList"
		end

feature -- Basic Operations

	frozen add_permission_network_access_string (access: SYSTEM_NET_NETWORKACCESS; uri_string: STRING) is
		external
			"IL signature (System.Net.NetworkAccess, System.String): System.Void use System.Net.WebPermission"
		alias
			"AddPermission"
		end

	intersect (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Net.WebPermission"
		alias
			"Intersect"
		end

	from_xml (security_element: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Net.WebPermission"
		alias
			"FromXml"
		end

	copy: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Net.WebPermission"
		alias
			"Copy"
		end

	union (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Net.WebPermission"
		alias
			"Union"
		end

	frozen add_permission (access: SYSTEM_NET_NETWORKACCESS; uri_regex: SYSTEM_TEXT_REGULAREXPRESSIONS_REGEX) is
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

	to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Net.WebPermission"
		alias
			"ToXml"
		end

	is_subset_of (target: SYSTEM_SECURITY_IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Net.WebPermission"
		alias
			"IsSubsetOf"
		end

end -- class SYSTEM_NET_WEBPERMISSION
