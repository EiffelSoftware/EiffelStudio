indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.DataGridItem"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDITEM

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_WEB_UI_WEBCONTROLS_TABLEROW
		redefine
			on_bubble_event
		end
	SYSTEM_WEB_UI_INAMINGCONTAINER
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

create
	make_datagriditem

feature {NONE} -- Initialization

	frozen make_datagriditem (item_index: INTEGER; data_set_index: INTEGER; item_type: SYSTEM_WEB_UI_WEBCONTROLS_LISTITEMTYPE) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Web.UI.WebControls.ListItemType) use System.Web.UI.WebControls.DataGridItem"
		end

feature -- Access

	get_item_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.DataGridItem"
		alias
			"get_ItemIndex"
		end

	get_data_item: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.DataGridItem"
		alias
			"get_DataItem"
		end

	get_data_set_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.DataGridItem"
		alias
			"get_DataSetIndex"
		end

	get_item_type: SYSTEM_WEB_UI_WEBCONTROLS_LISTITEMTYPE is
		external
			"IL signature (): System.Web.UI.WebControls.ListItemType use System.Web.UI.WebControls.DataGridItem"
		alias
			"get_ItemType"
		end

feature -- Element Change

	set_data_item (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.DataGridItem"
		alias
			"set_DataItem"
		end

feature {NONE} -- Implementation

	set_item_type (item_type: SYSTEM_WEB_UI_WEBCONTROLS_LISTITEMTYPE) is
		external
			"IL signature (System.Web.UI.WebControls.ListItemType): System.Void use System.Web.UI.WebControls.DataGridItem"
		alias
			"SetItemType"
		end

	on_bubble_event (source: ANY; e: SYSTEM_EVENTARGS): BOOLEAN is
		external
			"IL signature (System.Object, System.EventArgs): System.Boolean use System.Web.UI.WebControls.DataGridItem"
		alias
			"OnBubbleEvent"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDITEM
