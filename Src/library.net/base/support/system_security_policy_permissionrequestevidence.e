indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Policy.PermissionRequestEvidence"

frozen external class
	SYSTEM_SECURITY_POLICY_PERMISSIONREQUESTEVIDENCE

inherit
	ANY
		redefine
			to_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make (request: SYSTEM_SECURITY_PERMISSIONSET; optional: SYSTEM_SECURITY_PERMISSIONSET; denied: SYSTEM_SECURITY_PERMISSIONSET) is
		external
			"IL creator signature (System.Security.PermissionSet, System.Security.PermissionSet, System.Security.PermissionSet) use System.Security.Policy.PermissionRequestEvidence"
		end

feature -- Access

	frozen get_optional_permissions: SYSTEM_SECURITY_PERMISSIONSET is
		external
			"IL signature (): System.Security.PermissionSet use System.Security.Policy.PermissionRequestEvidence"
		alias
			"get_OptionalPermissions"
		end

	frozen get_denied_permissions: SYSTEM_SECURITY_PERMISSIONSET is
		external
			"IL signature (): System.Security.PermissionSet use System.Security.Policy.PermissionRequestEvidence"
		alias
			"get_DeniedPermissions"
		end

	frozen get_requested_permissions: SYSTEM_SECURITY_PERMISSIONSET is
		external
			"IL signature (): System.Security.PermissionSet use System.Security.Policy.PermissionRequestEvidence"
		alias
			"get_RequestedPermissions"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Security.Policy.PermissionRequestEvidence"
		alias
			"ToString"
		end

	frozen copy: SYSTEM_SECURITY_POLICY_PERMISSIONREQUESTEVIDENCE is
		external
			"IL signature (): System.Security.Policy.PermissionRequestEvidence use System.Security.Policy.PermissionRequestEvidence"
		alias
			"Copy"
		end

end -- class SYSTEM_SECURITY_POLICY_PERMISSIONREQUESTEVIDENCE
