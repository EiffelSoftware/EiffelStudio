indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.TraceMode"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WEB_TRACEMODE

inherit
	ENUM
	SYSTEM_IFORMATTABLE
		rename
			equals as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			equals as equals_object
		end

feature -- Access

	frozen default: SYSTEM_WEB_TRACEMODE is
		external
			"IL enum signature :System.Web.TraceMode use System.Web.TraceMode"
		alias
			"2"
		end

	frozen sort_by_time: SYSTEM_WEB_TRACEMODE is
		external
			"IL enum signature :System.Web.TraceMode use System.Web.TraceMode"
		alias
			"0"
		end

	frozen sort_by_category: SYSTEM_WEB_TRACEMODE is
		external
			"IL enum signature :System.Web.TraceMode use System.Web.TraceMode"
		alias
			"1"
		end

end -- class SYSTEM_WEB_TRACEMODE
