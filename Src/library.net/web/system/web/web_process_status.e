indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.ProcessStatus"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	WEB_PROCESS_STATUS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen shutting_down: WEB_PROCESS_STATUS is
		external
			"IL enum signature :System.Web.ProcessStatus use System.Web.ProcessStatus"
		alias
			"2"
		end

	frozen shut_down: WEB_PROCESS_STATUS is
		external
			"IL enum signature :System.Web.ProcessStatus use System.Web.ProcessStatus"
		alias
			"3"
		end

	frozen terminated: WEB_PROCESS_STATUS is
		external
			"IL enum signature :System.Web.ProcessStatus use System.Web.ProcessStatus"
		alias
			"4"
		end

	frozen alive: WEB_PROCESS_STATUS is
		external
			"IL enum signature :System.Web.ProcessStatus use System.Web.ProcessStatus"
		alias
			"1"
		end

end -- class WEB_PROCESS_STATUS
