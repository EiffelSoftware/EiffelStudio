indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Policy.FirstMatchCodeGroup"

frozen external class
	SYSTEM_SECURITY_POLICY_FIRSTMATCHCODEGROUP

inherit
	SYSTEM_SECURITY_POLICY_CODEGROUP

create
	make_firstmatchcodegroup

feature {NONE} -- Initialization

	frozen make_firstmatchcodegroup (membership_condition: SYSTEM_SECURITY_POLICY_IMEMBERSHIPCONDITION; policy: SYSTEM_SECURITY_POLICY_POLICYSTATEMENT) is
		external
			"IL creator signature (System.Security.Policy.IMembershipCondition, System.Security.Policy.PolicyStatement) use System.Security.Policy.FirstMatchCodeGroup"
		end

feature -- Access

	get_merge_logic: STRING is
		external
			"IL signature (): System.String use System.Security.Policy.FirstMatchCodeGroup"
		alias
			"get_MergeLogic"
		end

feature -- Basic Operations

	resolve_matching_code_groups (evidence: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_SECURITY_POLICY_CODEGROUP is
		external
			"IL signature (System.Security.Policy.Evidence): System.Security.Policy.CodeGroup use System.Security.Policy.FirstMatchCodeGroup"
		alias
			"ResolveMatchingCodeGroups"
		end

	resolve (evidence: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_SECURITY_POLICY_POLICYSTATEMENT is
		external
			"IL signature (System.Security.Policy.Evidence): System.Security.Policy.PolicyStatement use System.Security.Policy.FirstMatchCodeGroup"
		alias
			"Resolve"
		end

	copy: SYSTEM_SECURITY_POLICY_CODEGROUP is
		external
			"IL signature (): System.Security.Policy.CodeGroup use System.Security.Policy.FirstMatchCodeGroup"
		alias
			"Copy"
		end

end -- class SYSTEM_SECURITY_POLICY_FIRSTMATCHCODEGROUP
