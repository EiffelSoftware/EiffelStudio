indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.IsolatedStoragePermissionAttribute"

deferred external class
	SYSTEM_SECURITY_PERMISSIONS_ISOLATEDSTORAGEPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

feature -- Access

	frozen get_user_quota: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Security.Permissions.IsolatedStoragePermissionAttribute"
		alias
			"get_UserQuota"
		end

	frozen get_usage_allowed: SYSTEM_SECURITY_PERMISSIONS_ISOLATEDSTORAGECONTAINMENT is
		external
			"IL signature (): System.Security.Permissions.IsolatedStorageContainment use System.Security.Permissions.IsolatedStoragePermissionAttribute"
		alias
			"get_UsageAllowed"
		end

feature -- Element Change

	frozen set_user_quota (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.Security.Permissions.IsolatedStoragePermissionAttribute"
		alias
			"set_UserQuota"
		end

	frozen set_usage_allowed (value: SYSTEM_SECURITY_PERMISSIONS_ISOLATEDSTORAGECONTAINMENT) is
		external
			"IL signature (System.Security.Permissions.IsolatedStorageContainment): System.Void use System.Security.Permissions.IsolatedStoragePermissionAttribute"
		alias
			"set_UsageAllowed"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_ISOLATEDSTORAGEPERMISSIONATTRIBUTE
