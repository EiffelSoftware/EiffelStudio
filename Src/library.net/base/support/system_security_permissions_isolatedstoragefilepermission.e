indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.IsolatedStorageFilePermission"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_ISOLATEDSTORAGEFILEPERMISSION

inherit
	SYSTEM_SECURITY_PERMISSIONS_ISOLATEDSTORAGEPERMISSION
		redefine
			union
		end
	SYSTEM_SECURITY_IPERMISSION
	SYSTEM_SECURITY_ISECURITYENCODABLE
	SYSTEM_SECURITY_ISTACKWALK
	SYSTEM_SECURITY_PERMISSIONS_IUNRESTRICTEDPERMISSION

create
	make_isolatedstoragefilepermission

feature {NONE} -- Initialization

	frozen make_isolatedstoragefilepermission (state: SYSTEM_SECURITY_PERMISSIONS_PERMISSIONSTATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Security.Permissions.IsolatedStorageFilePermission"
		end

feature -- Basic Operations

	union (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.IsolatedStorageFilePermission"
		alias
			"Union"
		end

	intersect (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.IsolatedStorageFilePermission"
		alias
			"Intersect"
		end

	is_subset_of (target: SYSTEM_SECURITY_IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.IsolatedStorageFilePermission"
		alias
			"IsSubsetOf"
		end

	copy: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.IsolatedStorageFilePermission"
		alias
			"Copy"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_ISOLATEDSTORAGEFILEPERMISSION
