indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.IRepeatInfoUser"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_IREPEAT_INFO_USER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
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

	get_item_style (item_type: WEB_LIST_ITEM_TYPE; repeat_index: INTEGER): WEB_STYLE is
		external
			"IL deferred signature (System.Web.UI.WebControls.ListItemType, System.Int32): System.Web.UI.WebControls.Style use System.Web.UI.WebControls.IRepeatInfoUser"
		alias
			"GetItemStyle"
		end

	render_item (item_type: WEB_LIST_ITEM_TYPE; repeat_index: INTEGER; repeat_info: WEB_REPEAT_INFO; writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL deferred signature (System.Web.UI.WebControls.ListItemType, System.Int32, System.Web.UI.WebControls.RepeatInfo, System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.IRepeatInfoUser"
		alias
			"RenderItem"
		end

end -- class WEB_IREPEAT_INFO_USER
