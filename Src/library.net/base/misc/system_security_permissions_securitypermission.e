indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Permissions.SecurityPermission"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_SECURITYPERMISSION

inherit
	SYSTEM_SECURITY_CODEACCESSPERMISSION
		redefine
			union
		end
	SYSTEM_SECURITY_IPERMISSION
	SYSTEM_SECURITY_ISECURITYENCODABLE
	SYSTEM_SECURITY_ISTACKWALK
	SYSTEM_SECURITY_PERMISSIONS_IUNRESTRICTEDPERMISSION

create
	make_securitypermission,
	make_securitypermission_1

feature {NONE} -- Initialization

	frozen make_securitypermission (state: INTEGER) is
			-- Valid values for `state' are:
			-- Unrestricted = 1
			-- None = 0
		require
			valid_permission_state: state = 1 or state = 0
		external
			"IL creator signature (enum System.Security.Permissions.PermissionState) use System.Security.Permissions.SecurityPermission"
		end

	frozen make_securitypermission_1 (flag: INTEGER) is
			-- Valid values for `flag' are a combination of the following values:
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
			valid_security_permission_flag: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 128 + 256 + 512 + 1024 + 2048 + 4096 + 8191) & flag = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 128 + 256 + 512 + 1024 + 2048 + 4096 + 8191
		external
			"IL creator signature (enum System.Security.Permissions.SecurityPermissionFlag) use System.Security.Permissions.SecurityPermission"
		end

feature -- Access

	frozen get_flags: INTEGER is
		external
			"IL signature (): enum System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermission"
		alias
			"get_Flags"
		ensure
			valid_security_permission_flag: Result = 0 or Result = 1 or Result = 2 or Result = 4 or Result = 8 or Result = 16 or Result = 32 or Result = 64 or Result = 128 or Result = 256 or Result = 512 or Result = 1024 or Result = 2048 or Result = 4096 or Result = 8191
		end

feature -- Element Change

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
			"IL signature (enum System.Security.Permissions.SecurityPermissionFlag): System.Void use System.Security.Permissions.SecurityPermission"
		alias
			"set_Flags"
		end

feature -- Basic Operations

	intersect (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.SecurityPermission"
		alias
			"Intersect"
		end

	from_xml (esd: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.SecurityPermission"
		alias
			"FromXml"
		end

	to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Permissions.SecurityPermission"
		alias
			"ToXml"
		end

	frozen is_unrestricted: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.SecurityPermission"
		alias
			"IsUnrestricted"
		end

	is_subset_of (target: SYSTEM_SECURITY_IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.SecurityPermission"
		alias
			"IsSubsetOf"
		end

	union (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.SecurityPermission"
		alias
			"Union"
		end

	copy: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.SecurityPermission"
		alias
			"Copy"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_SECURITYPERMISSION
