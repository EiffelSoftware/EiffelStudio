indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Policy.FileCodeGroup"

frozen external class
	SYSTEM_SECURITY_POLICY_FILECODEGROUP

inherit
	SYSTEM_SECURITY_POLICY_CODEGROUP
		redefine
			parse_xml,
			create_xml,
			get_attribute_string,
			get_permission_set_name,
			get_hash_code,
			is_equal
		end

create
	make_filecodegroup

feature {NONE} -- Initialization

	frozen make_filecodegroup (membership_condition: SYSTEM_SECURITY_POLICY_IMEMBERSHIPCONDITION; access: INTEGER) is
			-- Valid values for `access' are a combination of the following values:
			-- NoAccess = 0
			-- Read = 1
			-- Write = 2
			-- Append = 4
			-- PathDiscovery = 8
			-- AllAccess = 15
		require
			valid_file_iopermission_access: (0 + 1 + 2 + 4 + 8 + 15) & access = 0 + 1 + 2 + 4 + 8 + 15
		external
			"IL creator signature (System.Security.Policy.IMembershipCondition, enum System.Security.Permissions.FileIOPermissionAccess) use System.Security.Policy.FileCodeGroup"
		end

feature -- Access

	get_attribute_string: STRING is
		external
			"IL signature (): System.String use System.Security.Policy.FileCodeGroup"
		alias
			"get_AttributeString"
		end

	get_permission_set_name: STRING is
		external
			"IL signature (): System.String use System.Security.Policy.FileCodeGroup"
		alias
			"get_PermissionSetName"
		end

	get_merge_logic: STRING is
		external
			"IL signature (): System.String use System.Security.Policy.FileCodeGroup"
		alias
			"get_MergeLogic"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Policy.FileCodeGroup"
		alias
			"GetHashCode"
		end

	is_equal (o: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Policy.FileCodeGroup"
		alias
			"Equals"
		end

	resolve_matching_code_groups (evidence: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_SECURITY_POLICY_CODEGROUP is
		external
			"IL signature (System.Security.Policy.Evidence): System.Security.Policy.CodeGroup use System.Security.Policy.FileCodeGroup"
		alias
			"ResolveMatchingCodeGroups"
		end

	resolve (evidence: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_SECURITY_POLICY_POLICYSTATEMENT is
		external
			"IL signature (System.Security.Policy.Evidence): System.Security.Policy.PolicyStatement use System.Security.Policy.FileCodeGroup"
		alias
			"Resolve"
		end

	copy: SYSTEM_SECURITY_POLICY_CODEGROUP is
		external
			"IL signature (): System.Security.Policy.CodeGroup use System.Security.Policy.FileCodeGroup"
		alias
			"Copy"
		end

feature {NONE} -- Implementation

	create_xml (element: SYSTEM_SECURITY_SECURITYELEMENT; level: SYSTEM_SECURITY_POLICY_POLICYLEVEL) is
		external
			"IL signature (System.Security.SecurityElement, System.Security.Policy.PolicyLevel): System.Void use System.Security.Policy.FileCodeGroup"
		alias
			"CreateXml"
		end

	parse_xml (e: SYSTEM_SECURITY_SECURITYELEMENT; level: SYSTEM_SECURITY_POLICY_POLICYLEVEL) is
		external
			"IL signature (System.Security.SecurityElement, System.Security.Policy.PolicyLevel): System.Void use System.Security.Policy.FileCodeGroup"
		alias
			"ParseXml"
		end

end -- class SYSTEM_SECURITY_POLICY_FILECODEGROUP
