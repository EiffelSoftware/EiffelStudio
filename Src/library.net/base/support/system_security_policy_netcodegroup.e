indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Policy.NetCodeGroup"

frozen external class
	SYSTEM_SECURITY_POLICY_NETCODEGROUP

inherit
	SYSTEM_SECURITY_POLICY_CODEGROUP
		redefine
			get_attribute_string,
			get_permission_set_name
		end

create
	make_netcodegroup

feature {NONE} -- Initialization

	frozen make_netcodegroup (membership_condition: SYSTEM_SECURITY_POLICY_IMEMBERSHIPCONDITION) is
		external
			"IL creator signature (System.Security.Policy.IMembershipCondition) use System.Security.Policy.NetCodeGroup"
		end

feature -- Access

	get_attribute_string: STRING is
		external
			"IL signature (): System.String use System.Security.Policy.NetCodeGroup"
		alias
			"get_AttributeString"
		end

	get_permission_set_name: STRING is
		external
			"IL signature (): System.String use System.Security.Policy.NetCodeGroup"
		alias
			"get_PermissionSetName"
		end

	get_merge_logic: STRING is
		external
			"IL signature (): System.String use System.Security.Policy.NetCodeGroup"
		alias
			"get_MergeLogic"
		end

feature -- Basic Operations

	resolve_matching_code_groups (evidence: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_SECURITY_POLICY_CODEGROUP is
		external
			"IL signature (System.Security.Policy.Evidence): System.Security.Policy.CodeGroup use System.Security.Policy.NetCodeGroup"
		alias
			"ResolveMatchingCodeGroups"
		end

	resolve (evidence: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_SECURITY_POLICY_POLICYSTATEMENT is
		external
			"IL signature (System.Security.Policy.Evidence): System.Security.Policy.PolicyStatement use System.Security.Policy.NetCodeGroup"
		alias
			"Resolve"
		end

	copy: SYSTEM_SECURITY_POLICY_CODEGROUP is
		external
			"IL signature (): System.Security.Policy.CodeGroup use System.Security.Policy.NetCodeGroup"
		alias
			"Copy"
		end

end -- class SYSTEM_SECURITY_POLICY_NETCODEGROUP
