indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.ISecurityEncodable"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ISECURITY_ENCODABLE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	from_xml (e: SECURITY_ELEMENT) is
		external
			"IL deferred signature (System.Security.SecurityElement): System.Void use System.Security.ISecurityEncodable"
		alias
			"FromXml"
		end

	to_xml: SECURITY_ELEMENT is
		external
			"IL deferred signature (): System.Security.SecurityElement use System.Security.ISecurityEncodable"
		alias
			"ToXml"
		end

end -- class ISECURITY_ENCODABLE
