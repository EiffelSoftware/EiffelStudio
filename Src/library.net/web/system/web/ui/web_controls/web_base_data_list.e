indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.BaseDataList"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_BASE_DATA_LIST

inherit
	WEB_WEB_CONTROL
		redefine
			create_child_controls,
			get_controls,
			render,
			add_parsed_sub_object,
			data_bind,
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

	get_cell_spacing: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.BaseDataList"
		alias
			"get_CellSpacing"
		end

	get_horizontal_align: WEB_HORIZONTAL_ALIGN is
		external
			"IL signature (): System.Web.UI.WebControls.HorizontalAlign use System.Web.UI.WebControls.BaseDataList"
		alias
			"get_HorizontalAlign"
		end

	frozen get_data_member: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.BaseDataList"
		alias
			"get_DataMember"
		end

	get_grid_lines: WEB_GRID_LINES is
		external
			"IL signature (): System.Web.UI.WebControls.GridLines use System.Web.UI.WebControls.BaseDataList"
		alias
			"get_GridLines"
		end

	get_data_source: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.BaseDataList"
		alias
			"get_DataSource"
		end

	frozen get_data_keys: WEB_DATA_KEY_COLLECTION is
		external
			"IL signature (): System.Web.UI.WebControls.DataKeyCollection use System.Web.UI.WebControls.BaseDataList"
		alias
			"get_DataKeys"
		end

	get_controls: WEB_CONTROL_COLLECTION is
		external
			"IL signature (): System.Web.UI.ControlCollection use System.Web.UI.WebControls.BaseDataList"
		alias
			"get_Controls"
		end

	get_cell_padding: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.BaseDataList"
		alias
			"get_CellPadding"
		end

	get_data_key_field: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.BaseDataList"
		alias
			"get_DataKeyField"
		end

feature -- Element Change

	set_grid_lines (value: WEB_GRID_LINES) is
		external
			"IL signature (System.Web.UI.WebControls.GridLines): System.Void use System.Web.UI.WebControls.BaseDataList"
		alias
			"set_GridLines"
		end

	set_data_key_field (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.BaseDataList"
		alias
			"set_DataKeyField"
		end

	frozen remove_selected_index_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.WebControls.BaseDataList"
		alias
			"remove_SelectedIndexChanged"
		end

	set_cell_padding (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.BaseDataList"
		alias
			"set_CellPadding"
		end

	frozen set_data_member (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.BaseDataList"
		alias
			"set_DataMember"
		end

	set_cell_spacing (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.BaseDataList"
		alias
			"set_CellSpacing"
		end

	set_data_source (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.BaseDataList"
		alias
			"set_DataSource"
		end

	set_horizontal_align (value: WEB_HORIZONTAL_ALIGN) is
		external
			"IL signature (System.Web.UI.WebControls.HorizontalAlign): System.Void use System.Web.UI.WebControls.BaseDataList"
		alias
			"set_HorizontalAlign"
		end

	frozen add_selected_index_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.WebControls.BaseDataList"
		alias
			"add_SelectedIndexChanged"
		end

feature -- Basic Operations

	frozen is_bindable_type (type: TYPE): BOOLEAN is
		external
			"IL static signature (System.Type): System.Boolean use System.Web.UI.WebControls.BaseDataList"
		alias
			"IsBindableType"
		end

	data_bind is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.BaseDataList"
		alias
			"DataBind"
		end

feature {NONE} -- Implementation

	prepare_control_hierarchy is
		external
			"IL deferred signature (): System.Void use System.Web.UI.WebControls.BaseDataList"
		alias
			"PrepareControlHierarchy"
		end

	on_data_binding (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.BaseDataList"
		alias
			"OnDataBinding"
		end

	on_selected_index_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.BaseDataList"
		alias
			"OnSelectedIndexChanged"
		end

	frozen get_data_keys_array: ARRAY_LIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Web.UI.WebControls.BaseDataList"
		alias
			"get_DataKeysArray"
		end

	render (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.BaseDataList"
		alias
			"Render"
		end

	add_parsed_sub_object (obj: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.BaseDataList"
		alias
			"AddParsedSubObject"
		end

	create_control_hierarchy (use_data_source: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use System.Web.UI.WebControls.BaseDataList"
		alias
			"CreateControlHierarchy"
		end

	create_child_controls is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.BaseDataList"
		alias
			"CreateChildControls"
		end

end -- class WEB_BASE_DATA_LIST
