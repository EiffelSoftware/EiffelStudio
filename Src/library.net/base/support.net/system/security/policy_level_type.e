indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.PolicyLevelType"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	POLICY_LEVEL_TYPE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen user: POLICY_LEVEL_TYPE is
		external
			"IL enum signature :System.Security.PolicyLevelType use System.Security.PolicyLevelType"
		alias
			"0"
		end

	frozen machine: POLICY_LEVEL_TYPE is
		external
			"IL enum signature :System.Security.PolicyLevelType use System.Security.PolicyLevelType"
		alias
			"1"
		end

	frozen enterprise: POLICY_LEVEL_TYPE is
		external
			"IL enum signature :System.Security.PolicyLevelType use System.Security.PolicyLevelType"
		alias
			"2"
		end

	frozen app_domain: POLICY_LEVEL_TYPE is
		external
			"IL enum signature :System.Security.PolicyLevelType use System.Security.PolicyLevelType"
		alias
			"3"
		end

end -- class POLICY_LEVEL_TYPE
