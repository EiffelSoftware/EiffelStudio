indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Policy.ZoneMembershipCondition"

frozen external class
	SYSTEM_SECURITY_POLICY_ZONEMEMBERSHIPCONDITION

inherit
	ANY
		rename
			to_string as to_string_with_format_and_provider
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string_with_format_and_provider
		end
	SYSTEM_SECURITY_POLICY_IMEMBERSHIPCONDITION
		rename
			to_string as to_string_with_format_and_provider
		end
	SYSTEM_SECURITY_ISECURITYENCODABLE
		rename
			to_string as to_string_with_format_and_provider
		end
	SYSTEM_SECURITY_ISECURITYPOLICYENCODABLE
		rename
			from_xml as from_xml_security_element_policy_level,
			to_xml as to_xml_policy_level,
			to_string as to_string_with_format_and_provider
		end

create
	make

feature {NONE} -- Initialization

	frozen make (zone: INTEGER) is
			-- Valid values for `zone' are:
			-- MyComputer = 0
			-- Intranet = 1
			-- Trusted = 2
			-- Internet = 3
			-- Untrusted = 4
			-- NoZone = -1
		require
			valid_security_zone: zone = 0 or zone = 1 or zone = 2 or zone = 3 or zone = 4 or zone = -1
		external
			"IL creator signature (enum System.Security.SecurityZone) use System.Security.Policy.ZoneMembershipCondition"
		end

feature -- Access

	frozen get_security_zone: INTEGER is
		external
			"IL signature (): enum System.Security.SecurityZone use System.Security.Policy.ZoneMembershipCondition"
		alias
			"get_SecurityZone"
		ensure
			valid_security_zone: Result = 0 or Result = 1 or Result = 2 or Result = 3 or Result = 4 or Result = -1
		end

feature -- Element Change

	frozen set_security_zone (value: INTEGER) is
			-- Valid values for `value' are:
			-- MyComputer = 0
			-- Intranet = 1
			-- Trusted = 2
			-- Internet = 3
			-- Untrusted = 4
			-- NoZone = -1
		require
			valid_security_zone: value = 0 or value = 1 or value = 2 or value = 3 or value = 4 or value = -1
		external
			"IL signature (enum System.Security.SecurityZone): System.Void use System.Security.Policy.ZoneMembershipCondition"
		alias
			"set_SecurityZone"
		end

feature -- Basic Operations

	frozen from_xml_security_element_policy_level (e: SYSTEM_SECURITY_SECURITYELEMENT; level: SYSTEM_SECURITY_POLICY_POLICYLEVEL) is
		external
			"IL signature (System.Security.SecurityElement, System.Security.Policy.PolicyLevel): System.Void use System.Security.Policy.ZoneMembershipCondition"
		alias
			"FromXml"
		end

	frozen from_xml (e: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Policy.ZoneMembershipCondition"
		alias
			"FromXml"
		end

	frozen copy: SYSTEM_SECURITY_POLICY_IMEMBERSHIPCONDITION is
		external
			"IL signature (): System.Security.Policy.IMembershipCondition use System.Security.Policy.ZoneMembershipCondition"
		alias
			"Copy"
		end

	frozen to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Policy.ZoneMembershipCondition"
		alias
			"ToXml"
		end

	is_equal (o: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Policy.ZoneMembershipCondition"
		alias
			"Equals"
		end

	frozen Check_ (evidence: SYSTEM_SECURITY_POLICY_EVIDENCE): BOOLEAN is
		external
			"IL signature (System.Security.Policy.Evidence): System.Boolean use System.Security.Policy.ZoneMembershipCondition"
		alias
			"Check"
		end

	to_string_with_format_and_provider: STRING is
		external
			"IL signature (): System.String use System.Security.Policy.ZoneMembershipCondition"
		alias
			"ToString"
		end

	frozen to_xml_policy_level (level: SYSTEM_SECURITY_POLICY_POLICYLEVEL): SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (System.Security.Policy.PolicyLevel): System.Security.SecurityElement use System.Security.Policy.ZoneMembershipCondition"
		alias
			"ToXml"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Policy.ZoneMembershipCondition"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Security.Policy.ZoneMembershipCondition"
		alias
			"Finalize"
		end

end -- class SYSTEM_SECURITY_POLICY_ZONEMEMBERSHIPCONDITION
