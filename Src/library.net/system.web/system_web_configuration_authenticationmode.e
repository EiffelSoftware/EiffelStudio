indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Configuration.AuthenticationMode"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WEB_CONFIGURATION_AUTHENTICATIONMODE

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen passport: SYSTEM_WEB_CONFIGURATION_AUTHENTICATIONMODE is
		external
			"IL enum signature :System.Web.Configuration.AuthenticationMode use System.Web.Configuration.AuthenticationMode"
		alias
			"2"
		end

	frozen none: SYSTEM_WEB_CONFIGURATION_AUTHENTICATIONMODE is
		external
			"IL enum signature :System.Web.Configuration.AuthenticationMode use System.Web.Configuration.AuthenticationMode"
		alias
			"0"
		end

	frozen forms: SYSTEM_WEB_CONFIGURATION_AUTHENTICATIONMODE is
		external
			"IL enum signature :System.Web.Configuration.AuthenticationMode use System.Web.Configuration.AuthenticationMode"
		alias
			"3"
		end

	frozen windows: SYSTEM_WEB_CONFIGURATION_AUTHENTICATIONMODE is
		external
			"IL enum signature :System.Web.Configuration.AuthenticationMode use System.Web.Configuration.AuthenticationMode"
		alias
			"1"
		end

end -- class SYSTEM_WEB_CONFIGURATION_AUTHENTICATIONMODE
