indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.ISecurityPolicyEncodable"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ISECURITY_POLICY_ENCODABLE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	from_xml (e: SECURITY_ELEMENT; level: POLICY_LEVEL) is
		external
			"IL deferred signature (System.Security.SecurityElement, System.Security.Policy.PolicyLevel): System.Void use System.Security.ISecurityPolicyEncodable"
		alias
			"FromXml"
		end

	to_xml (level: POLICY_LEVEL): SECURITY_ELEMENT is
		external
			"IL deferred signature (System.Security.Policy.PolicyLevel): System.Security.SecurityElement use System.Security.ISecurityPolicyEncodable"
		alias
			"ToXml"
		end

end -- class ISECURITY_POLICY_ENCODABLE
