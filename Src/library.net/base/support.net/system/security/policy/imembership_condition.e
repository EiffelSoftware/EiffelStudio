indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Policy.IMembershipCondition"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IMEMBERSHIP_CONDITION

inherit
	ISECURITY_ENCODABLE
	ISECURITY_POLICY_ENCODABLE
		rename
			from_xml as from_xml_security_element_policy_level,
			to_xml as to_xml_policy_level
		end

feature -- Basic Operations

	equals_object (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL deferred signature (System.Object): System.Boolean use System.Security.Policy.IMembershipCondition"
		alias
			"Equals"
		end

	check_ (evidence: EVIDENCE): BOOLEAN is
		external
			"IL deferred signature (System.Security.Policy.Evidence): System.Boolean use System.Security.Policy.IMembershipCondition"
		alias
			"Check"
		end

	to_string_string: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Security.Policy.IMembershipCondition"
		alias
			"ToString"
		end

	copy_: IMEMBERSHIP_CONDITION is
		external
			"IL deferred signature (): System.Security.Policy.IMembershipCondition use System.Security.Policy.IMembershipCondition"
		alias
			"Copy"
		end

end -- class IMEMBERSHIP_CONDITION
