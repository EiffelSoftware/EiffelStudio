indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.FileIOPermission"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_FILEIOPERMISSION

inherit
	SYSTEM_SECURITY_CODEACCESSPERMISSION
		redefine
			union
		end
	SYSTEM_SECURITY_IPERMISSION
	SYSTEM_SECURITY_ISECURITYENCODABLE
	SYSTEM_SECURITY_ISTACKWALK
	SYSTEM_SECURITY_PERMISSIONS_IUNRESTRICTEDPERMISSION

create
	make_fileiopermission_2,
	make_fileiopermission_1,
	make_fileiopermission

feature {NONE} -- Initialization

	frozen make_fileiopermission_2 (access: SYSTEM_SECURITY_PERMISSIONS_FILEIOPERMISSIONACCESS; path_list: ARRAY [STRING]) is
		external
			"IL creator signature (System.Security.Permissions.FileIOPermissionAccess, System.String[]) use System.Security.Permissions.FileIOPermission"
		end

	frozen make_fileiopermission_1 (access: SYSTEM_SECURITY_PERMISSIONS_FILEIOPERMISSIONACCESS; path: STRING) is
		external
			"IL creator signature (System.Security.Permissions.FileIOPermissionAccess, System.String) use System.Security.Permissions.FileIOPermission"
		end

	frozen make_fileiopermission (state: SYSTEM_SECURITY_PERMISSIONS_PERMISSIONSTATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Security.Permissions.FileIOPermission"
		end

feature -- Access

	frozen get_all_local_files: SYSTEM_SECURITY_PERMISSIONS_FILEIOPERMISSIONACCESS is
		external
			"IL signature (): System.Security.Permissions.FileIOPermissionAccess use System.Security.Permissions.FileIOPermission"
		alias
			"get_AllLocalFiles"
		end

	frozen get_all_files: SYSTEM_SECURITY_PERMISSIONS_FILEIOPERMISSIONACCESS is
		external
			"IL signature (): System.Security.Permissions.FileIOPermissionAccess use System.Security.Permissions.FileIOPermission"
		alias
			"get_AllFiles"
		end

feature -- Element Change

	frozen set_all_local_files (value: SYSTEM_SECURITY_PERMISSIONS_FILEIOPERMISSIONACCESS) is
		external
			"IL signature (System.Security.Permissions.FileIOPermissionAccess): System.Void use System.Security.Permissions.FileIOPermission"
		alias
			"set_AllLocalFiles"
		end

	frozen set_all_files (value: SYSTEM_SECURITY_PERMISSIONS_FILEIOPERMISSIONACCESS) is
		external
			"IL signature (System.Security.Permissions.FileIOPermissionAccess): System.Void use System.Security.Permissions.FileIOPermission"
		alias
			"set_AllFiles"
		end

feature -- Basic Operations

	frozen add_path_list_file_iopermission_access_string (access: SYSTEM_SECURITY_PERMISSIONS_FILEIOPERMISSIONACCESS; path: STRING) is
		external
			"IL signature (System.Security.Permissions.FileIOPermissionAccess, System.String): System.Void use System.Security.Permissions.FileIOPermission"
		alias
			"AddPathList"
		end

	intersect (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.FileIOPermission"
		alias
			"Intersect"
		end

	from_xml (esd: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.FileIOPermission"
		alias
			"FromXml"
		end

	copy: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.FileIOPermission"
		alias
			"Copy"
		end

	frozen add_path_list (access: SYSTEM_SECURITY_PERMISSIONS_FILEIOPERMISSIONACCESS; path_list: ARRAY [STRING]) is
		external
			"IL signature (System.Security.Permissions.FileIOPermissionAccess, System.String[]): System.Void use System.Security.Permissions.FileIOPermission"
		alias
			"AddPathList"
		end

	union (other: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.FileIOPermission"
		alias
			"Union"
		end

	frozen get_path_list (access: SYSTEM_SECURITY_PERMISSIONS_FILEIOPERMISSIONACCESS): ARRAY [STRING] is
		external
			"IL signature (System.Security.Permissions.FileIOPermissionAccess): System.String[] use System.Security.Permissions.FileIOPermission"
		alias
			"GetPathList"
		end

	frozen is_unrestricted: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.FileIOPermission"
		alias
			"IsUnrestricted"
		end

	to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Permissions.FileIOPermission"
		alias
			"ToXml"
		end

	frozen set_path_list (access: SYSTEM_SECURITY_PERMISSIONS_FILEIOPERMISSIONACCESS; path_list: ARRAY [STRING]) is
		external
			"IL signature (System.Security.Permissions.FileIOPermissionAccess, System.String[]): System.Void use System.Security.Permissions.FileIOPermission"
		alias
			"SetPathList"
		end

	is_subset_of (target: SYSTEM_SECURITY_IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.FileIOPermission"
		alias
			"IsSubsetOf"
		end

	frozen set_path_list_file_iopermission_access_string (access: SYSTEM_SECURITY_PERMISSIONS_FILEIOPERMISSIONACCESS; path: STRING) is
		external
			"IL signature (System.Security.Permissions.FileIOPermissionAccess, System.String): System.Void use System.Security.Permissions.FileIOPermission"
		alias
			"SetPathList"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_FILEIOPERMISSION
