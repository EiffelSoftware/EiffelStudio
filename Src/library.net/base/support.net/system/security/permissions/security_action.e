indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.SecurityAction"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	SECURITY_ACTION

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen deny: SECURITY_ACTION is
		external
			"IL enum signature :System.Security.Permissions.SecurityAction use System.Security.Permissions.SecurityAction"
		alias
			"4"
		end

	frozen permit_only: SECURITY_ACTION is
		external
			"IL enum signature :System.Security.Permissions.SecurityAction use System.Security.Permissions.SecurityAction"
		alias
			"5"
		end

	frozen request_optional: SECURITY_ACTION is
		external
			"IL enum signature :System.Security.Permissions.SecurityAction use System.Security.Permissions.SecurityAction"
		alias
			"9"
		end

	frozen request_refuse: SECURITY_ACTION is
		external
			"IL enum signature :System.Security.Permissions.SecurityAction use System.Security.Permissions.SecurityAction"
		alias
			"10"
		end

	frozen request_minimum: SECURITY_ACTION is
		external
			"IL enum signature :System.Security.Permissions.SecurityAction use System.Security.Permissions.SecurityAction"
		alias
			"8"
		end

	frozen inheritance_demand: SECURITY_ACTION is
		external
			"IL enum signature :System.Security.Permissions.SecurityAction use System.Security.Permissions.SecurityAction"
		alias
			"7"
		end

	frozen link_demand: SECURITY_ACTION is
		external
			"IL enum signature :System.Security.Permissions.SecurityAction use System.Security.Permissions.SecurityAction"
		alias
			"6"
		end

	frozen demand: SECURITY_ACTION is
		external
			"IL enum signature :System.Security.Permissions.SecurityAction use System.Security.Permissions.SecurityAction"
		alias
			"2"
		end

	frozen assert: SECURITY_ACTION is
		external
			"IL enum signature :System.Security.Permissions.SecurityAction use System.Security.Permissions.SecurityAction"
		alias
			"3"
		end

end -- class SECURITY_ACTION
