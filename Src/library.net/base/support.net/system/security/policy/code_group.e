indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Policy.CodeGroup"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	CODE_GROUP

inherit
	SYSTEM_OBJECT
		redefine
			get_hash_code,
			equals
		end

feature -- Access

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.CodeGroup"
		alias
			"get_Name"
		end

	frozen get_policy_statement: POLICY_STATEMENT is
		external
			"IL signature (): System.Security.Policy.PolicyStatement use System.Security.Policy.CodeGroup"
		alias
			"get_PolicyStatement"
		end

	get_merge_logic: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Security.Policy.CodeGroup"
		alias
			"get_MergeLogic"
		end

	get_attribute_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.CodeGroup"
		alias
			"get_AttributeString"
		end

	frozen get_membership_condition: IMEMBERSHIP_CONDITION is
		external
			"IL signature (): System.Security.Policy.IMembershipCondition use System.Security.Policy.CodeGroup"
		alias
			"get_MembershipCondition"
		end

	get_permission_set_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.CodeGroup"
		alias
			"get_PermissionSetName"
		end

	frozen get_description: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.CodeGroup"
		alias
			"get_Description"
		end

	frozen get_children: ILIST is
		external
			"IL signature (): System.Collections.IList use System.Security.Policy.CodeGroup"
		alias
			"get_Children"
		end

feature -- Element Change

	frozen set_membership_condition (value: IMEMBERSHIP_CONDITION) is
		external
			"IL signature (System.Security.Policy.IMembershipCondition): System.Void use System.Security.Policy.CodeGroup"
		alias
			"set_MembershipCondition"
		end

	frozen set_children (value: ILIST) is
		external
			"IL signature (System.Collections.IList): System.Void use System.Security.Policy.CodeGroup"
		alias
			"set_Children"
		end

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Policy.CodeGroup"
		alias
			"set_Name"
		end

	frozen set_description (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Policy.CodeGroup"
		alias
			"set_Description"
		end

	frozen set_policy_statement (value: POLICY_STATEMENT) is
		external
			"IL signature (System.Security.Policy.PolicyStatement): System.Void use System.Security.Policy.CodeGroup"
		alias
			"set_PolicyStatement"
		end

feature -- Basic Operations

	frozen to_xml_policy_level (level: POLICY_LEVEL): SECURITY_ELEMENT is
		external
			"IL signature (System.Security.Policy.PolicyLevel): System.Security.SecurityElement use System.Security.Policy.CodeGroup"
		alias
			"ToXml"
		end

	resolve (evidence: EVIDENCE): POLICY_STATEMENT is
		external
			"IL deferred signature (System.Security.Policy.Evidence): System.Security.Policy.PolicyStatement use System.Security.Policy.CodeGroup"
		alias
			"Resolve"
		end

	frozen from_xml (e: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Policy.CodeGroup"
		alias
			"FromXml"
		end

	frozen from_xml_security_element_policy_level (e: SECURITY_ELEMENT; level: POLICY_LEVEL) is
		external
			"IL signature (System.Security.SecurityElement, System.Security.Policy.PolicyLevel): System.Void use System.Security.Policy.CodeGroup"
		alias
			"FromXml"
		end

	resolve_matching_code_groups (evidence: EVIDENCE): CODE_GROUP is
		external
			"IL deferred signature (System.Security.Policy.Evidence): System.Security.Policy.CodeGroup use System.Security.Policy.CodeGroup"
		alias
			"ResolveMatchingCodeGroups"
		end

	frozen remove_child (group: CODE_GROUP) is
		external
			"IL signature (System.Security.Policy.CodeGroup): System.Void use System.Security.Policy.CodeGroup"
		alias
			"RemoveChild"
		end

	frozen to_xml: SECURITY_ELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Policy.CodeGroup"
		alias
			"ToXml"
		end

	frozen equals_code_group (cg: CODE_GROUP; compare_children: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Security.Policy.CodeGroup, System.Boolean): System.Boolean use System.Security.Policy.CodeGroup"
		alias
			"Equals"
		end

	equals (o: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Policy.CodeGroup"
		alias
			"Equals"
		end

	copy_: CODE_GROUP is
		external
			"IL deferred signature (): System.Security.Policy.CodeGroup use System.Security.Policy.CodeGroup"
		alias
			"Copy"
		end

	frozen add_child (group: CODE_GROUP) is
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

	create_xml (element: SECURITY_ELEMENT; level: POLICY_LEVEL) is
		external
			"IL signature (System.Security.SecurityElement, System.Security.Policy.PolicyLevel): System.Void use System.Security.Policy.CodeGroup"
		alias
			"CreateXml"
		end

	parse_xml (e: SECURITY_ELEMENT; level: POLICY_LEVEL) is
		external
			"IL signature (System.Security.SecurityElement, System.Security.Policy.PolicyLevel): System.Void use System.Security.Policy.CodeGroup"
		alias
			"ParseXml"
		end

end -- class CODE_GROUP
