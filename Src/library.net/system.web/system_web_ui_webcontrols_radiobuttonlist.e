indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.RadioButtonList"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_RADIOBUTTONLIST

inherit
	SYSTEM_WEB_UI_IPOSTBACKDATAHANDLER
		rename
			raise_post_data_changed_event as system_web_ui_ipost_back_data_handler_raise_post_data_changed_event,
			load_post_data as system_web_ui_ipost_back_data_handler_load_post_data
		end
	SYSTEM_WEB_UI_WEBCONTROLS_LISTCONTROL
		redefine
			create_control_style,
			render
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_WEB_UI_INAMINGCONTAINER
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_WEBCONTROLS_IREPEATINFOUSER
		rename
			render_item as system_web_ui_web_controls_irepeat_info_user_render_item,
			get_item_style as system_web_ui_web_controls_irepeat_info_user_get_item_style,
			get_repeated_item_count as system_web_ui_web_controls_irepeat_info_user_get_repeated_item_count,
			get_has_separators as system_web_ui_web_controls_irepeat_info_user_get_has_separators,
			get_has_header as system_web_ui_web_controls_irepeat_info_user_get_has_header,
			get_has_footer as system_web_ui_web_controls_irepeat_info_user_get_has_footer
		end
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end

create
	make_radiobuttonlist

feature {NONE} -- Initialization

	frozen make_radiobuttonlist is
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

	get_text_align: SYSTEM_WEB_UI_WEBCONTROLS_TEXTALIGN is
		external
			"IL signature (): System.Web.UI.WebControls.TextAlign use System.Web.UI.WebControls.RadioButtonList"
		alias
			"get_TextAlign"
		end

	get_repeat_layout: SYSTEM_WEB_UI_WEBCONTROLS_REPEATLAYOUT is
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

	get_repeat_direction: SYSTEM_WEB_UI_WEBCONTROLS_REPEATDIRECTION is
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

	set_text_align (value: SYSTEM_WEB_UI_WEBCONTROLS_TEXTALIGN) is
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

	set_repeat_direction (value: SYSTEM_WEB_UI_WEBCONTROLS_REPEATDIRECTION) is
		external
			"IL signature (System.Web.UI.WebControls.RepeatDirection): System.Void use System.Web.UI.WebControls.RadioButtonList"
		alias
			"set_RepeatDirection"
		end

	set_repeat_layout (value: SYSTEM_WEB_UI_WEBCONTROLS_REPEATLAYOUT) is
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

	create_control_style: SYSTEM_WEB_UI_WEBCONTROLS_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.Style use System.Web.UI.WebControls.RadioButtonList"
		alias
			"CreateControlStyle"
		end

	frozen system_web_ui_web_controls_irepeat_info_user_get_item_style (item_type: SYSTEM_WEB_UI_WEBCONTROLS_LISTITEMTYPE; repeat_index: INTEGER): SYSTEM_WEB_UI_WEBCONTROLS_STYLE is
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

	frozen system_web_ui_ipost_back_data_handler_load_post_data (post_data_key: STRING; post_collection: SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION): BOOLEAN is
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

	render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
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

	frozen system_web_ui_web_controls_irepeat_info_user_render_item (item_type: SYSTEM_WEB_UI_WEBCONTROLS_LISTITEMTYPE; repeat_index: INTEGER; repeat_info: SYSTEM_WEB_UI_WEBCONTROLS_REPEATINFO; writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
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

end -- class SYSTEM_WEB_UI_WEBCONTROLS_RADIOBUTTONLIST
