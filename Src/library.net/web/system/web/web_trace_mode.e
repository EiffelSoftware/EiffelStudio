indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.TraceMode"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	WEB_TRACE_MODE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen default_: WEB_TRACE_MODE is
		external
			"IL enum signature :System.Web.TraceMode use System.Web.TraceMode"
		alias
			"2"
		end

	frozen sort_by_time: WEB_TRACE_MODE is
		external
			"IL enum signature :System.Web.TraceMode use System.Web.TraceMode"
		alias
			"0"
		end

	frozen sort_by_category: WEB_TRACE_MODE is
		external
			"IL enum signature :System.Web.TraceMode use System.Web.TraceMode"
		alias
			"1"
		end

end -- class WEB_TRACE_MODE
