indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.DataListItem"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_DATALISTITEM

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_WEBCONTROLS_WEBCONTROL
		redefine
			create_control_style,
			on_bubble_event
		end
	SYSTEM_WEB_UI_INAMINGCONTAINER
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

create
	make_datalistitem

feature {NONE} -- Initialization

	frozen make_datalistitem (item_index: INTEGER; item_type: SYSTEM_WEB_UI_WEBCONTROLS_LISTITEMTYPE) is
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

	get_data_item: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.DataListItem"
		alias
			"get_DataItem"
		end

	get_item_type: SYSTEM_WEB_UI_WEBCONTROLS_LISTITEMTYPE is
		external
			"IL signature (): System.Web.UI.WebControls.ListItemType use System.Web.UI.WebControls.DataListItem"
		alias
			"get_ItemType"
		end

feature -- Element Change

	set_data_item (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.DataListItem"
		alias
			"set_DataItem"
		end

feature -- Basic Operations

	render_item (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER; extract_rows: BOOLEAN; table_layout: BOOLEAN) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter, System.Boolean, System.Boolean): System.Void use System.Web.UI.WebControls.DataListItem"
		alias
			"RenderItem"
		end

feature {NONE} -- Implementation

	create_control_style: SYSTEM_WEB_UI_WEBCONTROLS_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.Style use System.Web.UI.WebControls.DataListItem"
		alias
			"CreateControlStyle"
		end

	set_item_type (item_type: SYSTEM_WEB_UI_WEBCONTROLS_LISTITEMTYPE) is
		external
			"IL signature (System.Web.UI.WebControls.ListItemType): System.Void use System.Web.UI.WebControls.DataListItem"
		alias
			"SetItemType"
		end

	on_bubble_event (source: ANY; e: SYSTEM_EVENTARGS): BOOLEAN is
		external
			"IL signature (System.Object, System.EventArgs): System.Boolean use System.Web.UI.WebControls.DataListItem"
		alias
			"OnBubbleEvent"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_DATALISTITEM
