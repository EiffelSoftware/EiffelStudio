indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Policy.FirstMatchCodeGroup"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	FIRST_MATCH_CODE_GROUP

inherit
	CODE_GROUP

create
	make_first_match_code_group

feature {NONE} -- Initialization

	frozen make_first_match_code_group (membership_condition: IMEMBERSHIP_CONDITION; policy: POLICY_STATEMENT) is
		external
			"IL creator signature (System.Security.Policy.IMembershipCondition, System.Security.Policy.PolicyStatement) use System.Security.Policy.FirstMatchCodeGroup"
		end

feature -- Access

	get_merge_logic: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.FirstMatchCodeGroup"
		alias
			"get_MergeLogic"
		end

feature -- Basic Operations

	resolve_matching_code_groups (evidence: EVIDENCE): CODE_GROUP is
		external
			"IL signature (System.Security.Policy.Evidence): System.Security.Policy.CodeGroup use System.Security.Policy.FirstMatchCodeGroup"
		alias
			"ResolveMatchingCodeGroups"
		end

	copy_: CODE_GROUP is
		external
			"IL signature (): System.Security.Policy.CodeGroup use System.Security.Policy.FirstMatchCodeGroup"
		alias
			"Copy"
		end

	resolve (evidence: EVIDENCE): POLICY_STATEMENT is
		external
			"IL signature (System.Security.Policy.Evidence): System.Security.Policy.PolicyStatement use System.Security.Policy.FirstMatchCodeGroup"
		alias
			"Resolve"
		end

end -- class FIRST_MATCH_CODE_GROUP
