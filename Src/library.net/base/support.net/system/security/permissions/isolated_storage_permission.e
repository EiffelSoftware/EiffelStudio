indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.IsolatedStoragePermission"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ISOLATED_STORAGE_PERMISSION

inherit
	CODE_ACCESS_PERMISSION
	IPERMISSION
	ISECURITY_ENCODABLE
	ISTACK_WALK
	IUNRESTRICTED_PERMISSION

feature -- Access

	frozen get_user_quota: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Security.Permissions.IsolatedStoragePermission"
		alias
			"get_UserQuota"
		end

	frozen get_usage_allowed: ISOLATED_STORAGE_CONTAINMENT is
		external
			"IL signature (): System.Security.Permissions.IsolatedStorageContainment use System.Security.Permissions.IsolatedStoragePermission"
		alias
			"get_UsageAllowed"
		end

feature -- Element Change

	frozen set_user_quota (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.Security.Permissions.IsolatedStoragePermission"
		alias
			"set_UserQuota"
		end

	frozen set_usage_allowed (value: ISOLATED_STORAGE_CONTAINMENT) is
		external
			"IL signature (System.Security.Permissions.IsolatedStorageContainment): System.Void use System.Security.Permissions.IsolatedStoragePermission"
		alias
			"set_UsageAllowed"
		end

feature -- Basic Operations

	from_xml (esd: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.IsolatedStoragePermission"
		alias
			"FromXml"
		end

	to_xml: SECURITY_ELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Permissions.IsolatedStoragePermission"
		alias
			"ToXml"
		end

	frozen is_unrestricted: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.IsolatedStoragePermission"
		alias
			"IsUnrestricted"
		end

end -- class ISOLATED_STORAGE_PERMISSION
