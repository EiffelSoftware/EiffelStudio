indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.PagerMode"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	WEB_PAGER_MODE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen numeric_pages: WEB_PAGER_MODE is
		external
			"IL enum signature :System.Web.UI.WebControls.PagerMode use System.Web.UI.WebControls.PagerMode"
		alias
			"1"
		end

	frozen next_prev: WEB_PAGER_MODE is
		external
			"IL enum signature :System.Web.UI.WebControls.PagerMode use System.Web.UI.WebControls.PagerMode"
		alias
			"0"
		end

end -- class WEB_PAGER_MODE
