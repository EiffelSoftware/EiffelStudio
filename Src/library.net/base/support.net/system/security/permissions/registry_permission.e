indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.RegistryPermission"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	REGISTRY_PERMISSION

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
	make_registry_permission_1,
	make_registry_permission

feature {NONE} -- Initialization

	frozen make_registry_permission_1 (access: REGISTRY_PERMISSION_ACCESS; path_list: SYSTEM_STRING) is
		external
			"IL creator signature (System.Security.Permissions.RegistryPermissionAccess, System.String) use System.Security.Permissions.RegistryPermission"
		end

	frozen make_registry_permission (state: PERMISSION_STATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Security.Permissions.RegistryPermission"
		end

feature -- Basic Operations

	intersect (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.RegistryPermission"
		alias
			"Intersect"
		end

	from_xml (esd: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.RegistryPermission"
		alias
			"FromXml"
		end

	frozen add_path_list (access: REGISTRY_PERMISSION_ACCESS; path_list: SYSTEM_STRING) is
		external
			"IL signature (System.Security.Permissions.RegistryPermissionAccess, System.String): System.Void use System.Security.Permissions.RegistryPermission"
		alias
			"AddPathList"
		end

	union (other: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.RegistryPermission"
		alias
			"Union"
		end

	frozen get_path_list (access: REGISTRY_PERMISSION_ACCESS): SYSTEM_STRING is
		external
			"IL signature (System.Security.Permissions.RegistryPermissionAccess): System.String use System.Security.Permissions.RegistryPermission"
		alias
			"GetPathList"
		end

	frozen is_unrestricted: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.RegistryPermission"
		alias
			"IsUnrestricted"
		end

	to_xml: SECURITY_ELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Permissions.RegistryPermission"
		alias
			"ToXml"
		end

	copy_: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.RegistryPermission"
		alias
			"Copy"
		end

	is_subset_of (target: IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.RegistryPermission"
		alias
			"IsSubsetOf"
		end

	frozen set_path_list (access: REGISTRY_PERMISSION_ACCESS; path_list: SYSTEM_STRING) is
		external
			"IL signature (System.Security.Permissions.RegistryPermissionAccess, System.String): System.Void use System.Security.Permissions.RegistryPermission"
		alias
			"SetPathList"
		end

end -- class REGISTRY_PERMISSION
