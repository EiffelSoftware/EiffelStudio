indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Policy.PolicyStatement"

frozen external class
	SYSTEM_SECURITY_POLICY_POLICYSTATEMENT

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_SECURITY_ISECURITYENCODABLE
	SYSTEM_SECURITY_ISECURITYPOLICYENCODABLE
		rename
			from_xml as from_xml_security_element_policy_level,
			to_xml as to_xml_policy_level
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (perm_set: SYSTEM_SECURITY_PERMISSIONSET) is
		external
			"IL creator signature (System.Security.PermissionSet) use System.Security.Policy.PolicyStatement"
		end

	frozen make_1 (perm_set: SYSTEM_SECURITY_PERMISSIONSET; attributes: SYSTEM_SECURITY_POLICY_POLICYSTATEMENTATTRIBUTE) is
		external
			"IL creator signature (System.Security.PermissionSet, System.Security.Policy.PolicyStatementAttribute) use System.Security.Policy.PolicyStatement"
		end

feature -- Access

	frozen get_permission_set: SYSTEM_SECURITY_PERMISSIONSET is
		external
			"IL signature (): System.Security.PermissionSet use System.Security.Policy.PolicyStatement"
		alias
			"get_PermissionSet"
		end

	frozen get_attribute_string: STRING is
		external
			"IL signature (): System.String use System.Security.Policy.PolicyStatement"
		alias
			"get_AttributeString"
		end

	frozen get_attributes: SYSTEM_SECURITY_POLICY_POLICYSTATEMENTATTRIBUTE is
		external
			"IL signature (): System.Security.Policy.PolicyStatementAttribute use System.Security.Policy.PolicyStatement"
		alias
			"get_Attributes"
		end

feature -- Element Change

	frozen set_permission_set (value: SYSTEM_SECURITY_PERMISSIONSET) is
		external
			"IL signature (System.Security.PermissionSet): System.Void use System.Security.Policy.PolicyStatement"
		alias
			"set_PermissionSet"
		end

	frozen set_attributes (value: SYSTEM_SECURITY_POLICY_POLICYSTATEMENTATTRIBUTE) is
		external
			"IL signature (System.Security.Policy.PolicyStatementAttribute): System.Void use System.Security.Policy.PolicyStatement"
		alias
			"set_Attributes"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Security.Policy.PolicyStatement"
		alias
			"ToString"
		end

	frozen from_xml_security_element_policy_level (et: SYSTEM_SECURITY_SECURITYELEMENT; level: SYSTEM_SECURITY_POLICY_POLICYLEVEL) is
		external
			"IL signature (System.Security.SecurityElement, System.Security.Policy.PolicyLevel): System.Void use System.Security.Policy.PolicyStatement"
		alias
			"FromXml"
		end

	frozen from_xml (et: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Policy.PolicyStatement"
		alias
			"FromXml"
		end

	frozen copy: SYSTEM_SECURITY_POLICY_POLICYSTATEMENT is
		external
			"IL signature (): System.Security.Policy.PolicyStatement use System.Security.Policy.PolicyStatement"
		alias
			"Copy"
		end

	frozen to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Policy.PolicyStatement"
		alias
			"ToXml"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Policy.PolicyStatement"
		alias
			"Equals"
		end

	frozen to_xml_policy_level (level: SYSTEM_SECURITY_POLICY_POLICYLEVEL): SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (System.Security.Policy.PolicyLevel): System.Security.SecurityElement use System.Security.Policy.PolicyStatement"
		alias
			"ToXml"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Policy.PolicyStatement"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Security.Policy.PolicyStatement"
		alias
			"Finalize"
		end

end -- class SYSTEM_SECURITY_POLICY_POLICYSTATEMENT
