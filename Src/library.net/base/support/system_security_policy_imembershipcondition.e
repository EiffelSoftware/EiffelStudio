indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Policy.IMembershipCondition"

deferred external class
	SYSTEM_SECURITY_POLICY_IMEMBERSHIPCONDITION

inherit
	SYSTEM_SECURITY_ISECURITYENCODABLE
	SYSTEM_SECURITY_ISECURITYPOLICYENCODABLE
		rename
			from_xml as from_xml_security_element_policy_level,
			to_xml as to_xml_policy_level
		end

feature -- Basic Operations

	Check_ (evidence: SYSTEM_SECURITY_POLICY_EVIDENCE): BOOLEAN is
		external
			"IL deferred signature (System.Security.Policy.Evidence): System.Boolean use System.Security.Policy.IMembershipCondition"
		alias
			"Check"
		end

	to_string_string: STRING is
		external
			"IL deferred signature (): System.String use System.Security.Policy.IMembershipCondition"
		alias
			"ToString"
		end

	copy: SYSTEM_SECURITY_POLICY_IMEMBERSHIPCONDITION is
		external
			"IL deferred signature (): System.Security.Policy.IMembershipCondition use System.Security.Policy.IMembershipCondition"
		alias
			"Copy"
		end

end -- class SYSTEM_SECURITY_POLICY_IMEMBERSHIPCONDITION
