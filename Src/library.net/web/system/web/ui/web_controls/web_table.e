indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.Table"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_TABLE

inherit
	WEB_WEB_CONTROL
		redefine
			render_contents,
			create_control_style,
			add_attributes_to_render,
			create_control_collection
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

create
	make_web_table

feature {NONE} -- Initialization

	frozen make_web_table is
		external
			"IL creator use System.Web.UI.WebControls.Table"
		end

feature -- Access

	get_grid_lines: WEB_GRID_LINES is
		external
			"IL signature (): System.Web.UI.WebControls.GridLines use System.Web.UI.WebControls.Table"
		alias
			"get_GridLines"
		end

	get_back_image_url: SYSTEM_STRING is
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

	get_rows: WEB_TABLE_ROW_COLLECTION is
		external
			"IL signature (): System.Web.UI.WebControls.TableRowCollection use System.Web.UI.WebControls.Table"
		alias
			"get_Rows"
		end

	get_horizontal_align: WEB_HORIZONTAL_ALIGN is
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

	set_grid_lines (value: WEB_GRID_LINES) is
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

	set_horizontal_align (value: WEB_HORIZONTAL_ALIGN) is
		external
			"IL signature (System.Web.UI.WebControls.HorizontalAlign): System.Void use System.Web.UI.WebControls.Table"
		alias
			"set_HorizontalAlign"
		end

	set_back_image_url (value: SYSTEM_STRING) is
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

	create_control_style: WEB_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.Style use System.Web.UI.WebControls.Table"
		alias
			"CreateControlStyle"
		end

	render_contents (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.Table"
		alias
			"RenderContents"
		end

	create_control_collection: WEB_CONTROL_COLLECTION is
		external
			"IL signature (): System.Web.UI.ControlCollection use System.Web.UI.WebControls.Table"
		alias
			"CreateControlCollection"
		end

	add_attributes_to_render (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.Table"
		alias
			"AddAttributesToRender"
		end

end -- class WEB_TABLE
