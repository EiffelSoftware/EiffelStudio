indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.ResourcePermissionBaseEntry"

external class
	SYSTEM_SECURITY_PERMISSIONS_RESOURCEPERMISSIONBASEENTRY

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Security.Permissions.ResourcePermissionBaseEntry"
		end

	frozen make_1 (permission_access: INTEGER; permission_access_path: ARRAY [STRING]) is
		external
			"IL creator signature (System.Int32, System.String[]) use System.Security.Permissions.ResourcePermissionBaseEntry"
		end

feature -- Access

	frozen get_permission_access_path: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Security.Permissions.ResourcePermissionBaseEntry"
		alias
			"get_PermissionAccessPath"
		end

	frozen get_permission_access: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Permissions.ResourcePermissionBaseEntry"
		alias
			"get_PermissionAccess"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_RESOURCEPERMISSIONBASEENTRY
