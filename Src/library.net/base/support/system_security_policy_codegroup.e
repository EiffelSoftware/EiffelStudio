indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Policy.CodeGroup"

deferred external class
	SYSTEM_SECURITY_POLICY_CODEGROUP

inherit
	ANY
		redefine
			get_hash_code,
			is_equal
		end

feature -- Access

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Security.Policy.CodeGroup"
		alias
			"get_Name"
		end

	frozen get_policy_statement: SYSTEM_SECURITY_POLICY_POLICYSTATEMENT is
		external
			"IL signature (): System.Security.Policy.PolicyStatement use System.Security.Policy.CodeGroup"
		alias
			"get_PolicyStatement"
		end

	get_merge_logic: STRING is
		external
			"IL deferred signature (): System.String use System.Security.Policy.CodeGroup"
		alias
			"get_MergeLogic"
		end

	get_attribute_string: STRING is
		external
			"IL signature (): System.String use System.Security.Policy.CodeGroup"
		alias
			"get_AttributeString"
		end

	frozen get_membership_condition: SYSTEM_SECURITY_POLICY_IMEMBERSHIPCONDITION is
		external
			"IL signature (): System.Security.Policy.IMembershipCondition use System.Security.Policy.CodeGroup"
		alias
			"get_MembershipCondition"
		end

	get_permission_set_name: STRING is
		external
			"IL signature (): System.String use System.Security.Policy.CodeGroup"
		alias
			"get_PermissionSetName"
		end

	frozen get_description: STRING is
		external
			"IL signature (): System.String use System.Security.Policy.CodeGroup"
		alias
			"get_Description"
		end

	frozen get_children: SYSTEM_COLLECTIONS_ILIST is
		external
			"IL signature (): System.Collections.IList use System.Security.Policy.CodeGroup"
		alias
			"get_Children"
		end

feature -- Element Change

	frozen set_membership_condition (value: SYSTEM_SECURITY_POLICY_IMEMBERSHIPCONDITION) is
		external
			"IL signature (System.Security.Policy.IMembershipCondition): System.Void use System.Security.Policy.CodeGroup"
		alias
			"set_MembershipCondition"
		end

	frozen set_children (value: SYSTEM_COLLECTIONS_ILIST) is
		external
			"IL signature (System.Collections.IList): System.Void use System.Security.Policy.CodeGroup"
		alias
			"set_Children"
		end

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Policy.CodeGroup"
		alias
			"set_Name"
		end

	frozen set_description (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Policy.CodeGroup"
		alias
			"set_Description"
		end

	frozen set_policy_statement (value: SYSTEM_SECURITY_POLICY_POLICYSTATEMENT) is
		external
			"IL signature (System.Security.Policy.PolicyStatement): System.Void use System.Security.Policy.CodeGroup"
		alias
			"set_PolicyStatement"
		end

feature -- Basic Operations

	frozen to_xml_policy_level (level: SYSTEM_SECURITY_POLICY_POLICYLEVEL): SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (System.Security.Policy.PolicyLevel): System.Security.SecurityElement use System.Security.Policy.CodeGroup"
		alias
			"ToXml"
		end

	resolve (evidence: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_SECURITY_POLICY_POLICYSTATEMENT is
		external
			"IL deferred signature (System.Security.Policy.Evidence): System.Security.Policy.PolicyStatement use System.Security.Policy.CodeGroup"
		alias
			"Resolve"
		end

	frozen equals_code_group (cg: SYSTEM_SECURITY_POLICY_CODEGROUP; compare_children: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Security.Policy.CodeGroup, System.Boolean): System.Boolean use System.Security.Policy.CodeGroup"
		alias
			"Equals"
		end

	frozen from_xml (e: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Policy.CodeGroup"
		alias
			"FromXml"
		end

	copy: SYSTEM_SECURITY_POLICY_CODEGROUP is
		external
			"IL deferred signature (): System.Security.Policy.CodeGroup use System.Security.Policy.CodeGroup"
		alias
			"Copy"
		end

	resolve_matching_code_groups (evidence: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_SECURITY_POLICY_CODEGROUP is
		external
			"IL deferred signature (System.Security.Policy.Evidence): System.Security.Policy.CodeGroup use System.Security.Policy.CodeGroup"
		alias
			"ResolveMatchingCodeGroups"
		end

	frozen remove_child (group: SYSTEM_SECURITY_POLICY_CODEGROUP) is
		external
			"IL signature (System.Security.Policy.CodeGroup): System.Void use System.Security.Policy.CodeGroup"
		alias
			"RemoveChild"
		end

	frozen to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Policy.CodeGroup"
		alias
			"ToXml"
		end

	is_equal (o: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Policy.CodeGroup"
		alias
			"Equals"
		end

	frozen from_xml_security_element_policy_level (e: SYSTEM_SECURITY_SECURITYELEMENT; level: SYSTEM_SECURITY_POLICY_POLICYLEVEL) is
		external
			"IL signature (System.Security.SecurityElement, System.Security.Policy.PolicyLevel): System.Void use System.Security.Policy.CodeGroup"
		alias
			"FromXml"
		end

	frozen add_child (group: SYSTEM_SECURITY_POLICY_CODEGROUP) is
		external
			"IL signature (System.Security.Policy.CodeGroup): System.Void use System.Security.Policy.CodeGroup"
		alias
			"AddChild"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Policy.CodeGroup"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	create_xml (element: SYSTEM_SECURITY_SECURITYELEMENT; level: SYSTEM_SECURITY_POLICY_POLICYLEVEL) is
		external
			"IL signature (System.Security.SecurityElement, System.Security.Policy.PolicyLevel): System.Void use System.Security.Policy.CodeGroup"
		alias
			"CreateXml"
		end

	parse_xml (e: SYSTEM_SECURITY_SECURITYELEMENT; level: SYSTEM_SECURITY_POLICY_POLICYLEVEL) is
		external
			"IL signature (System.Security.SecurityElement, System.Security.Policy.PolicyLevel): System.Void use System.Security.Policy.CodeGroup"
		alias
			"ParseXml"
		end

end -- class SYSTEM_SECURITY_POLICY_CODEGROUP
