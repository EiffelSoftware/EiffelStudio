indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Policy.FileCodeGroup"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	FILE_CODE_GROUP

inherit
	CODE_GROUP
		rename
			equals as equals_object
		redefine
			parse_xml,
			create_xml,
			get_attribute_string,
			get_permission_set_name,
			get_hash_code,
			equals_object
		end

create
	make_file_code_group

feature {NONE} -- Initialization

	frozen make_file_code_group (membership_condition: IMEMBERSHIP_CONDITION; access: FILE_IOPERMISSION_ACCESS) is
		external
			"IL creator signature (System.Security.Policy.IMembershipCondition, System.Security.Permissions.FileIOPermissionAccess) use System.Security.Policy.FileCodeGroup"
		end

feature -- Access

	get_attribute_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.FileCodeGroup"
		alias
			"get_AttributeString"
		end

	get_permission_set_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.FileCodeGroup"
		alias
			"get_PermissionSetName"
		end

	get_merge_logic: SYSTEM_STRING is
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

	equals_object (o: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Policy.FileCodeGroup"
		alias
			"Equals"
		end

	resolve_matching_code_groups (evidence: EVIDENCE): CODE_GROUP is
		external
			"IL signature (System.Security.Policy.Evidence): System.Security.Policy.CodeGroup use System.Security.Policy.FileCodeGroup"
		alias
			"ResolveMatchingCodeGroups"
		end

	copy_: CODE_GROUP is
		external
			"IL signature (): System.Security.Policy.CodeGroup use System.Security.Policy.FileCodeGroup"
		alias
			"Copy"
		end

	resolve (evidence: EVIDENCE): POLICY_STATEMENT is
		external
			"IL signature (System.Security.Policy.Evidence): System.Security.Policy.PolicyStatement use System.Security.Policy.FileCodeGroup"
		alias
			"Resolve"
		end

feature {NONE} -- Implementation

	create_xml (element: SECURITY_ELEMENT; level: POLICY_LEVEL) is
		external
			"IL signature (System.Security.SecurityElement, System.Security.Policy.PolicyLevel): System.Void use System.Security.Policy.FileCodeGroup"
		alias
			"CreateXml"
		end

	parse_xml (e: SECURITY_ELEMENT; level: POLICY_LEVEL) is
		external
			"IL signature (System.Security.SecurityElement, System.Security.Policy.PolicyLevel): System.Void use System.Security.Policy.FileCodeGroup"
		alias
			"ParseXml"
		end

end -- class FILE_CODE_GROUP
