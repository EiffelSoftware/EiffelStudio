indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.SecurityPermissionFlag"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_SECURITY_PERMISSIONS_SECURITYPERMISSIONFLAG

inherit
	ENUM
	SYSTEM_ICOMPARABLE
	SYSTEM_IFORMATTABLE

feature -- Access

	frozen control_thread: SYSTEM_SECURITY_PERMISSIONS_SECURITYPERMISSIONFLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"16"
		end

	frozen execution: SYSTEM_SECURITY_PERMISSIONS_SECURITYPERMISSIONFLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"8"
		end

	frozen no_flags: SYSTEM_SECURITY_PERMISSIONS_SECURITYPERMISSIONFLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"0"
		end

	frozen control_domain_policy: SYSTEM_SECURITY_PERMISSIONS_SECURITYPERMISSIONFLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"256"
		end

	frozen control_policy: SYSTEM_SECURITY_PERMISSIONS_SECURITYPERMISSIONFLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"64"
		end

	frozen unmanaged_code: SYSTEM_SECURITY_PERMISSIONS_SECURITYPERMISSIONFLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"2"
		end

	frozen remoting_configuration: SYSTEM_SECURITY_PERMISSIONS_SECURITYPERMISSIONFLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"2048"
		end

	frozen skip_verification: SYSTEM_SECURITY_PERMISSIONS_SECURITYPERMISSIONFLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"4"
		end

	frozen control_evidence: SYSTEM_SECURITY_PERMISSIONS_SECURITYPERMISSIONFLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"32"
		end

	frozen all_flags: SYSTEM_SECURITY_PERMISSIONS_SECURITYPERMISSIONFLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"8191"
		end

	frozen control_app_domain: SYSTEM_SECURITY_PERMISSIONS_SECURITYPERMISSIONFLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"1024"
		end

	frozen assertion: SYSTEM_SECURITY_PERMISSIONS_SECURITYPERMISSIONFLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"1"
		end

	frozen control_principal: SYSTEM_SECURITY_PERMISSIONS_SECURITYPERMISSIONFLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"512"
		end

	frozen infrastructure: SYSTEM_SECURITY_PERMISSIONS_SECURITYPERMISSIONFLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"4096"
		end

	frozen serialization_formatter: SYSTEM_SECURITY_PERMISSIONS_SECURITYPERMISSIONFLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"128"
		end

feature -- Basic Operations

	infix "|" (o: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_SECURITYPERMISSIONFLAG
