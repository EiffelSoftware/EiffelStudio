indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.FileIOPermission"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	FILE_IOPERMISSION

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
	make_file_iopermission,
	make_file_iopermission_1,
	make_file_iopermission_2

feature {NONE} -- Initialization

	frozen make_file_iopermission (state: PERMISSION_STATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Security.Permissions.FileIOPermission"
		end

	frozen make_file_iopermission_1 (access: FILE_IOPERMISSION_ACCESS; path: SYSTEM_STRING) is
		external
			"IL creator signature (System.Security.Permissions.FileIOPermissionAccess, System.String) use System.Security.Permissions.FileIOPermission"
		end

	frozen make_file_iopermission_2 (access: FILE_IOPERMISSION_ACCESS; path_list: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL creator signature (System.Security.Permissions.FileIOPermissionAccess, System.String[]) use System.Security.Permissions.FileIOPermission"
		end

feature -- Access

	frozen get_all_local_files: FILE_IOPERMISSION_ACCESS is
		external
			"IL signature (): System.Security.Permissions.FileIOPermissionAccess use System.Security.Permissions.FileIOPermission"
		alias
			"get_AllLocalFiles"
		end

	frozen get_all_files: FILE_IOPERMISSION_ACCESS is
		external
			"IL signature (): System.Security.Permissions.FileIOPermissionAccess use System.Security.Permissions.FileIOPermission"
		alias
			"get_AllFiles"
		end

feature -- Element Change

	frozen set_all_local_files (value: FILE_IOPERMISSION_ACCESS) is
		external
			"IL signature (System.Security.Permissions.FileIOPermissionAccess): System.Void use System.Security.Permissions.FileIOPermission"
		alias
			"set_AllLocalFiles"
		end

	frozen set_all_files (value: FILE_IOPERMISSION_ACCESS) is
		external
			"IL signature (System.Security.Permissions.FileIOPermissionAccess): System.Void use System.Security.Permissions.FileIOPermission"
		alias
			"set_AllFiles"
		end

feature -- Basic Operations

	frozen add_path_list_file_iopermission_access_array_string (access: FILE_IOPERMISSION_ACCESS; path_list: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL signature (System.Security.Permissions.FileIOPermissionAccess, System.String[]): System.Void use System.Security.Permissions.FileIOPermission"
		alias
			"AddPathList"
		end

	intersect (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.FileIOPermission"
		alias
			"Intersect"
		end

	from_xml (esd: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.FileIOPermission"
		alias
			"FromXml"
		end

	frozen add_path_list (access: FILE_IOPERMISSION_ACCESS; path: SYSTEM_STRING) is
		external
			"IL signature (System.Security.Permissions.FileIOPermissionAccess, System.String): System.Void use System.Security.Permissions.FileIOPermission"
		alias
			"AddPathList"
		end

	union (other: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.FileIOPermission"
		alias
			"Union"
		end

	frozen get_path_list (access: FILE_IOPERMISSION_ACCESS): NATIVE_ARRAY [SYSTEM_STRING] is
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

	to_xml: SECURITY_ELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Permissions.FileIOPermission"
		alias
			"ToXml"
		end

	frozen set_path_list_file_iopermission_access_array_string (access: FILE_IOPERMISSION_ACCESS; path_list: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL signature (System.Security.Permissions.FileIOPermissionAccess, System.String[]): System.Void use System.Security.Permissions.FileIOPermission"
		alias
			"SetPathList"
		end

	copy_: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.FileIOPermission"
		alias
			"Copy"
		end

	is_subset_of (target: IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.FileIOPermission"
		alias
			"IsSubsetOf"
		end

	frozen set_path_list (access: FILE_IOPERMISSION_ACCESS; path: SYSTEM_STRING) is
		external
			"IL signature (System.Security.Permissions.FileIOPermissionAccess, System.String): System.Void use System.Security.Permissions.FileIOPermission"
		alias
			"SetPathList"
		end

end -- class FILE_IOPERMISSION
