indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.ResourcePermissionBase"

deferred external class
	SYSTEM_SECURITY_PERMISSIONS_RESOURCEPERMISSIONBASE

inherit
	SYSTEM_SECURITY_IPERMISSION
	SYSTEM_SECURITY_PERMISSIONS_IUNRESTRICTEDPERMISSION
	SYSTEM_SECURITY_ISECURITYENCODABLE
	SYSTEM_SECURITY_CODEACCESSPERMISSION
		redefine
			union
		end
	SYSTEM_SECURITY_ISTACKWALK

feature -- Access

feature -- Basic Operations

	intersect (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.ResourcePermissionBase"
		alias
			"Intersect"
		end

	from_xml (security_element: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.ResourcePermissionBase"
		alias
			"FromXml"
		end

	to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Permissions.ResourcePermissionBase"
		alias
			"ToXml"
		end

	frozen is_unrestricted: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.ResourcePermissionBase"
		alias
			"IsUnrestricted"
		end

	is_subset_of (target: SYSTEM_SECURITY_IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.ResourcePermissionBase"
		alias
			"IsSubsetOf"
		end

	union (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.ResourcePermissionBase"
		alias
			"Union"
		end

	copy: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.ResourcePermissionBase"
		alias
			"Copy"
		end

feature {NONE} -- Implementation

	frozen remove_permission_access (entry: SYSTEM_SECURITY_PERMISSIONS_RESOURCEPERMISSIONBASEENTRY) is
		external
			"IL signature (System.Security.Permissions.ResourcePermissionBaseEntry): System.Void use System.Security.Permissions.ResourcePermissionBase"
		alias
			"RemovePermissionAccess"
		end

	frozen set_permission_access_type (value: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Security.Permissions.ResourcePermissionBase"
		alias
			"set_PermissionAccessType"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Security.Permissions.ResourcePermissionBase"
		alias
			"Clear"
		end

	frozen get_tag_names: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Security.Permissions.ResourcePermissionBase"
		alias
			"get_TagNames"
		end

	frozen get_permission_access_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Security.Permissions.ResourcePermissionBase"
		alias
			"get_PermissionAccessType"
		end

	frozen add_permission_access (entry: SYSTEM_SECURITY_PERMISSIONS_RESOURCEPERMISSIONBASEENTRY) is
		external
			"IL signature (System.Security.Permissions.ResourcePermissionBaseEntry): System.Void use System.Security.Permissions.ResourcePermissionBase"
		alias
			"AddPermissionAccess"
		end

	frozen get_permission_entries: ARRAY [SYSTEM_SECURITY_PERMISSIONS_RESOURCEPERMISSIONBASEENTRY] is
		external
			"IL signature (): System.Security.Permissions.ResourcePermissionBaseEntry[] use System.Security.Permissions.ResourcePermissionBase"
		alias
			"GetPermissionEntries"
		end

	frozen set_tag_names (value: ARRAY [STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.Security.Permissions.ResourcePermissionBase"
		alias
			"set_TagNames"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_RESOURCEPERMISSIONBASE
