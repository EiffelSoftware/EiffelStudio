indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.SecurityZone"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_SECURITY_SECURITYZONE

inherit
	ENUM
	SYSTEM_ICOMPARABLE
	SYSTEM_IFORMATTABLE

feature -- Access

	frozen trusted: SYSTEM_SECURITY_SECURITYZONE is
		external
			"IL enum signature :System.Security.SecurityZone use System.Security.SecurityZone"
		alias
			"2"
		end

	frozen untrusted: SYSTEM_SECURITY_SECURITYZONE is
		external
			"IL enum signature :System.Security.SecurityZone use System.Security.SecurityZone"
		alias
			"4"
		end

	frozen no_zone: SYSTEM_SECURITY_SECURITYZONE is
		external
			"IL enum signature :System.Security.SecurityZone use System.Security.SecurityZone"
		alias
			"-1"
		end

	frozen my_computer: SYSTEM_SECURITY_SECURITYZONE is
		external
			"IL enum signature :System.Security.SecurityZone use System.Security.SecurityZone"
		alias
			"0"
		end

	frozen intranet: SYSTEM_SECURITY_SECURITYZONE is
		external
			"IL enum signature :System.Security.SecurityZone use System.Security.SecurityZone"
		alias
			"1"
		end

	frozen internet: SYSTEM_SECURITY_SECURITYZONE is
		external
			"IL enum signature :System.Security.SecurityZone use System.Security.SecurityZone"
		alias
			"3"
		end

end -- class SYSTEM_SECURITY_SECURITYZONE
