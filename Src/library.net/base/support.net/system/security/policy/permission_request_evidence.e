indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Policy.PermissionRequestEvidence"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	PERMISSION_REQUEST_EVIDENCE

inherit
	SYSTEM_OBJECT
		redefine
			to_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make (request: PERMISSION_SET; optional: PERMISSION_SET; denied: PERMISSION_SET) is
		external
			"IL creator signature (System.Security.PermissionSet, System.Security.PermissionSet, System.Security.PermissionSet) use System.Security.Policy.PermissionRequestEvidence"
		end

feature -- Access

	frozen get_optional_permissions: PERMISSION_SET is
		external
			"IL signature (): System.Security.PermissionSet use System.Security.Policy.PermissionRequestEvidence"
		alias
			"get_OptionalPermissions"
		end

	frozen get_denied_permissions: PERMISSION_SET is
		external
			"IL signature (): System.Security.PermissionSet use System.Security.Policy.PermissionRequestEvidence"
		alias
			"get_DeniedPermissions"
		end

	frozen get_requested_permissions: PERMISSION_SET is
		external
			"IL signature (): System.Security.PermissionSet use System.Security.Policy.PermissionRequestEvidence"
		alias
			"get_RequestedPermissions"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.PermissionRequestEvidence"
		alias
			"ToString"
		end

	frozen copy_: PERMISSION_REQUEST_EVIDENCE is
		external
			"IL signature (): System.Security.Policy.PermissionRequestEvidence use System.Security.Policy.PermissionRequestEvidence"
		alias
			"Copy"
		end

end -- class PERMISSION_REQUEST_EVIDENCE
