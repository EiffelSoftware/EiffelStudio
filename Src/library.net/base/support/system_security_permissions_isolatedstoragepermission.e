indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.IsolatedStoragePermission"

deferred external class
	SYSTEM_SECURITY_PERMISSIONS_ISOLATEDSTORAGEPERMISSION

inherit
	SYSTEM_SECURITY_CODEACCESSPERMISSION
	SYSTEM_SECURITY_IPERMISSION
	SYSTEM_SECURITY_ISECURITYENCODABLE
	SYSTEM_SECURITY_ISTACKWALK
	SYSTEM_SECURITY_PERMISSIONS_IUNRESTRICTEDPERMISSION

feature -- Access

	frozen get_user_quota: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Security.Permissions.IsolatedStoragePermission"
		alias
			"get_UserQuota"
		end

	frozen get_usage_allowed: SYSTEM_SECURITY_PERMISSIONS_ISOLATEDSTORAGECONTAINMENT is
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

	frozen set_usage_allowed (value: SYSTEM_SECURITY_PERMISSIONS_ISOLATEDSTORAGECONTAINMENT) is
		external
			"IL signature (System.Security.Permissions.IsolatedStorageContainment): System.Void use System.Security.Permissions.IsolatedStoragePermission"
		alias
			"set_UsageAllowed"
		end

feature -- Basic Operations

	from_xml (esd: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.IsolatedStoragePermission"
		alias
			"FromXml"
		end

	to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
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

end -- class SYSTEM_SECURITY_PERMISSIONS_ISOLATEDSTORAGEPERMISSION
