indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.DirectoryServices.DirectoryServicesPermissionAttribute"
	assembly: "System.DirectoryServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ATTRIBUTE

inherit
	CODE_ACCESS_SECURITY_ATTRIBUTE

create
	make_dir_serv_directory_services_permission_attribute

feature {NONE} -- Initialization

	frozen make_dir_serv_directory_services_permission_attribute (action: SECURITY_ACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.DirectoryServices.DirectoryServicesPermissionAttribute"
		end

feature -- Access

	frozen get_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.DirectoryServices.DirectoryServicesPermissionAttribute"
		alias
			"get_Path"
		end

	frozen get_permission_access: DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ACCESS is
		external
			"IL signature (): System.DirectoryServices.DirectoryServicesPermissionAccess use System.DirectoryServices.DirectoryServicesPermissionAttribute"
		alias
			"get_PermissionAccess"
		end

feature -- Element Change

	frozen set_permission_access (value: DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ACCESS) is
		external
			"IL signature (System.DirectoryServices.DirectoryServicesPermissionAccess): System.Void use System.DirectoryServices.DirectoryServicesPermissionAttribute"
		alias
			"set_PermissionAccess"
		end

	frozen set_path (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.DirectoryServices.DirectoryServicesPermissionAttribute"
		alias
			"set_Path"
		end

feature -- Basic Operations

	create_permission: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.DirectoryServices.DirectoryServicesPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ATTRIBUTE
