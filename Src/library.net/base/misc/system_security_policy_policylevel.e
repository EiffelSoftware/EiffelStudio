indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Policy.PolicyLevel"

frozen external class
	SYSTEM_SECURITY_POLICY_POLICYLEVEL

create {NONE}

feature -- Access

	frozen get_store_location: STRING is
		external
			"IL signature (): System.String use System.Security.Policy.PolicyLevel"
		alias
			"get_StoreLocation"
		end

	frozen get_named_permission_sets: SYSTEM_COLLECTIONS_ILIST is
		external
			"IL signature (): System.Collections.IList use System.Security.Policy.PolicyLevel"
		alias
			"get_NamedPermissionSets"
		end

	frozen get_label: STRING is
		external
			"IL signature (): System.String use System.Security.Policy.PolicyLevel"
		alias
			"get_Label"
		end

	frozen get_full_trust_assemblies: SYSTEM_COLLECTIONS_ILIST is
		external
			"IL signature (): System.Collections.IList use System.Security.Policy.PolicyLevel"
		alias
			"get_FullTrustAssemblies"
		end

	frozen get_root_code_group: SYSTEM_SECURITY_POLICY_CODEGROUP is
		external
			"IL signature (): System.Security.Policy.CodeGroup use System.Security.Policy.PolicyLevel"
		alias
			"get_RootCodeGroup"
		end

feature -- Element Change

	frozen set_root_code_group (value: SYSTEM_SECURITY_POLICY_CODEGROUP) is
		external
			"IL signature (System.Security.Policy.CodeGroup): System.Void use System.Security.Policy.PolicyLevel"
		alias
			"set_RootCodeGroup"
		end

feature -- Basic Operations

	frozen add_full_trust_assembly_strong_name (sn: SYSTEM_SECURITY_POLICY_STRONGNAME) is
		external
			"IL signature (System.Security.Policy.StrongName): System.Void use System.Security.Policy.PolicyLevel"
		alias
			"AddFullTrustAssembly"
		end

	frozen remove_named_permission_set_named_permission_set (perm_set: SYSTEM_SECURITY_NAMEDPERMISSIONSET): SYSTEM_SECURITY_NAMEDPERMISSIONSET is
		external
			"IL signature (System.Security.NamedPermissionSet): System.Security.NamedPermissionSet use System.Security.Policy.PolicyLevel"
		alias
			"RemoveNamedPermissionSet"
		end

	frozen change_named_permission_set (name: STRING; p_set: SYSTEM_SECURITY_PERMISSIONSET): SYSTEM_SECURITY_NAMEDPERMISSIONSET is
		external
			"IL signature (System.String, System.Security.PermissionSet): System.Security.NamedPermissionSet use System.Security.Policy.PolicyLevel"
		alias
			"ChangeNamedPermissionSet"
		end

	frozen get_named_permission_set (name: STRING): SYSTEM_SECURITY_NAMEDPERMISSIONSET is
		external
			"IL signature (System.String): System.Security.NamedPermissionSet use System.Security.Policy.PolicyLevel"
		alias
			"GetNamedPermissionSet"
		end

	frozen from_xml (e: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Policy.PolicyLevel"
		alias
			"FromXml"
		end

	frozen create_app_domain_level: SYSTEM_SECURITY_POLICY_POLICYLEVEL is
		external
			"IL static signature (): System.Security.Policy.PolicyLevel use System.Security.Policy.PolicyLevel"
		alias
			"CreateAppDomainLevel"
		end

	frozen reset is
		external
			"IL signature (): System.Void use System.Security.Policy.PolicyLevel"
		alias
			"Reset"
		end

	frozen remove_named_permission_set (name: STRING): SYSTEM_SECURITY_NAMEDPERMISSIONSET is
		external
			"IL signature (System.String): System.Security.NamedPermissionSet use System.Security.Policy.PolicyLevel"
		alias
			"RemoveNamedPermissionSet"
		end

	frozen to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Policy.PolicyLevel"
		alias
			"ToXml"
		end

	frozen remove_full_trust_assembly_strong_name (sn: SYSTEM_SECURITY_POLICY_STRONGNAME) is
		external
			"IL signature (System.Security.Policy.StrongName): System.Void use System.Security.Policy.PolicyLevel"
		alias
			"RemoveFullTrustAssembly"
		end

	frozen add_named_permission_set (perm_set: SYSTEM_SECURITY_NAMEDPERMISSIONSET) is
		external
			"IL signature (System.Security.NamedPermissionSet): System.Void use System.Security.Policy.PolicyLevel"
		alias
			"AddNamedPermissionSet"
		end

	frozen recover is
		external
			"IL signature (): System.Void use System.Security.Policy.PolicyLevel"
		alias
			"Recover"
		end

	frozen resolve_matching_code_groups (evidence: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_SECURITY_POLICY_CODEGROUP is
		external
			"IL signature (System.Security.Policy.Evidence): System.Security.Policy.CodeGroup use System.Security.Policy.PolicyLevel"
		alias
			"ResolveMatchingCodeGroups"
		end

	frozen add_full_trust_assembly (sn_mc: SYSTEM_SECURITY_POLICY_STRONGNAMEMEMBERSHIPCONDITION) is
		external
			"IL signature (System.Security.Policy.StrongNameMembershipCondition): System.Void use System.Security.Policy.PolicyLevel"
		alias
			"AddFullTrustAssembly"
		end

	frozen resolve (evidence: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_SECURITY_POLICY_POLICYSTATEMENT is
		external
			"IL signature (System.Security.Policy.Evidence): System.Security.Policy.PolicyStatement use System.Security.Policy.PolicyLevel"
		alias
			"Resolve"
		end

	frozen remove_full_trust_assembly (sn_mc: SYSTEM_SECURITY_POLICY_STRONGNAMEMEMBERSHIPCONDITION) is
		external
			"IL signature (System.Security.Policy.StrongNameMembershipCondition): System.Void use System.Security.Policy.PolicyLevel"
		alias
			"RemoveFullTrustAssembly"
		end

end -- class SYSTEM_SECURITY_POLICY_POLICYLEVEL
