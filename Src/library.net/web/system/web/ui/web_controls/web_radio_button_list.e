indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.RadioButtonList"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_RADIO_BUTTON_LIST

inherit
	WEB_LIST_CONTROL
		redefine
			create_control_style,
			render
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	WEB_IPARSER_ACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	WEB_IDATA_BINDINGS_ACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end
	WEB_IATTRIBUTE_ACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	WEB_IREPEAT_INFO_USER
		rename
			render_item as system_web_ui_web_controls_irepeat_info_user_render_item,
			get_item_style as system_web_ui_web_controls_irepeat_info_user_get_item_style,
			get_repeated_item_count as system_web_ui_web_controls_irepeat_info_user_get_repeated_item_count,
			get_has_separators as system_web_ui_web_controls_irepeat_info_user_get_has_separators,
			get_has_header as system_web_ui_web_controls_irepeat_info_user_get_has_header,
			get_has_footer as system_web_ui_web_controls_irepeat_info_user_get_has_footer
		end
	WEB_INAMING_CONTAINER
	WEB_IPOST_BACK_DATA_HANDLER
		rename
			raise_post_data_changed_event as system_web_ui_ipost_back_data_handler_raise_post_data_changed_event,
			load_post_data as system_web_ui_ipost_back_data_handler_load_post_data
		end

create
	make_web_radio_button_list

feature {NONE} -- Initialization

	frozen make_web_radio_button_list is
		external
			"IL creator use System.Web.UI.WebControls.RadioButtonList"
		end

feature -- Access

	get_cell_spacing: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.RadioButtonList"
		alias
			"get_CellSpacing"
		end

	get_text_align: WEB_TEXT_ALIGN is
		external
			"IL signature (): System.Web.UI.WebControls.TextAlign use System.Web.UI.WebControls.RadioButtonList"
		alias
			"get_TextAlign"
		end

	get_repeat_layout: WEB_REPEAT_LAYOUT is
		external
			"IL signature (): System.Web.UI.WebControls.RepeatLayout use System.Web.UI.WebControls.RadioButtonList"
		alias
			"get_RepeatLayout"
		end

	get_repeat_columns: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.RadioButtonList"
		alias
			"get_RepeatColumns"
		end

	get_repeat_direction: WEB_REPEAT_DIRECTION is
		external
			"IL signature (): System.Web.UI.WebControls.RepeatDirection use System.Web.UI.WebControls.RadioButtonList"
		alias
			"get_RepeatDirection"
		end

	get_cell_padding: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.RadioButtonList"
		alias
			"get_CellPadding"
		end

feature -- Element Change

	set_cell_spacing (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.RadioButtonList"
		alias
			"set_CellSpacing"
		end

	set_repeat_columns (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.RadioButtonList"
		alias
			"set_RepeatColumns"
		end

	set_text_align (value: WEB_TEXT_ALIGN) is
		external
			"IL signature (System.Web.UI.WebControls.TextAlign): System.Void use System.Web.UI.WebControls.RadioButtonList"
		alias
			"set_TextAlign"
		end

	set_cell_padding (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.RadioButtonList"
		alias
			"set_CellPadding"
		end

	set_repeat_direction (value: WEB_REPEAT_DIRECTION) is
		external
			"IL signature (System.Web.UI.WebControls.RepeatDirection): System.Void use System.Web.UI.WebControls.RadioButtonList"
		alias
			"set_RepeatDirection"
		end

	set_repeat_layout (value: WEB_REPEAT_LAYOUT) is
		external
			"IL signature (System.Web.UI.WebControls.RepeatLayout): System.Void use System.Web.UI.WebControls.RadioButtonList"
		alias
			"set_RepeatLayout"
		end

feature {NONE} -- Implementation

	frozen system_web_ui_web_controls_irepeat_info_user_get_has_footer: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.RadioButtonList"
		alias
			"System.Web.UI.WebControls.IRepeatInfoUser.get_HasFooter"
		end

	create_control_style: WEB_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.Style use System.Web.UI.WebControls.RadioButtonList"
		alias
			"CreateControlStyle"
		end

	frozen system_web_ui_web_controls_irepeat_info_user_get_item_style (item_type: WEB_LIST_ITEM_TYPE; repeat_index: INTEGER): WEB_STYLE is
		external
			"IL signature (System.Web.UI.WebControls.ListItemType, System.Int32): System.Web.UI.WebControls.Style use System.Web.UI.WebControls.RadioButtonList"
		alias
			"System.Web.UI.WebControls.IRepeatInfoUser.GetItemStyle"
		end

	frozen system_web_ui_web_controls_irepeat_info_user_get_has_header: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.RadioButtonList"
		alias
			"System.Web.UI.WebControls.IRepeatInfoUser.get_HasHeader"
		end

	frozen system_web_ui_ipost_back_data_handler_load_post_data (post_data_key: SYSTEM_STRING; post_collection: SYSTEM_DLL_NAME_VALUE_COLLECTION): BOOLEAN is
		external
			"IL signature (System.String, System.Collections.Specialized.NameValueCollection): System.Boolean use System.Web.UI.WebControls.RadioButtonList"
		alias
			"System.Web.UI.IPostBackDataHandler.LoadPostData"
		end

	frozen system_web_ui_web_controls_irepeat_info_user_get_repeated_item_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.RadioButtonList"
		alias
			"System.Web.UI.WebControls.IRepeatInfoUser.get_RepeatedItemCount"
		end

	render (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.RadioButtonList"
		alias
			"Render"
		end

	frozen system_web_ui_ipost_back_data_handler_raise_post_data_changed_event is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.RadioButtonList"
		alias
			"System.Web.UI.IPostBackDataHandler.RaisePostDataChangedEvent"
		end

	frozen system_web_ui_web_controls_irepeat_info_user_render_item (item_type: WEB_LIST_ITEM_TYPE; repeat_index: INTEGER; repeat_info: WEB_REPEAT_INFO; writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.WebControls.ListItemType, System.Int32, System.Web.UI.WebControls.RepeatInfo, System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.RadioButtonList"
		alias
			"System.Web.UI.WebControls.IRepeatInfoUser.RenderItem"
		end

	frozen system_web_ui_web_controls_irepeat_info_user_get_has_separators: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.RadioButtonList"
		alias
			"System.Web.UI.WebControls.IRepeatInfoUser.get_HasSeparators"
		end

end -- class WEB_RADIO_BUTTON_LIST
