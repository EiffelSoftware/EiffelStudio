indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.DirectoryServices.DirectoryServicesPermissionEntry"

external class
	SYSTEM_DIRECTORYSERVICES_DIRECTORYSERVICESPERMISSIONENTRY

create
	make

feature {NONE} -- Initialization

	frozen make (permission_access: SYSTEM_DIRECTORYSERVICES_DIRECTORYSERVICESPERMISSIONACCESS; path: STRING) is
		external
			"IL creator signature (System.DirectoryServices.DirectoryServicesPermissionAccess, System.String) use System.DirectoryServices.DirectoryServicesPermissionEntry"
		end

feature -- Access

	frozen get_path: STRING is
		external
			"IL signature (): System.String use System.DirectoryServices.DirectoryServicesPermissionEntry"
		alias
			"get_Path"
		end

	frozen get_permission_access: SYSTEM_DIRECTORYSERVICES_DIRECTORYSERVICESPERMISSIONACCESS is
		external
			"IL signature (): System.DirectoryServices.DirectoryServicesPermissionAccess use System.DirectoryServices.DirectoryServicesPermissionEntry"
		alias
			"get_PermissionAccess"
		end

end -- class SYSTEM_DIRECTORYSERVICES_DIRECTORYSERVICESPERMISSIONENTRY
