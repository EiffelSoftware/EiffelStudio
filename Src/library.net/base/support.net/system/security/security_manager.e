indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.SecurityManager"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SECURITY_MANAGER

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_security_enabled: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Security.SecurityManager"
		alias
			"get_SecurityEnabled"
		end

	frozen get_check_execution_rights: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Security.SecurityManager"
		alias
			"get_CheckExecutionRights"
		end

feature -- Element Change

	frozen set_check_execution_rights (value: BOOLEAN) is
		external
			"IL static signature (System.Boolean): System.Void use System.Security.SecurityManager"
		alias
			"set_CheckExecutionRights"
		end

	frozen set_security_enabled (value: BOOLEAN) is
		external
			"IL static signature (System.Boolean): System.Void use System.Security.SecurityManager"
		alias
			"set_SecurityEnabled"
		end

feature -- Basic Operations

	frozen load_policy_level_from_file (path: SYSTEM_STRING; type: POLICY_LEVEL_TYPE): POLICY_LEVEL is
		external
			"IL static signature (System.String, System.Security.PolicyLevelType): System.Security.Policy.PolicyLevel use System.Security.SecurityManager"
		alias
			"LoadPolicyLevelFromFile"
		end

	frozen is_granted (perm: IPERMISSION): BOOLEAN is
		external
			"IL static signature (System.Security.IPermission): System.Boolean use System.Security.SecurityManager"
		alias
			"IsGranted"
		end

	frozen resolve_policy_groups (evidence: EVIDENCE): IENUMERATOR is
		external
			"IL static signature (System.Security.Policy.Evidence): System.Collections.IEnumerator use System.Security.SecurityManager"
		alias
			"ResolvePolicyGroups"
		end

	frozen save_policy_level (level: POLICY_LEVEL) is
		external
			"IL static signature (System.Security.Policy.PolicyLevel): System.Void use System.Security.SecurityManager"
		alias
			"SavePolicyLevel"
		end

	frozen load_policy_level_from_string (str: SYSTEM_STRING; type: POLICY_LEVEL_TYPE): POLICY_LEVEL is
		external
			"IL static signature (System.String, System.Security.PolicyLevelType): System.Security.Policy.PolicyLevel use System.Security.SecurityManager"
		alias
			"LoadPolicyLevelFromString"
		end

	frozen resolve_policy_evidence_permission_set (evidence: EVIDENCE; reqd_pset: PERMISSION_SET; opt_pset: PERMISSION_SET; deny_pset: PERMISSION_SET; denied: PERMISSION_SET): PERMISSION_SET is
		external
			"IL static signature (System.Security.Policy.Evidence, System.Security.PermissionSet, System.Security.PermissionSet, System.Security.PermissionSet, System.Security.PermissionSet&): System.Security.PermissionSet use System.Security.SecurityManager"
		alias
			"ResolvePolicy"
		end

	frozen save_policy is
		external
			"IL static signature (): System.Void use System.Security.SecurityManager"
		alias
			"SavePolicy"
		end

	frozen resolve_policy (evidence: EVIDENCE): PERMISSION_SET is
		external
			"IL static signature (System.Security.Policy.Evidence): System.Security.PermissionSet use System.Security.SecurityManager"
		alias
			"ResolvePolicy"
		end

	frozen policy_hierarchy: IENUMERATOR is
		external
			"IL static signature (): System.Collections.IEnumerator use System.Security.SecurityManager"
		alias
			"PolicyHierarchy"
		end

end -- class SECURITY_MANAGER
