indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.SecurityManager"

frozen external class
	SYSTEM_SECURITY_SECURITYMANAGER

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

	frozen load_policy_level_from_file (path: STRING; type: SYSTEM_SECURITY_POLICYLEVELTYPE): SYSTEM_SECURITY_POLICY_POLICYLEVEL is
		external
			"IL static signature (System.String, System.Security.PolicyLevelType): System.Security.Policy.PolicyLevel use System.Security.SecurityManager"
		alias
			"LoadPolicyLevelFromFile"
		end

	frozen is_granted (perm: SYSTEM_SECURITY_IPERMISSION): BOOLEAN is
		external
			"IL static signature (System.Security.IPermission): System.Boolean use System.Security.SecurityManager"
		alias
			"IsGranted"
		end

	frozen resolve_policy_groups (evidence: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL static signature (System.Security.Policy.Evidence): System.Collections.IEnumerator use System.Security.SecurityManager"
		alias
			"ResolvePolicyGroups"
		end

	frozen save_policy_level (level: SYSTEM_SECURITY_POLICY_POLICYLEVEL) is
		external
			"IL static signature (System.Security.Policy.PolicyLevel): System.Void use System.Security.SecurityManager"
		alias
			"SavePolicyLevel"
		end

	frozen load_policy_level_from_string (str: STRING; type: SYSTEM_SECURITY_POLICYLEVELTYPE): SYSTEM_SECURITY_POLICY_POLICYLEVEL is
		external
			"IL static signature (System.String, System.Security.PolicyLevelType): System.Security.Policy.PolicyLevel use System.Security.SecurityManager"
		alias
			"LoadPolicyLevelFromString"
		end

	frozen resolve_policy_evidence_permission_set (evidence: SYSTEM_SECURITY_POLICY_EVIDENCE; reqd_pset: SYSTEM_SECURITY_PERMISSIONSET; opt_pset: SYSTEM_SECURITY_PERMISSIONSET; deny_pset: SYSTEM_SECURITY_PERMISSIONSET; denied: SYSTEM_SECURITY_PERMISSIONSET): SYSTEM_SECURITY_PERMISSIONSET is
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

	frozen resolve_policy (evidence: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_SECURITY_PERMISSIONSET is
		external
			"IL static signature (System.Security.Policy.Evidence): System.Security.PermissionSet use System.Security.SecurityManager"
		alias
			"ResolvePolicy"
		end

	frozen policy_hierarchy: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL static signature (): System.Collections.IEnumerator use System.Security.SecurityManager"
		alias
			"PolicyHierarchy"
		end

end -- class SYSTEM_SECURITY_SECURITYMANAGER
