indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.OutputCacheLocation"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WEB_UI_OUTPUTCACHELOCATION

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

	frozen client: SYSTEM_WEB_UI_OUTPUTCACHELOCATION is
		external
			"IL enum signature :System.Web.UI.OutputCacheLocation use System.Web.UI.OutputCacheLocation"
		alias
			"1"
		end

	frozen server: SYSTEM_WEB_UI_OUTPUTCACHELOCATION is
		external
			"IL enum signature :System.Web.UI.OutputCacheLocation use System.Web.UI.OutputCacheLocation"
		alias
			"3"
		end

	frozen downstream: SYSTEM_WEB_UI_OUTPUTCACHELOCATION is
		external
			"IL enum signature :System.Web.UI.OutputCacheLocation use System.Web.UI.OutputCacheLocation"
		alias
			"2"
		end

	frozen none: SYSTEM_WEB_UI_OUTPUTCACHELOCATION is
		external
			"IL enum signature :System.Web.UI.OutputCacheLocation use System.Web.UI.OutputCacheLocation"
		alias
			"4"
		end

	frozen any: SYSTEM_WEB_UI_OUTPUTCACHELOCATION is
		external
			"IL enum signature :System.Web.UI.OutputCacheLocation use System.Web.UI.OutputCacheLocation"
		alias
			"0"
		end

end -- class SYSTEM_WEB_UI_OUTPUTCACHELOCATION
