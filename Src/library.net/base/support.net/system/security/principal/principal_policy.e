indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Principal.PrincipalPolicy"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	PRINCIPAL_POLICY

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen windows_principal: PRINCIPAL_POLICY is
		external
			"IL enum signature :System.Security.Principal.PrincipalPolicy use System.Security.Principal.PrincipalPolicy"
		alias
			"2"
		end

	frozen unauthenticated_principal: PRINCIPAL_POLICY is
		external
			"IL enum signature :System.Security.Principal.PrincipalPolicy use System.Security.Principal.PrincipalPolicy"
		alias
			"0"
		end

	frozen no_principal: PRINCIPAL_POLICY is
		external
			"IL enum signature :System.Security.Principal.PrincipalPolicy use System.Security.Principal.PrincipalPolicy"
		alias
			"1"
		end

end -- class PRINCIPAL_POLICY
