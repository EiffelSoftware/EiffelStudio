indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.SecurityPermissionAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SECURITY_PERMISSION_ATTRIBUTE

inherit
	CODE_ACCESS_SECURITY_ATTRIBUTE

create
	make_security_permission_attribute

feature {NONE} -- Initialization

	frozen make_security_permission_attribute (action: SECURITY_ACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Security.Permissions.SecurityPermissionAttribute"
		end

feature -- Access

	frozen get_control_evidence: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"get_ControlEvidence"
		end

	frozen get_remoting_configuration: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"get_RemotingConfiguration"
		end

	frozen get_control_domain_policy: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"get_ControlDomainPolicy"
		end

	frozen get_control_principal: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"get_ControlPrincipal"
		end

	frozen get_infrastructure: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"get_Infrastructure"
		end

	frozen get_control_app_domain: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"get_ControlAppDomain"
		end

	frozen get_skip_verification: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"get_SkipVerification"
		end

	frozen get_flags: SECURITY_PERMISSION_FLAG is
		external
			"IL signature (): System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"get_Flags"
		end

	frozen get_control_policy: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"get_ControlPolicy"
		end

	frozen get_assertion: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"get_Assertion"
		end

	frozen get_serialization_formatter: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"get_SerializationFormatter"
		end

	frozen get_unmanaged_code: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"get_UnmanagedCode"
		end

	frozen get_execution: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"get_Execution"
		end

	frozen get_control_thread: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"get_ControlThread"
		end

feature -- Element Change

	frozen set_control_domain_policy (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"set_ControlDomainPolicy"
		end

	frozen set_control_principal (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"set_ControlPrincipal"
		end

	frozen set_skip_verification (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"set_SkipVerification"
		end

	frozen set_execution (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"set_Execution"
		end

	frozen set_serialization_formatter (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"set_SerializationFormatter"
		end

	frozen set_control_app_domain (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"set_ControlAppDomain"
		end

	frozen set_control_policy (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"set_ControlPolicy"
		end

	frozen set_remoting_configuration (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"set_RemotingConfiguration"
		end

	frozen set_control_evidence (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"set_ControlEvidence"
		end

	frozen set_flags (value: SECURITY_PERMISSION_FLAG) is
		external
			"IL signature (System.Security.Permissions.SecurityPermissionFlag): System.Void use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"set_Flags"
		end

	frozen set_unmanaged_code (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"set_UnmanagedCode"
		end

	frozen set_infrastructure (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"set_Infrastructure"
		end

	frozen set_control_thread (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"set_ControlThread"
		end

	frozen set_assertion (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"set_Assertion"
		end

feature -- Basic Operations

	create_permission: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SECURITY_PERMISSION_ATTRIBUTE
