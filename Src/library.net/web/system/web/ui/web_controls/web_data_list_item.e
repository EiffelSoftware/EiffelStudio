indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.DataListItem"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_DATA_LIST_ITEM

inherit
	WEB_WEB_CONTROL
		redefine
			create_control_style,
			on_bubble_event
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
	WEB_INAMING_CONTAINER

create
	make_web_data_list_item

feature {NONE} -- Initialization

	frozen make_web_data_list_item (item_index: INTEGER; item_type: WEB_LIST_ITEM_TYPE) is
		external
			"IL creator signature (System.Int32, System.Web.UI.WebControls.ListItemType) use System.Web.UI.WebControls.DataListItem"
		end

feature -- Access

	get_item_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.DataListItem"
		alias
			"get_ItemIndex"
		end

	get_data_item: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.DataListItem"
		alias
			"get_DataItem"
		end

	get_item_type: WEB_LIST_ITEM_TYPE is
		external
			"IL signature (): System.Web.UI.WebControls.ListItemType use System.Web.UI.WebControls.DataListItem"
		alias
			"get_ItemType"
		end

feature -- Element Change

	set_data_item (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.DataListItem"
		alias
			"set_DataItem"
		end

feature -- Basic Operations

	render_item (writer: WEB_HTML_TEXT_WRITER; extract_rows: BOOLEAN; table_layout: BOOLEAN) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter, System.Boolean, System.Boolean): System.Void use System.Web.UI.WebControls.DataListItem"
		alias
			"RenderItem"
		end

feature {NONE} -- Implementation

	create_control_style: WEB_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.Style use System.Web.UI.WebControls.DataListItem"
		alias
			"CreateControlStyle"
		end

	set_item_type (item_type: WEB_LIST_ITEM_TYPE) is
		external
			"IL signature (System.Web.UI.WebControls.ListItemType): System.Void use System.Web.UI.WebControls.DataListItem"
		alias
			"SetItemType"
		end

	on_bubble_event (source: SYSTEM_OBJECT; e: EVENT_ARGS): BOOLEAN is
		external
			"IL signature (System.Object, System.EventArgs): System.Boolean use System.Web.UI.WebControls.DataListItem"
		alias
			"OnBubbleEvent"
		end

end -- class WEB_DATA_LIST_ITEM
