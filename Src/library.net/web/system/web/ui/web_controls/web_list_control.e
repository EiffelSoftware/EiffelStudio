indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.ListControl"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_LIST_CONTROL

inherit
	WEB_WEB_CONTROL
		redefine
			track_view_state,
			save_view_state,
			on_pre_render,
			load_view_state,
			on_data_binding
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

feature -- Access

	get_selected_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.ListControl"
		alias
			"get_SelectedIndex"
		end

	get_data_member: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.ListControl"
		alias
			"get_DataMember"
		end

	get_selected_item: WEB_LIST_ITEM is
		external
			"IL signature (): System.Web.UI.WebControls.ListItem use System.Web.UI.WebControls.ListControl"
		alias
			"get_SelectedItem"
		end

	get_data_source: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.ListControl"
		alias
			"get_DataSource"
		end

	get_data_value_field: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.ListControl"
		alias
			"get_DataValueField"
		end

	get_items: WEB_LIST_ITEM_COLLECTION is
		external
			"IL signature (): System.Web.UI.WebControls.ListItemCollection use System.Web.UI.WebControls.ListControl"
		alias
			"get_Items"
		end

	get_data_text_field: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.ListControl"
		alias
			"get_DataTextField"
		end

	get_data_text_format_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.ListControl"
		alias
			"get_DataTextFormatString"
		end

	get_auto_post_back: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.ListControl"
		alias
			"get_AutoPostBack"
		end

feature -- Element Change

	set_auto_post_back (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.ListControl"
		alias
			"set_AutoPostBack"
		end

	set_data_text_format_string (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.ListControl"
		alias
			"set_DataTextFormatString"
		end

	set_data_value_field (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.ListControl"
		alias
			"set_DataValueField"
		end

	frozen remove_selected_index_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.WebControls.ListControl"
		alias
			"remove_SelectedIndexChanged"
		end

	set_selected_index (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.ListControl"
		alias
			"set_SelectedIndex"
		end

	set_data_text_field (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.ListControl"
		alias
			"set_DataTextField"
		end

	set_data_source (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.ListControl"
		alias
			"set_DataSource"
		end

	set_data_member (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.ListControl"
		alias
			"set_DataMember"
		end

	frozen add_selected_index_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.WebControls.ListControl"
		alias
			"add_SelectedIndexChanged"
		end

feature -- Basic Operations

	clear_selection is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.ListControl"
		alias
			"ClearSelection"
		end

feature {NONE} -- Implementation

	load_view_state (saved_state: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.ListControl"
		alias
			"LoadViewState"
		end

	track_view_state is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.ListControl"
		alias
			"TrackViewState"
		end

	on_selected_index_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.ListControl"
		alias
			"OnSelectedIndexChanged"
		end

	on_pre_render (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.ListControl"
		alias
			"OnPreRender"
		end

	save_view_state: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.ListControl"
		alias
			"SaveViewState"
		end

	on_data_binding (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.ListControl"
		alias
			"OnDataBinding"
		end

end -- class WEB_LIST_CONTROL
