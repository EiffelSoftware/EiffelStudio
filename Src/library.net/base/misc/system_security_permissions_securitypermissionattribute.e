indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Permissions.SecurityPermissionAttribute"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_SECURITYPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

create
	make_securitypermissionattribute

feature {NONE} -- Initialization

	frozen make_securitypermissionattribute (action: INTEGER) is
			-- Valid values for `action' are:
			-- Demand = 2
			-- Assert = 3
			-- Deny = 4
			-- PermitOnly = 5
			-- LinkDemand = 6
			-- InheritanceDemand = 7
			-- RequestMinimum = 8
			-- RequestOptional = 9
			-- RequestRefuse = 10
		require
			valid_security_action: action = 2 or action = 3 or action = 4 or action = 5 or action = 6 or action = 7 or action = 8 or action = 9 or action = 10
		external
			"IL creator signature (enum System.Security.Permissions.SecurityAction) use System.Security.Permissions.SecurityPermissionAttribute"
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

	frozen get_flags: INTEGER is
		external
			"IL signature (): enum System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"get_Flags"
		ensure
			valid_security_permission_flag: Result = 0 or Result = 1 or Result = 2 or Result = 4 or Result = 8 or Result = 16 or Result = 32 or Result = 64 or Result = 128 or Result = 256 or Result = 512 or Result = 1024 or Result = 2048 or Result = 4096 or Result = 8191
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

	frozen set_flags (value: INTEGER) is
			-- Valid values for `value' are a combination of the following values:
			-- NoFlags = 0
			-- Assertion = 1
			-- UnmanagedCode = 2
			-- SkipVerification = 4
			-- Execution = 8
			-- ControlThread = 16
			-- ControlEvidence = 32
			-- ControlPolicy = 64
			-- SerializationFormatter = 128
			-- ControlDomainPolicy = 256
			-- ControlPrincipal = 512
			-- ControlAppDomain = 1024
			-- RemotingConfiguration = 2048
			-- Infrastructure = 4096
			-- AllFlags = 8191
		require
			valid_security_permission_flag: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 128 + 256 + 512 + 1024 + 2048 + 4096 + 8191) & value = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 128 + 256 + 512 + 1024 + 2048 + 4096 + 8191
		external
			"IL signature (enum System.Security.Permissions.SecurityPermissionFlag): System.Void use System.Security.Permissions.SecurityPermissionAttribute"
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

	create_permission: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.SecurityPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_SECURITYPERMISSIONATTRIBUTE
