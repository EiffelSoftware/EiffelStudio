indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.ProcessShutdownReason"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	WEB_PROCESS_SHUTDOWN_REASON

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen ping_failed: WEB_PROCESS_SHUTDOWN_REASON is
		external
			"IL enum signature :System.Web.ProcessShutdownReason use System.Web.ProcessShutdownReason"
		alias
			"7"
		end

	frozen unexpected: WEB_PROCESS_SHUTDOWN_REASON is
		external
			"IL enum signature :System.Web.ProcessShutdownReason use System.Web.ProcessShutdownReason"
		alias
			"1"
		end

	frozen timeout: WEB_PROCESS_SHUTDOWN_REASON is
		external
			"IL enum signature :System.Web.ProcessShutdownReason use System.Web.ProcessShutdownReason"
		alias
			"4"
		end

	frozen idle_timeout: WEB_PROCESS_SHUTDOWN_REASON is
		external
			"IL enum signature :System.Web.ProcessShutdownReason use System.Web.ProcessShutdownReason"
		alias
			"5"
		end

	frozen requests_limit: WEB_PROCESS_SHUTDOWN_REASON is
		external
			"IL enum signature :System.Web.ProcessShutdownReason use System.Web.ProcessShutdownReason"
		alias
			"2"
		end

	frozen deadlock_suspected: WEB_PROCESS_SHUTDOWN_REASON is
		external
			"IL enum signature :System.Web.ProcessShutdownReason use System.Web.ProcessShutdownReason"
		alias
			"8"
		end

	frozen none: WEB_PROCESS_SHUTDOWN_REASON is
		external
			"IL enum signature :System.Web.ProcessShutdownReason use System.Web.ProcessShutdownReason"
		alias
			"0"
		end

	frozen memory_limit_exceeded: WEB_PROCESS_SHUTDOWN_REASON is
		external
			"IL enum signature :System.Web.ProcessShutdownReason use System.Web.ProcessShutdownReason"
		alias
			"6"
		end

	frozen request_queue_limit: WEB_PROCESS_SHUTDOWN_REASON is
		external
			"IL enum signature :System.Web.ProcessShutdownReason use System.Web.ProcessShutdownReason"
		alias
			"3"
		end

end -- class WEB_PROCESS_SHUTDOWN_REASON
