indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.DirectoryServices.DirectoryServicesPermission"

external class
	SYSTEM_DIRECTORYSERVICES_DIRECTORYSERVICESPERMISSION

inherit
	SYSTEM_SECURITY_IPERMISSION
	SYSTEM_SECURITY_PERMISSIONS_IUNRESTRICTEDPERMISSION
	SYSTEM_SECURITY_ISECURITYENCODABLE
	SYSTEM_SECURITY_PERMISSIONS_RESOURCEPERMISSIONBASE
	SYSTEM_SECURITY_ISTACKWALK

create
	make_directoryservicespermission_3,
	make_directoryservicespermission,
	make_directoryservicespermission_1,
	make_directoryservicespermission_2

feature {NONE} -- Initialization

	frozen make_directoryservicespermission_3 (permission_access_entries: ARRAY [SYSTEM_DIRECTORYSERVICES_DIRECTORYSERVICESPERMISSIONENTRY]) is
		external
			"IL creator signature (System.DirectoryServices.DirectoryServicesPermissionEntry[]) use System.DirectoryServices.DirectoryServicesPermission"
		end

	frozen make_directoryservicespermission is
		external
			"IL creator use System.DirectoryServices.DirectoryServicesPermission"
		end

	frozen make_directoryservicespermission_1 (state: SYSTEM_SECURITY_PERMISSIONS_PERMISSIONSTATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.DirectoryServices.DirectoryServicesPermission"
		end

	frozen make_directoryservicespermission_2 (permission_access: SYSTEM_DIRECTORYSERVICES_DIRECTORYSERVICESPERMISSIONACCESS; path: STRING) is
		external
			"IL creator signature (System.DirectoryServices.DirectoryServicesPermissionAccess, System.String) use System.DirectoryServices.DirectoryServicesPermission"
		end

feature -- Access

	frozen get_permission_entries_directory_services_permission_entry_collection: SYSTEM_DIRECTORYSERVICES_DIRECTORYSERVICESPERMISSIONENTRYCOLLECTION is
		external
			"IL signature (): System.DirectoryServices.DirectoryServicesPermissionEntryCollection use System.DirectoryServices.DirectoryServicesPermission"
		alias
			"get_PermissionEntries"
		end

end -- class SYSTEM_DIRECTORYSERVICES_DIRECTORYSERVICESPERMISSION
