indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.ProcessShutdownReason"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WEB_PROCESSSHUTDOWNREASON

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

	frozen unexpected: SYSTEM_WEB_PROCESSSHUTDOWNREASON is
		external
			"IL enum signature :System.Web.ProcessShutdownReason use System.Web.ProcessShutdownReason"
		alias
			"1"
		end

	frozen timeout: SYSTEM_WEB_PROCESSSHUTDOWNREASON is
		external
			"IL enum signature :System.Web.ProcessShutdownReason use System.Web.ProcessShutdownReason"
		alias
			"4"
		end

	frozen idle_timeout: SYSTEM_WEB_PROCESSSHUTDOWNREASON is
		external
			"IL enum signature :System.Web.ProcessShutdownReason use System.Web.ProcessShutdownReason"
		alias
			"5"
		end

	frozen requests_limit: SYSTEM_WEB_PROCESSSHUTDOWNREASON is
		external
			"IL enum signature :System.Web.ProcessShutdownReason use System.Web.ProcessShutdownReason"
		alias
			"2"
		end

	frozen ping_failed: SYSTEM_WEB_PROCESSSHUTDOWNREASON is
		external
			"IL enum signature :System.Web.ProcessShutdownReason use System.Web.ProcessShutdownReason"
		alias
			"7"
		end

	frozen none: SYSTEM_WEB_PROCESSSHUTDOWNREASON is
		external
			"IL enum signature :System.Web.ProcessShutdownReason use System.Web.ProcessShutdownReason"
		alias
			"0"
		end

	frozen memory_limit_exceeded: SYSTEM_WEB_PROCESSSHUTDOWNREASON is
		external
			"IL enum signature :System.Web.ProcessShutdownReason use System.Web.ProcessShutdownReason"
		alias
			"6"
		end

	frozen request_queue_limit: SYSTEM_WEB_PROCESSSHUTDOWNREASON is
		external
			"IL enum signature :System.Web.ProcessShutdownReason use System.Web.ProcessShutdownReason"
		alias
			"3"
		end

end -- class SYSTEM_WEB_PROCESSSHUTDOWNREASON
