indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Configuration.AuthenticationMode"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	WEB_AUTHENTICATION_MODE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen passport: WEB_AUTHENTICATION_MODE is
		external
			"IL enum signature :System.Web.Configuration.AuthenticationMode use System.Web.Configuration.AuthenticationMode"
		alias
			"2"
		end

	frozen none: WEB_AUTHENTICATION_MODE is
		external
			"IL enum signature :System.Web.Configuration.AuthenticationMode use System.Web.Configuration.AuthenticationMode"
		alias
			"0"
		end

	frozen forms: WEB_AUTHENTICATION_MODE is
		external
			"IL enum signature :System.Web.Configuration.AuthenticationMode use System.Web.Configuration.AuthenticationMode"
		alias
			"3"
		end

	frozen windows: WEB_AUTHENTICATION_MODE is
		external
			"IL enum signature :System.Web.Configuration.AuthenticationMode use System.Web.Configuration.AuthenticationMode"
		alias
			"1"
		end

end -- class WEB_AUTHENTICATION_MODE
