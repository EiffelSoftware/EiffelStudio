indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.Table"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_TABLE

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_WEBCONTROLS_WEBCONTROL
		redefine
			render_contents,
			create_control_style,
			add_attributes_to_render,
			create_control_collection
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

create
	make_table

feature {NONE} -- Initialization

	frozen make_table is
		external
			"IL creator use System.Web.UI.WebControls.Table"
		end

feature -- Access

	get_grid_lines: SYSTEM_WEB_UI_WEBCONTROLS_GRIDLINES is
		external
			"IL signature (): System.Web.UI.WebControls.GridLines use System.Web.UI.WebControls.Table"
		alias
			"get_GridLines"
		end

	get_back_image_url: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.Table"
		alias
			"get_BackImageUrl"
		end

	get_cell_spacing: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.Table"
		alias
			"get_CellSpacing"
		end

	get_rows: SYSTEM_WEB_UI_WEBCONTROLS_TABLEROWCOLLECTION is
		external
			"IL signature (): System.Web.UI.WebControls.TableRowCollection use System.Web.UI.WebControls.Table"
		alias
			"get_Rows"
		end

	get_horizontal_align: SYSTEM_WEB_UI_WEBCONTROLS_HORIZONTALALIGN is
		external
			"IL signature (): System.Web.UI.WebControls.HorizontalAlign use System.Web.UI.WebControls.Table"
		alias
			"get_HorizontalAlign"
		end

	get_cell_padding: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.Table"
		alias
			"get_CellPadding"
		end

feature -- Element Change

	set_grid_lines (value: SYSTEM_WEB_UI_WEBCONTROLS_GRIDLINES) is
		external
			"IL signature (System.Web.UI.WebControls.GridLines): System.Void use System.Web.UI.WebControls.Table"
		alias
			"set_GridLines"
		end

	set_cell_spacing (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.Table"
		alias
			"set_CellSpacing"
		end

	set_horizontal_align (value: SYSTEM_WEB_UI_WEBCONTROLS_HORIZONTALALIGN) is
		external
			"IL signature (System.Web.UI.WebControls.HorizontalAlign): System.Void use System.Web.UI.WebControls.Table"
		alias
			"set_HorizontalAlign"
		end

	set_back_image_url (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.Table"
		alias
			"set_BackImageUrl"
		end

	set_cell_padding (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.Table"
		alias
			"set_CellPadding"
		end

feature {NONE} -- Implementation

	create_control_style: SYSTEM_WEB_UI_WEBCONTROLS_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.Style use System.Web.UI.WebControls.Table"
		alias
			"CreateControlStyle"
		end

	render_contents (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.Table"
		alias
			"RenderContents"
		end

	create_control_collection: SYSTEM_WEB_UI_CONTROLCOLLECTION is
		external
			"IL signature (): System.Web.UI.ControlCollection use System.Web.UI.WebControls.Table"
		alias
			"CreateControlCollection"
		end

	add_attributes_to_render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.Table"
		alias
			"AddAttributesToRender"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_TABLE
