indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.HtmlControls.HtmlSelect"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_HTML_SELECT

inherit
	WEB_HTML_CONTAINER_CONTROL
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object_object
		redefine
			set_inner_text,
			get_inner_text,
			set_inner_html,
			get_inner_html,
			render_attributes,
			track_view_state,
			create_control_collection,
			render_children,
			save_view_state,
			on_pre_render,
			load_view_state,
			system_web_ui_iparser_accessor_add_parsed_sub_object_object,
			on_data_binding
		select
			system_web_ui_iparser_accessor_add_parsed_sub_object_object
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	WEB_IPARSER_ACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object_object
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
	WEB_IPOST_BACK_DATA_HANDLER
		rename
			raise_post_data_changed_event as system_web_ui_ipost_back_data_handler_raise_post_data_changed_event,
			load_post_data as system_web_ui_ipost_back_data_handler_load_post_data
		end

create
	make_web_html_select

feature {NONE} -- Initialization

	frozen make_web_html_select is
		external
			"IL creator use System.Web.UI.HtmlControls.HtmlSelect"
		end

feature -- Access

	frozen get_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"get_Size"
		end

	get_data_member: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"get_DataMember"
		end

	get_data_value_field: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"get_DataValueField"
		end

	get_inner_html: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"get_InnerHtml"
		end

	frozen get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"get_Value"
		end

	get_data_source: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"get_DataSource"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"get_Name"
		end

	frozen get_items: WEB_LIST_ITEM_COLLECTION is
		external
			"IL signature (): System.Web.UI.WebControls.ListItemCollection use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"get_Items"
		end

	frozen get_multiple: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"get_Multiple"
		end

	get_data_text_field: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"get_DataTextField"
		end

	get_selected_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"get_SelectedIndex"
		end

	get_inner_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"get_InnerText"
		end

feature -- Element Change

	frozen set_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"set_Size"
		end

	frozen set_value (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"set_Value"
		end

	set_inner_html (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"set_InnerHtml"
		end

	frozen remove_server_change (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"remove_ServerChange"
		end

	set_data_value_field (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"set_DataValueField"
		end

	frozen add_server_change (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"add_ServerChange"
		end

	set_selected_index (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"set_SelectedIndex"
		end

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"set_Name"
		end

	set_data_text_field (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"set_DataTextField"
		end

	frozen set_multiple (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"set_Multiple"
		end

	set_data_source (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"set_DataSource"
		end

	set_inner_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"set_InnerText"
		end

	set_data_member (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"set_DataMember"
		end

feature {NONE} -- Implementation

	on_server_change (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"OnServerChange"
		end

	render_children (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"RenderChildren"
		end

	frozen system_web_ui_ipost_back_data_handler_load_post_data (post_data_key: SYSTEM_STRING; post_collection: SYSTEM_DLL_NAME_VALUE_COLLECTION): BOOLEAN is
		external
			"IL signature (System.String, System.Collections.Specialized.NameValueCollection): System.Boolean use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"System.Web.UI.IPostBackDataHandler.LoadPostData"
		end

	render_attributes (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"RenderAttributes"
		end

	get_selected_indices: NATIVE_ARRAY [INTEGER] is
		external
			"IL signature (): System.Int32[] use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"get_SelectedIndices"
		end

	save_view_state: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"SaveViewState"
		end

	on_pre_render (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"OnPreRender"
		end

	select_ (selected_indices: NATIVE_ARRAY [INTEGER]) is
		external
			"IL signature (System.Int32[]): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"Select"
		end

	frozen system_web_ui_ipost_back_data_handler_raise_post_data_changed_event is
		external
			"IL signature (): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"System.Web.UI.IPostBackDataHandler.RaisePostDataChangedEvent"
		end

	on_data_binding (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"OnDataBinding"
		end

	create_control_collection: WEB_CONTROL_COLLECTION is
		external
			"IL signature (): System.Web.UI.ControlCollection use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"CreateControlCollection"
		end

	clear_selection is
		external
			"IL signature (): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"ClearSelection"
		end

	system_web_ui_iparser_accessor_add_parsed_sub_object_object (obj: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"AddParsedSubObject"
		end

	load_view_state (saved_state: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"LoadViewState"
		end

	track_view_state is
		external
			"IL signature (): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"TrackViewState"
		end

end -- class WEB_HTML_SELECT
