indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Policy.PolicyLevel"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	POLICY_LEVEL

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_store_location: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.PolicyLevel"
		alias
			"get_StoreLocation"
		end

	frozen get_named_permission_sets: ILIST is
		external
			"IL signature (): System.Collections.IList use System.Security.Policy.PolicyLevel"
		alias
			"get_NamedPermissionSets"
		end

	frozen get_label: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.PolicyLevel"
		alias
			"get_Label"
		end

	frozen get_full_trust_assemblies: ILIST is
		external
			"IL signature (): System.Collections.IList use System.Security.Policy.PolicyLevel"
		alias
			"get_FullTrustAssemblies"
		end

	frozen get_root_code_group: CODE_GROUP is
		external
			"IL signature (): System.Security.Policy.CodeGroup use System.Security.Policy.PolicyLevel"
		alias
			"get_RootCodeGroup"
		end

feature -- Element Change

	frozen set_root_code_group (value: CODE_GROUP) is
		external
			"IL signature (System.Security.Policy.CodeGroup): System.Void use System.Security.Policy.PolicyLevel"
		alias
			"set_RootCodeGroup"
		end

feature -- Basic Operations

	frozen add_full_trust_assembly_strong_name (sn: STRONG_NAME) is
		external
			"IL signature (System.Security.Policy.StrongName): System.Void use System.Security.Policy.PolicyLevel"
		alias
			"AddFullTrustAssembly"
		end

	frozen remove_named_permission_set_named_permission_set (perm_set: NAMED_PERMISSION_SET): NAMED_PERMISSION_SET is
		external
			"IL signature (System.Security.NamedPermissionSet): System.Security.NamedPermissionSet use System.Security.Policy.PolicyLevel"
		alias
			"RemoveNamedPermissionSet"
		end

	frozen change_named_permission_set (name: SYSTEM_STRING; p_set: PERMISSION_SET): NAMED_PERMISSION_SET is
		external
			"IL signature (System.String, System.Security.PermissionSet): System.Security.NamedPermissionSet use System.Security.Policy.PolicyLevel"
		alias
			"ChangeNamedPermissionSet"
		end

	frozen get_named_permission_set (name: SYSTEM_STRING): NAMED_PERMISSION_SET is
		external
			"IL signature (System.String): System.Security.NamedPermissionSet use System.Security.Policy.PolicyLevel"
		alias
			"GetNamedPermissionSet"
		end

	frozen from_xml (e: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Policy.PolicyLevel"
		alias
			"FromXml"
		end

	frozen create_app_domain_level: POLICY_LEVEL is
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

	frozen remove_named_permission_set (name: SYSTEM_STRING): NAMED_PERMISSION_SET is
		external
			"IL signature (System.String): System.Security.NamedPermissionSet use System.Security.Policy.PolicyLevel"
		alias
			"RemoveNamedPermissionSet"
		end

	frozen to_xml: SECURITY_ELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Policy.PolicyLevel"
		alias
			"ToXml"
		end

	frozen remove_full_trust_assembly_strong_name (sn: STRONG_NAME) is
		external
			"IL signature (System.Security.Policy.StrongName): System.Void use System.Security.Policy.PolicyLevel"
		alias
			"RemoveFullTrustAssembly"
		end

	frozen add_named_permission_set (perm_set: NAMED_PERMISSION_SET) is
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

	frozen resolve_matching_code_groups (evidence: EVIDENCE): CODE_GROUP is
		external
			"IL signature (System.Security.Policy.Evidence): System.Security.Policy.CodeGroup use System.Security.Policy.PolicyLevel"
		alias
			"ResolveMatchingCodeGroups"
		end

	frozen add_full_trust_assembly (sn_mc: STRONG_NAME_MEMBERSHIP_CONDITION) is
		external
			"IL signature (System.Security.Policy.StrongNameMembershipCondition): System.Void use System.Security.Policy.PolicyLevel"
		alias
			"AddFullTrustAssembly"
		end

	frozen resolve (evidence: EVIDENCE): POLICY_STATEMENT is
		external
			"IL signature (System.Security.Policy.Evidence): System.Security.Policy.PolicyStatement use System.Security.Policy.PolicyLevel"
		alias
			"Resolve"
		end

	frozen remove_full_trust_assembly (sn_mc: STRONG_NAME_MEMBERSHIP_CONDITION) is
		external
			"IL signature (System.Security.Policy.StrongNameMembershipCondition): System.Void use System.Security.Policy.PolicyLevel"
		alias
			"RemoveFullTrustAssembly"
		end

end -- class POLICY_LEVEL
