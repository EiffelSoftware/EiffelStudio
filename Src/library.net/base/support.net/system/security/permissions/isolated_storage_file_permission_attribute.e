indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.IsolatedStorageFilePermissionAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ISOLATED_STORAGE_FILE_PERMISSION_ATTRIBUTE

inherit
	ISOLATED_STORAGE_PERMISSION_ATTRIBUTE

create
	make_isolated_storage_file_permission_attribute

feature {NONE} -- Initialization

	frozen make_isolated_storage_file_permission_attribute (action: SECURITY_ACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Security.Permissions.IsolatedStorageFilePermissionAttribute"
		end

feature -- Basic Operations

	create_permission: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.IsolatedStorageFilePermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class ISOLATED_STORAGE_FILE_PERMISSION_ATTRIBUTE
