indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Policy.UnionCodeGroup"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	UNION_CODE_GROUP

inherit
	CODE_GROUP

create
	make_union_code_group

feature {NONE} -- Initialization

	frozen make_union_code_group (membership_condition: IMEMBERSHIP_CONDITION; policy: POLICY_STATEMENT) is
		external
			"IL creator signature (System.Security.Policy.IMembershipCondition, System.Security.Policy.PolicyStatement) use System.Security.Policy.UnionCodeGroup"
		end

feature -- Access

	get_merge_logic: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.UnionCodeGroup"
		alias
			"get_MergeLogic"
		end

feature -- Basic Operations

	resolve_matching_code_groups (evidence: EVIDENCE): CODE_GROUP is
		external
			"IL signature (System.Security.Policy.Evidence): System.Security.Policy.CodeGroup use System.Security.Policy.UnionCodeGroup"
		alias
			"ResolveMatchingCodeGroups"
		end

	copy_: CODE_GROUP is
		external
			"IL signature (): System.Security.Policy.CodeGroup use System.Security.Policy.UnionCodeGroup"
		alias
			"Copy"
		end

	resolve (evidence: EVIDENCE): POLICY_STATEMENT is
		external
			"IL signature (System.Security.Policy.Evidence): System.Security.Policy.PolicyStatement use System.Security.Policy.UnionCodeGroup"
		alias
			"Resolve"
		end

end -- class UNION_CODE_GROUP
