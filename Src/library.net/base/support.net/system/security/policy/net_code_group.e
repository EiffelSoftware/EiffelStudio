indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Policy.NetCodeGroup"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	NET_CODE_GROUP

inherit
	CODE_GROUP
		redefine
			get_attribute_string,
			get_permission_set_name
		end

create
	make_net_code_group

feature {NONE} -- Initialization

	frozen make_net_code_group (membership_condition: IMEMBERSHIP_CONDITION) is
		external
			"IL creator signature (System.Security.Policy.IMembershipCondition) use System.Security.Policy.NetCodeGroup"
		end

feature -- Access

	get_attribute_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.NetCodeGroup"
		alias
			"get_AttributeString"
		end

	get_permission_set_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.NetCodeGroup"
		alias
			"get_PermissionSetName"
		end

	get_merge_logic: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.NetCodeGroup"
		alias
			"get_MergeLogic"
		end

feature -- Basic Operations

	resolve_matching_code_groups (evidence: EVIDENCE): CODE_GROUP is
		external
			"IL signature (System.Security.Policy.Evidence): System.Security.Policy.CodeGroup use System.Security.Policy.NetCodeGroup"
		alias
			"ResolveMatchingCodeGroups"
		end

	copy_: CODE_GROUP is
		external
			"IL signature (): System.Security.Policy.CodeGroup use System.Security.Policy.NetCodeGroup"
		alias
			"Copy"
		end

	resolve (evidence: EVIDENCE): POLICY_STATEMENT is
		external
			"IL signature (System.Security.Policy.Evidence): System.Security.Policy.PolicyStatement use System.Security.Policy.NetCodeGroup"
		alias
			"Resolve"
		end

end -- class NET_CODE_GROUP
