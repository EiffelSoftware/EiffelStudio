indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.ResourcePermissionBase"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_RESOURCE_PERMISSION_BASE

inherit
	CODE_ACCESS_PERMISSION
		redefine
			union
		end
	IPERMISSION
	ISECURITY_ENCODABLE
	ISTACK_WALK
	IUNRESTRICTED_PERMISSION

feature -- Access

--	frozen local_: SYSTEM_STRING is "."

--	frozen any: SYSTEM_STRING is "*"

feature -- Basic Operations

	intersect (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.ResourcePermissionBase"
		alias
			"Intersect"
		end

	from_xml (security_element: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.ResourcePermissionBase"
		alias
			"FromXml"
		end

	to_xml: SECURITY_ELEMENT is
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

	copy_: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.ResourcePermissionBase"
		alias
			"Copy"
		end

	is_subset_of (target: IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.ResourcePermissionBase"
		alias
			"IsSubsetOf"
		end

	union (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.ResourcePermissionBase"
		alias
			"Union"
		end

feature {NONE} -- Implementation

	frozen remove_permission_access (entry: SYSTEM_DLL_RESOURCE_PERMISSION_BASE_ENTRY) is
		external
			"IL signature (System.Security.Permissions.ResourcePermissionBaseEntry): System.Void use System.Security.Permissions.ResourcePermissionBase"
		alias
			"RemovePermissionAccess"
		end

	frozen set_permission_access_type (value: TYPE) is
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

	frozen get_tag_names: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Security.Permissions.ResourcePermissionBase"
		alias
			"get_TagNames"
		end

	frozen get_permission_access_type: TYPE is
		external
			"IL signature (): System.Type use System.Security.Permissions.ResourcePermissionBase"
		alias
			"get_PermissionAccessType"
		end

	frozen add_permission_access (entry: SYSTEM_DLL_RESOURCE_PERMISSION_BASE_ENTRY) is
		external
			"IL signature (System.Security.Permissions.ResourcePermissionBaseEntry): System.Void use System.Security.Permissions.ResourcePermissionBase"
		alias
			"AddPermissionAccess"
		end

	frozen get_permission_entries: NATIVE_ARRAY [SYSTEM_DLL_RESOURCE_PERMISSION_BASE_ENTRY] is
		external
			"IL signature (): System.Security.Permissions.ResourcePermissionBaseEntry[] use System.Security.Permissions.ResourcePermissionBase"
		alias
			"GetPermissionEntries"
		end

	frozen set_tag_names (value: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.Security.Permissions.ResourcePermissionBase"
		alias
			"set_TagNames"
		end

end -- class SYSTEM_DLL_RESOURCE_PERMISSION_BASE
