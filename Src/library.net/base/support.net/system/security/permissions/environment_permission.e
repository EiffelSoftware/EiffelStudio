indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.EnvironmentPermission"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ENVIRONMENT_PERMISSION

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
	make_environment_permission,
	make_environment_permission_1

feature {NONE} -- Initialization

	frozen make_environment_permission (state: PERMISSION_STATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Security.Permissions.EnvironmentPermission"
		end

	frozen make_environment_permission_1 (flag: ENVIRONMENT_PERMISSION_ACCESS; path_list: SYSTEM_STRING) is
		external
			"IL creator signature (System.Security.Permissions.EnvironmentPermissionAccess, System.String) use System.Security.Permissions.EnvironmentPermission"
		end

feature -- Basic Operations

	intersect (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.EnvironmentPermission"
		alias
			"Intersect"
		end

	from_xml (esd: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.EnvironmentPermission"
		alias
			"FromXml"
		end

	frozen add_path_list (flag: ENVIRONMENT_PERMISSION_ACCESS; path_list: SYSTEM_STRING) is
		external
			"IL signature (System.Security.Permissions.EnvironmentPermissionAccess, System.String): System.Void use System.Security.Permissions.EnvironmentPermission"
		alias
			"AddPathList"
		end

	union (other: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.EnvironmentPermission"
		alias
			"Union"
		end

	frozen get_path_list (flag: ENVIRONMENT_PERMISSION_ACCESS): SYSTEM_STRING is
		external
			"IL signature (System.Security.Permissions.EnvironmentPermissionAccess): System.String use System.Security.Permissions.EnvironmentPermission"
		alias
			"GetPathList"
		end

	frozen is_unrestricted: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.EnvironmentPermission"
		alias
			"IsUnrestricted"
		end

	to_xml: SECURITY_ELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Permissions.EnvironmentPermission"
		alias
			"ToXml"
		end

	copy_: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.EnvironmentPermission"
		alias
			"Copy"
		end

	is_subset_of (target: IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.EnvironmentPermission"
		alias
			"IsSubsetOf"
		end

	frozen set_path_list (flag: ENVIRONMENT_PERMISSION_ACCESS; path_list: SYSTEM_STRING) is
		external
			"IL signature (System.Security.Permissions.EnvironmentPermissionAccess, System.String): System.Void use System.Security.Permissions.EnvironmentPermission"
		alias
			"SetPathList"
		end

end -- class ENVIRONMENT_PERMISSION
