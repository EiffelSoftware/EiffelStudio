indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.IsolatedStorageFilePermissionAttribute"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_ISOLATEDSTORAGEFILEPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_ISOLATEDSTORAGEPERMISSIONATTRIBUTE

create
	make_isolatedstoragefilepermissionattribute

feature {NONE} -- Initialization

	frozen make_isolatedstoragefilepermissionattribute (action: SYSTEM_SECURITY_PERMISSIONS_SECURITYACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Security.Permissions.IsolatedStorageFilePermissionAttribute"
		end

feature -- Basic Operations

	create_permission: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.IsolatedStorageFilePermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_ISOLATEDSTORAGEFILEPERMISSIONATTRIBUTE
