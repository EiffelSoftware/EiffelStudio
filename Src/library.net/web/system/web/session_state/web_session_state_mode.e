indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.SessionState.SessionStateMode"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	WEB_SESSION_STATE_MODE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen sqlserver: WEB_SESSION_STATE_MODE is
		external
			"IL enum signature :System.Web.SessionState.SessionStateMode use System.Web.SessionState.SessionStateMode"
		alias
			"3"
		end

	frozen state_server: WEB_SESSION_STATE_MODE is
		external
			"IL enum signature :System.Web.SessionState.SessionStateMode use System.Web.SessionState.SessionStateMode"
		alias
			"2"
		end

	frozen in_proc: WEB_SESSION_STATE_MODE is
		external
			"IL enum signature :System.Web.SessionState.SessionStateMode use System.Web.SessionState.SessionStateMode"
		alias
			"1"
		end

	frozen off: WEB_SESSION_STATE_MODE is
		external
			"IL enum signature :System.Web.SessionState.SessionStateMode use System.Web.SessionState.SessionStateMode"
		alias
			"0"
		end

end -- class WEB_SESSION_STATE_MODE
