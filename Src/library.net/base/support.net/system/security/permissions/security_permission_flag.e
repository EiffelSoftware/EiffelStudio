indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.SecurityPermissionFlag"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	SECURITY_PERMISSION_FLAG

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen control_thread: SECURITY_PERMISSION_FLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"16"
		end

	frozen execution: SECURITY_PERMISSION_FLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"8"
		end

	frozen no_flags: SECURITY_PERMISSION_FLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"0"
		end

	frozen control_domain_policy: SECURITY_PERMISSION_FLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"256"
		end

	frozen control_policy: SECURITY_PERMISSION_FLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"64"
		end

	frozen unmanaged_code: SECURITY_PERMISSION_FLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"2"
		end

	frozen remoting_configuration: SECURITY_PERMISSION_FLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"2048"
		end

	frozen skip_verification: SECURITY_PERMISSION_FLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"4"
		end

	frozen control_evidence: SECURITY_PERMISSION_FLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"32"
		end

	frozen all_flags: SECURITY_PERMISSION_FLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"8191"
		end

	frozen control_app_domain: SECURITY_PERMISSION_FLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"1024"
		end

	frozen assertion: SECURITY_PERMISSION_FLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"1"
		end

	frozen control_principal: SECURITY_PERMISSION_FLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"512"
		end

	frozen infrastructure: SECURITY_PERMISSION_FLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"4096"
		end

	frozen serialization_formatter: SECURITY_PERMISSION_FLAG is
		external
			"IL enum signature :System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionFlag"
		alias
			"128"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SECURITY_PERMISSION_FLAG
