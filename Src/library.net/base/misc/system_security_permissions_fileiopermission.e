indexing
	Generator: "Eiffel Emitter 2.5b2"
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

	frozen make_fileiopermission_2 (access: INTEGER; path_list: ARRAY [STRING]) is
			-- Valid values for `access' are a combination of the following values:
			-- NoAccess = 0
			-- Read = 1
			-- Write = 2
			-- Append = 4
			-- PathDiscovery = 8
			-- AllAccess = 15
		require
			valid_file_iopermission_access: (0 + 1 + 2 + 4 + 8 + 15) & access = 0 + 1 + 2 + 4 + 8 + 15
		external
			"IL creator signature (enum System.Security.Permissions.FileIOPermissionAccess, System.String[]) use System.Security.Permissions.FileIOPermission"
		end

	frozen make_fileiopermission_1 (access: INTEGER; path: STRING) is
			-- Valid values for `access' are a combination of the following values:
			-- NoAccess = 0
			-- Read = 1
			-- Write = 2
			-- Append = 4
			-- PathDiscovery = 8
			-- AllAccess = 15
		require
			valid_file_iopermission_access: (0 + 1 + 2 + 4 + 8 + 15) & access = 0 + 1 + 2 + 4 + 8 + 15
		external
			"IL creator signature (enum System.Security.Permissions.FileIOPermissionAccess, System.String) use System.Security.Permissions.FileIOPermission"
		end

	frozen make_fileiopermission (state: INTEGER) is
			-- Valid values for `state' are:
			-- Unrestricted = 1
			-- None = 0
		require
			valid_permission_state: state = 1 or state = 0
		external
			"IL creator signature (enum System.Security.Permissions.PermissionState) use System.Security.Permissions.FileIOPermission"
		end

feature -- Access

	frozen get_all_local_files: INTEGER is
		external
			"IL signature (): enum System.Security.Permissions.FileIOPermissionAccess use System.Security.Permissions.FileIOPermission"
		alias
			"get_AllLocalFiles"
		ensure
			valid_file_iopermission_access: Result = 0 or Result = 1 or Result = 2 or Result = 4 or Result = 8 or Result = 15
		end

	frozen get_all_files: INTEGER is
		external
			"IL signature (): enum System.Security.Permissions.FileIOPermissionAccess use System.Security.Permissions.FileIOPermission"
		alias
			"get_AllFiles"
		ensure
			valid_file_iopermission_access: Result = 0 or Result = 1 or Result = 2 or Result = 4 or Result = 8 or Result = 15
		end

feature -- Element Change

	frozen set_all_local_files (value: INTEGER) is
			-- Valid values for `value' are a combination of the following values:
			-- NoAccess = 0
			-- Read = 1
			-- Write = 2
			-- Append = 4
			-- PathDiscovery = 8
			-- AllAccess = 15
		require
			valid_file_iopermission_access: (0 + 1 + 2 + 4 + 8 + 15) & value = 0 + 1 + 2 + 4 + 8 + 15
		external
			"IL signature (enum System.Security.Permissions.FileIOPermissionAccess): System.Void use System.Security.Permissions.FileIOPermission"
		alias
			"set_AllLocalFiles"
		end

	frozen set_all_files (value: INTEGER) is
			-- Valid values for `value' are a combination of the following values:
			-- NoAccess = 0
			-- Read = 1
			-- Write = 2
			-- Append = 4
			-- PathDiscovery = 8
			-- AllAccess = 15
		require
			valid_file_iopermission_access: (0 + 1 + 2 + 4 + 8 + 15) & value = 0 + 1 + 2 + 4 + 8 + 15
		external
			"IL signature (enum System.Security.Permissions.FileIOPermissionAccess): System.Void use System.Security.Permissions.FileIOPermission"
		alias
			"set_AllFiles"
		end

feature -- Basic Operations

	frozen add_path_list_file_iopermission_access_string (access: INTEGER; path: STRING) is
			-- Valid values for `access' are a combination of the following values:
			-- NoAccess = 0
			-- Read = 1
			-- Write = 2
			-- Append = 4
			-- PathDiscovery = 8
			-- AllAccess = 15
		require
			valid_file_iopermission_access: (0 + 1 + 2 + 4 + 8 + 15) & access = 0 + 1 + 2 + 4 + 8 + 15
		external
			"IL signature (enum System.Security.Permissions.FileIOPermissionAccess, System.String): System.Void use System.Security.Permissions.FileIOPermission"
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

	frozen add_path_list (access: INTEGER; path_list: ARRAY [STRING]) is
			-- Valid values for `access' are a combination of the following values:
			-- NoAccess = 0
			-- Read = 1
			-- Write = 2
			-- Append = 4
			-- PathDiscovery = 8
			-- AllAccess = 15
		require
			valid_file_iopermission_access: (0 + 1 + 2 + 4 + 8 + 15) & access = 0 + 1 + 2 + 4 + 8 + 15
		external
			"IL signature (enum System.Security.Permissions.FileIOPermissionAccess, System.String[]): System.Void use System.Security.Permissions.FileIOPermission"
		alias
			"AddPathList"
		end

	union (other: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.FileIOPermission"
		alias
			"Union"
		end

	frozen get_path_list (access: INTEGER): STRING is
			-- Valid values for `access' are a combination of the following values:
			-- NoAccess = 0
			-- Read = 1
			-- Write = 2
			-- Append = 4
			-- PathDiscovery = 8
			-- AllAccess = 15
		require
			valid_file_iopermission_access: (0 + 1 + 2 + 4 + 8 + 15) & access = 0 + 1 + 2 + 4 + 8 + 15
		external
			"IL signature (enum System.Security.Permissions.FileIOPermissionAccess): System.String use System.Security.Permissions.FileIOPermission"
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

	frozen set_path_list (access: INTEGER; path_list: ARRAY [STRING]) is
			-- Valid values for `access' are a combination of the following values:
			-- NoAccess = 0
			-- Read = 1
			-- Write = 2
			-- Append = 4
			-- PathDiscovery = 8
			-- AllAccess = 15
		require
			valid_file_iopermission_access: (0 + 1 + 2 + 4 + 8 + 15) & access = 0 + 1 + 2 + 4 + 8 + 15
		external
			"IL signature (enum System.Security.Permissions.FileIOPermissionAccess, System.String[]): System.Void use System.Security.Permissions.FileIOPermission"
		alias
			"SetPathList"
		end

	is_subset_of (target: SYSTEM_SECURITY_IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.FileIOPermission"
		alias
			"IsSubsetOf"
		end

	frozen get_path_list_array (access: INTEGER): ARRAY [STRING] is
			-- Valid values for `access' are a combination of the following values:
			-- NoAccess = 0
			-- Read = 1
			-- Write = 2
			-- Append = 4
			-- PathDiscovery = 8
			-- AllAccess = 15
		require
			valid_file_iopermission_access: (0 + 1 + 2 + 4 + 8 + 15) & access = 0 + 1 + 2 + 4 + 8 + 15
		external
			"IL signature (enum System.Security.Permissions.FileIOPermissionAccess): System.String[] use System.Security.Permissions.FileIOPermission"
		alias
			"GetPathListArray"
		end

	frozen set_path_list_file_iopermission_access_string (access: INTEGER; path: STRING) is
			-- Valid values for `access' are a combination of the following values:
			-- NoAccess = 0
			-- Read = 1
			-- Write = 2
			-- Append = 4
			-- PathDiscovery = 8
			-- AllAccess = 15
		require
			valid_file_iopermission_access: (0 + 1 + 2 + 4 + 8 + 15) & access = 0 + 1 + 2 + 4 + 8 + 15
		external
			"IL signature (enum System.Security.Permissions.FileIOPermissionAccess, System.String): System.Void use System.Security.Permissions.FileIOPermission"
		alias
			"SetPathList"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_FILEIOPERMISSION
