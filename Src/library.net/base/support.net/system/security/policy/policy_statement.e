indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Policy.PolicyStatement"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	POLICY_STATEMENT

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ISECURITY_ENCODABLE
	ISECURITY_POLICY_ENCODABLE
		rename
			from_xml as from_xml_security_element_policy_level,
			to_xml as to_xml_policy_level
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (perm_set: PERMISSION_SET) is
		external
			"IL creator signature (System.Security.PermissionSet) use System.Security.Policy.PolicyStatement"
		end

	frozen make_1 (perm_set: PERMISSION_SET; attributes: POLICY_STATEMENT_ATTRIBUTE) is
		external
			"IL creator signature (System.Security.PermissionSet, System.Security.Policy.PolicyStatementAttribute) use System.Security.Policy.PolicyStatement"
		end

feature -- Access

	frozen get_permission_set: PERMISSION_SET is
		external
			"IL signature (): System.Security.PermissionSet use System.Security.Policy.PolicyStatement"
		alias
			"get_PermissionSet"
		end

	frozen get_attribute_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.PolicyStatement"
		alias
			"get_AttributeString"
		end

	frozen get_attributes: POLICY_STATEMENT_ATTRIBUTE is
		external
			"IL signature (): System.Security.Policy.PolicyStatementAttribute use System.Security.Policy.PolicyStatement"
		alias
			"get_Attributes"
		end

feature -- Element Change

	frozen set_permission_set (value: PERMISSION_SET) is
		external
			"IL signature (System.Security.PermissionSet): System.Void use System.Security.Policy.PolicyStatement"
		alias
			"set_PermissionSet"
		end

	frozen set_attributes (value: POLICY_STATEMENT_ATTRIBUTE) is
		external
			"IL signature (System.Security.Policy.PolicyStatementAttribute): System.Void use System.Security.Policy.PolicyStatement"
		alias
			"set_Attributes"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.PolicyStatement"
		alias
			"ToString"
		end

	frozen from_xml_security_element_policy_level (et: SECURITY_ELEMENT; level: POLICY_LEVEL) is
		external
			"IL signature (System.Security.SecurityElement, System.Security.Policy.PolicyLevel): System.Void use System.Security.Policy.PolicyStatement"
		alias
			"FromXml"
		end

	frozen from_xml (et: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Policy.PolicyStatement"
		alias
			"FromXml"
		end

	frozen to_xml: SECURITY_ELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Policy.PolicyStatement"
		alias
			"ToXml"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Policy.PolicyStatement"
		alias
			"Equals"
		end

	frozen copy_: POLICY_STATEMENT is
		external
			"IL signature (): System.Security.Policy.PolicyStatement use System.Security.Policy.PolicyStatement"
		alias
			"Copy"
		end

	frozen to_xml_policy_level (level: POLICY_LEVEL): SECURITY_ELEMENT is
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

end -- class POLICY_STATEMENT
