indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.SessionState.SessionStateMode"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WEB_SESSIONSTATE_SESSIONSTATEMODE

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

	frozen sqlserver: SYSTEM_WEB_SESSIONSTATE_SESSIONSTATEMODE is
		external
			"IL enum signature :System.Web.SessionState.SessionStateMode use System.Web.SessionState.SessionStateMode"
		alias
			"3"
		end

	frozen state_server: SYSTEM_WEB_SESSIONSTATE_SESSIONSTATEMODE is
		external
			"IL enum signature :System.Web.SessionState.SessionStateMode use System.Web.SessionState.SessionStateMode"
		alias
			"2"
		end

	frozen in_proc: SYSTEM_WEB_SESSIONSTATE_SESSIONSTATEMODE is
		external
			"IL enum signature :System.Web.SessionState.SessionStateMode use System.Web.SessionState.SessionStateMode"
		alias
			"1"
		end

	frozen off: SYSTEM_WEB_SESSIONSTATE_SESSIONSTATEMODE is
		external
			"IL enum signature :System.Web.SessionState.SessionStateMode use System.Web.SessionState.SessionStateMode"
		alias
			"0"
		end

end -- class SYSTEM_WEB_SESSIONSTATE_SESSIONSTATEMODE
