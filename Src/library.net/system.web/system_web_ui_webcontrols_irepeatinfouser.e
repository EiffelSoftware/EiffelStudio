indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.IRepeatInfoUser"

deferred external class
	SYSTEM_WEB_UI_WEBCONTROLS_IREPEATINFOUSER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_has_header: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Web.UI.WebControls.IRepeatInfoUser"
		alias
			"get_HasHeader"
		end

	get_has_separators: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Web.UI.WebControls.IRepeatInfoUser"
		alias
			"get_HasSeparators"
		end

	get_has_footer: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Web.UI.WebControls.IRepeatInfoUser"
		alias
			"get_HasFooter"
		end

	get_repeated_item_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Web.UI.WebControls.IRepeatInfoUser"
		alias
			"get_RepeatedItemCount"
		end

feature -- Basic Operations

	get_item_style (item_type: SYSTEM_WEB_UI_WEBCONTROLS_LISTITEMTYPE; repeat_index: INTEGER): SYSTEM_WEB_UI_WEBCONTROLS_STYLE is
		external
			"IL deferred signature (System.Web.UI.WebControls.ListItemType, System.Int32): System.Web.UI.WebControls.Style use System.Web.UI.WebControls.IRepeatInfoUser"
		alias
			"GetItemStyle"
		end

	render_item (item_type: SYSTEM_WEB_UI_WEBCONTROLS_LISTITEMTYPE; repeat_index: INTEGER; repeat_info: SYSTEM_WEB_UI_WEBCONTROLS_REPEATINFO; writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL deferred signature (System.Web.UI.WebControls.ListItemType, System.Int32, System.Web.UI.WebControls.RepeatInfo, System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.IRepeatInfoUser"
		alias
			"RenderItem"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_IREPEATINFOUSER
