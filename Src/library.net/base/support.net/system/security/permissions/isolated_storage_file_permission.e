indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.IsolatedStorageFilePermission"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ISOLATED_STORAGE_FILE_PERMISSION

inherit
	ISOLATED_STORAGE_PERMISSION
		redefine
			union
		end
	IPERMISSION
	ISECURITY_ENCODABLE
	ISTACK_WALK
	IUNRESTRICTED_PERMISSION

create
	make_isolated_storage_file_permission

feature {NONE} -- Initialization

	frozen make_isolated_storage_file_permission (state: PERMISSION_STATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Security.Permissions.IsolatedStorageFilePermission"
		end

feature -- Basic Operations

	union (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.IsolatedStorageFilePermission"
		alias
			"Union"
		end

	intersect (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.IsolatedStorageFilePermission"
		alias
			"Intersect"
		end

	is_subset_of (target: IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.IsolatedStorageFilePermission"
		alias
			"IsSubsetOf"
		end

	copy_: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.IsolatedStorageFilePermission"
		alias
			"Copy"
		end

end -- class ISOLATED_STORAGE_FILE_PERMISSION
