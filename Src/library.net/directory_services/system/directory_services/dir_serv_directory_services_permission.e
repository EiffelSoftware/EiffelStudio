indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.DirectoryServices.DirectoryServicesPermission"
	assembly: "System.DirectoryServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DIR_SERV_DIRECTORY_SERVICES_PERMISSION

inherit
	SYSTEM_DLL_RESOURCE_PERMISSION_BASE
	IPERMISSION
	ISECURITY_ENCODABLE
	ISTACK_WALK
	IUNRESTRICTED_PERMISSION

create
	make_dir_serv_directory_services_permission_1,
	make_dir_serv_directory_services_permission_3,
	make_dir_serv_directory_services_permission_2,
	make_dir_serv_directory_services_permission

feature {NONE} -- Initialization

	frozen make_dir_serv_directory_services_permission_1 (state: PERMISSION_STATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.DirectoryServices.DirectoryServicesPermission"
		end

	frozen make_dir_serv_directory_services_permission_3 (permission_access_entries: NATIVE_ARRAY [DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ENTRY]) is
		external
			"IL creator signature (System.DirectoryServices.DirectoryServicesPermissionEntry[]) use System.DirectoryServices.DirectoryServicesPermission"
		end

	frozen make_dir_serv_directory_services_permission_2 (permission_access: DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ACCESS; path: SYSTEM_STRING) is
		external
			"IL creator signature (System.DirectoryServices.DirectoryServicesPermissionAccess, System.String) use System.DirectoryServices.DirectoryServicesPermission"
		end

	frozen make_dir_serv_directory_services_permission is
		external
			"IL creator use System.DirectoryServices.DirectoryServicesPermission"
		end

feature -- Access

	frozen get_permission_entries_directory_services_permission_entry_collection: DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ENTRY_COLLECTION is
		external
			"IL signature (): System.DirectoryServices.DirectoryServicesPermissionEntryCollection use System.DirectoryServices.DirectoryServicesPermission"
		alias
			"get_PermissionEntries"
		end

end -- class DIR_SERV_DIRECTORY_SERVICES_PERMISSION
