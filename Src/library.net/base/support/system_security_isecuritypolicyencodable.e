indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.ISecurityPolicyEncodable"

deferred external class
	SYSTEM_SECURITY_ISECURITYPOLICYENCODABLE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	from_xml (e: SYSTEM_SECURITY_SECURITYELEMENT; level: SYSTEM_SECURITY_POLICY_POLICYLEVEL) is
		external
			"IL deferred signature (System.Security.SecurityElement, System.Security.Policy.PolicyLevel): System.Void use System.Security.ISecurityPolicyEncodable"
		alias
			"FromXml"
		end

	to_xml (level: SYSTEM_SECURITY_POLICY_POLICYLEVEL): SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL deferred signature (System.Security.Policy.PolicyLevel): System.Security.SecurityElement use System.Security.ISecurityPolicyEncodable"
		alias
			"ToXml"
		end

end -- class SYSTEM_SECURITY_ISECURITYPOLICYENCODABLE
