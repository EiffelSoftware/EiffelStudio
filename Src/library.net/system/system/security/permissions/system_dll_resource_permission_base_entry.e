indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.ResourcePermissionBaseEntry"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_RESOURCE_PERMISSION_BASE_ENTRY

inherit
	SYSTEM_OBJECT

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Security.Permissions.ResourcePermissionBaseEntry"
		end

	frozen make_1 (permission_access: INTEGER; permission_access_path: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL creator signature (System.Int32, System.String[]) use System.Security.Permissions.ResourcePermissionBaseEntry"
		end

feature -- Access

	frozen get_permission_access_path: NATIVE_ARRAY [SYSTEM_STRING] is
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

end -- class SYSTEM_DLL_RESOURCE_PERMISSION_BASE_ENTRY
