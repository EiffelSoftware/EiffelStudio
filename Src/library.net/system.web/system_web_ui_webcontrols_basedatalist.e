indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.BaseDataList"

deferred external class
	SYSTEM_WEB_UI_WEBCONTROLS_BASEDATALIST

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_WEBCONTROLS_WEBCONTROL
		redefine
			create_child_controls,
			render,
			add_parsed_sub_object,
			data_bind,
			on_data_binding
		end
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

feature -- Access

	get_cell_spacing: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.BaseDataList"
		alias
			"get_CellSpacing"
		end

	get_horizontal_align: SYSTEM_WEB_UI_WEBCONTROLS_HORIZONTALALIGN is
		external
			"IL signature (): System.Web.UI.WebControls.HorizontalAlign use System.Web.UI.WebControls.BaseDataList"
		alias
			"get_HorizontalAlign"
		end

	frozen get_data_member: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.BaseDataList"
		alias
			"get_DataMember"
		end

	get_grid_lines: SYSTEM_WEB_UI_WEBCONTROLS_GRIDLINES is
		external
			"IL signature (): System.Web.UI.WebControls.GridLines use System.Web.UI.WebControls.BaseDataList"
		alias
			"get_GridLines"
		end

	get_data_source: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.BaseDataList"
		alias
			"get_DataSource"
		end

	frozen get_data_keys: SYSTEM_WEB_UI_WEBCONTROLS_DATAKEYCOLLECTION is
		external
			"IL signature (): System.Web.UI.WebControls.DataKeyCollection use System.Web.UI.WebControls.BaseDataList"
		alias
			"get_DataKeys"
		end

	get_cell_padding: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.BaseDataList"
		alias
			"get_CellPadding"
		end

	get_data_key_field: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.BaseDataList"
		alias
			"get_DataKeyField"
		end

feature -- Element Change

	set_grid_lines (value: SYSTEM_WEB_UI_WEBCONTROLS_GRIDLINES) is
		external
			"IL signature (System.Web.UI.WebControls.GridLines): System.Void use System.Web.UI.WebControls.BaseDataList"
		alias
			"set_GridLines"
		end

	set_data_key_field (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.BaseDataList"
		alias
			"set_DataKeyField"
		end

	frozen remove_selected_index_changed (value: SYSTEM_EVENTHANDLER) is
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

	frozen set_data_member (value: STRING) is
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

	set_data_source (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.BaseDataList"
		alias
			"set_DataSource"
		end

	set_horizontal_align (value: SYSTEM_WEB_UI_WEBCONTROLS_HORIZONTALALIGN) is
		external
			"IL signature (System.Web.UI.WebControls.HorizontalAlign): System.Void use System.Web.UI.WebControls.BaseDataList"
		alias
			"set_HorizontalAlign"
		end

	frozen add_selected_index_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.WebControls.BaseDataList"
		alias
			"add_SelectedIndexChanged"
		end

feature -- Basic Operations

	frozen is_bindable_type (type: SYSTEM_TYPE): BOOLEAN is
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

	on_data_binding (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.BaseDataList"
		alias
			"OnDataBinding"
		end

	on_selected_index_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.BaseDataList"
		alias
			"OnSelectedIndexChanged"
		end

	frozen get_data_keys_array: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Web.UI.WebControls.BaseDataList"
		alias
			"get_DataKeysArray"
		end

	render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.BaseDataList"
		alias
			"Render"
		end

	add_parsed_sub_object (obj: ANY) is
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

end -- class SYSTEM_WEB_UI_WEBCONTROLS_BASEDATALIST
