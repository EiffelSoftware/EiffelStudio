indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Policy.StrongNameMembershipCondition"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	STRONG_NAME_MEMBERSHIP_CONDITION

inherit
	SYSTEM_OBJECT
		rename
			equals as equals_object,
			to_string as to_string_string
		redefine
			finalize,
			get_hash_code,
			equals_object,
			to_string_string
		end
	IMEMBERSHIP_CONDITION
		rename
			equals as equals_object,
			to_string as to_string_string
		end
	ISECURITY_ENCODABLE
		rename
			equals as equals_object,
			to_string as to_string_string
		end
	ISECURITY_POLICY_ENCODABLE
		rename
			from_xml as from_xml_security_element_policy_level,
			to_xml as to_xml_policy_level,
			equals as equals_object,
			to_string as to_string_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make (blob: STRONG_NAME_PUBLIC_KEY_BLOB; name: SYSTEM_STRING; version: VERSION) is
		external
			"IL creator signature (System.Security.Permissions.StrongNamePublicKeyBlob, System.String, System.Version) use System.Security.Policy.StrongNameMembershipCondition"
		end

feature -- Access

	frozen get_version: VERSION is
		external
			"IL signature (): System.Version use System.Security.Policy.StrongNameMembershipCondition"
		alias
			"get_Version"
		end

	frozen get_public_key: STRONG_NAME_PUBLIC_KEY_BLOB is
		external
			"IL signature (): System.Security.Permissions.StrongNamePublicKeyBlob use System.Security.Policy.StrongNameMembershipCondition"
		alias
			"get_PublicKey"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.StrongNameMembershipCondition"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Policy.StrongNameMembershipCondition"
		alias
			"set_Name"
		end

	frozen set_version (value: VERSION) is
		external
			"IL signature (System.Version): System.Void use System.Security.Policy.StrongNameMembershipCondition"
		alias
			"set_Version"
		end

	frozen set_public_key (value: STRONG_NAME_PUBLIC_KEY_BLOB) is
		external
			"IL signature (System.Security.Permissions.StrongNamePublicKeyBlob): System.Void use System.Security.Policy.StrongNameMembershipCondition"
		alias
			"set_PublicKey"
		end

feature -- Basic Operations

	frozen check_ (evidence: EVIDENCE): BOOLEAN is
		external
			"IL signature (System.Security.Policy.Evidence): System.Boolean use System.Security.Policy.StrongNameMembershipCondition"
		alias
			"Check"
		end

	frozen from_xml_security_element_policy_level (e: SECURITY_ELEMENT; level: POLICY_LEVEL) is
		external
			"IL signature (System.Security.SecurityElement, System.Security.Policy.PolicyLevel): System.Void use System.Security.Policy.StrongNameMembershipCondition"
		alias
			"FromXml"
		end

	frozen from_xml (e: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Policy.StrongNameMembershipCondition"
		alias
			"FromXml"
		end

	to_string_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.StrongNameMembershipCondition"
		alias
			"ToString"
		end

	frozen to_xml: SECURITY_ELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Policy.StrongNameMembershipCondition"
		alias
			"ToXml"
		end

	equals_object (o: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Policy.StrongNameMembershipCondition"
		alias
			"Equals"
		end

	frozen copy_: IMEMBERSHIP_CONDITION is
		external
			"IL signature (): System.Security.Policy.IMembershipCondition use System.Security.Policy.StrongNameMembershipCondition"
		alias
			"Copy"
		end

	frozen to_xml_policy_level (level: POLICY_LEVEL): SECURITY_ELEMENT is
		external
			"IL signature (System.Security.Policy.PolicyLevel): System.Security.SecurityElement use System.Security.Policy.StrongNameMembershipCondition"
		alias
			"ToXml"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Policy.StrongNameMembershipCondition"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Security.Policy.StrongNameMembershipCondition"
		alias
			"Finalize"
		end

end -- class STRONG_NAME_MEMBERSHIP_CONDITION
