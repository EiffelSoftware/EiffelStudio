indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.SecurityZone"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	SECURITY_ZONE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen trusted: SECURITY_ZONE is
		external
			"IL enum signature :System.Security.SecurityZone use System.Security.SecurityZone"
		alias
			"2"
		end

	frozen untrusted: SECURITY_ZONE is
		external
			"IL enum signature :System.Security.SecurityZone use System.Security.SecurityZone"
		alias
			"4"
		end

	frozen no_zone: SECURITY_ZONE is
		external
			"IL enum signature :System.Security.SecurityZone use System.Security.SecurityZone"
		alias
			"-1"
		end

	frozen my_computer: SECURITY_ZONE is
		external
			"IL enum signature :System.Security.SecurityZone use System.Security.SecurityZone"
		alias
			"0"
		end

	frozen intranet: SECURITY_ZONE is
		external
			"IL enum signature :System.Security.SecurityZone use System.Security.SecurityZone"
		alias
			"1"
		end

	frozen internet: SECURITY_ZONE is
		external
			"IL enum signature :System.Security.SecurityZone use System.Security.SecurityZone"
		alias
			"3"
		end

end -- class SECURITY_ZONE
