indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.OutputCacheLocation"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	WEB_OUTPUT_CACHE_LOCATION

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen client: WEB_OUTPUT_CACHE_LOCATION is
		external
			"IL enum signature :System.Web.UI.OutputCacheLocation use System.Web.UI.OutputCacheLocation"
		alias
			"1"
		end

	frozen server: WEB_OUTPUT_CACHE_LOCATION is
		external
			"IL enum signature :System.Web.UI.OutputCacheLocation use System.Web.UI.OutputCacheLocation"
		alias
			"3"
		end

	frozen downstream: WEB_OUTPUT_CACHE_LOCATION is
		external
			"IL enum signature :System.Web.UI.OutputCacheLocation use System.Web.UI.OutputCacheLocation"
		alias
			"2"
		end

	frozen none: WEB_OUTPUT_CACHE_LOCATION is
		external
			"IL enum signature :System.Web.UI.OutputCacheLocation use System.Web.UI.OutputCacheLocation"
		alias
			"4"
		end

	frozen any: WEB_OUTPUT_CACHE_LOCATION is
		external
			"IL enum signature :System.Web.UI.OutputCacheLocation use System.Web.UI.OutputCacheLocation"
		alias
			"0"
		end

end -- class WEB_OUTPUT_CACHE_LOCATION
