indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.DirectoryServices.DirectoryServicesPermissionEntry"
	assembly: "System.DirectoryServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ENTRY

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (permission_access: DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ACCESS; path: SYSTEM_STRING) is
		external
			"IL creator signature (System.DirectoryServices.DirectoryServicesPermissionAccess, System.String) use System.DirectoryServices.DirectoryServicesPermissionEntry"
		end

feature -- Access

	frozen get_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.DirectoryServices.DirectoryServicesPermissionEntry"
		alias
			"get_Path"
		end

	frozen get_permission_access: DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ACCESS is
		external
			"IL signature (): System.DirectoryServices.DirectoryServicesPermissionAccess use System.DirectoryServices.DirectoryServicesPermissionEntry"
		alias
			"get_PermissionAccess"
		end

end -- class DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ENTRY
