indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.ISecurityEncodable"

deferred external class
	SYSTEM_SECURITY_ISECURITYENCODABLE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	from_xml (e: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL deferred signature (System.Security.SecurityElement): System.Void use System.Security.ISecurityEncodable"
		alias
			"FromXml"
		end

	to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL deferred signature (): System.Security.SecurityElement use System.Security.ISecurityEncodable"
		alias
			"ToXml"
		end

end -- class SYSTEM_SECURITY_ISECURITYENCODABLE
