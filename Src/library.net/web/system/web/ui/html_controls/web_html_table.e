indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.HtmlControls.HtmlTable"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_HTML_TABLE

inherit
	WEB_HTML_CONTAINER_CONTROL
		redefine
			render_end_tag,
			set_inner_text,
			get_inner_text,
			set_inner_html,
			get_inner_html,
			create_control_collection,
			render_children
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
	make_web_html_table

feature {NONE} -- Initialization

	frozen make_web_html_table is
		external
			"IL creator use System.Web.UI.HtmlControls.HtmlTable"
		end

feature -- Access

	frozen get_align: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"get_Align"
		end

	frozen get_cell_spacing: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"get_CellSpacing"
		end

	get_rows: WEB_HTML_TABLE_ROW_COLLECTION is
		external
			"IL signature (): System.Web.UI.HtmlControls.HtmlTableRowCollection use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"get_Rows"
		end

	frozen get_border_color: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"get_BorderColor"
		end

	frozen get_height: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"get_Height"
		end

	get_inner_html: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"get_InnerHtml"
		end

	frozen get_border: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"get_Border"
		end

	frozen get_bg_color: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"get_BgColor"
		end

	frozen get_cell_padding: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"get_CellPadding"
		end

	frozen get_width: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"get_Width"
		end

	get_inner_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"get_InnerText"
		end

feature -- Element Change

	frozen set_cell_padding (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"set_CellPadding"
		end

	set_inner_html (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"set_InnerHtml"
		end

	frozen set_bg_color (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"set_BgColor"
		end

	frozen set_border_color (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"set_BorderColor"
		end

	frozen set_width (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"set_Width"
		end

	frozen set_cell_spacing (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"set_CellSpacing"
		end

	set_inner_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"set_InnerText"
		end

	frozen set_align (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"set_Align"
		end

	frozen set_height (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"set_Height"
		end

	frozen set_border (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"set_Border"
		end

feature {NONE} -- Implementation

	render_end_tag (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"RenderEndTag"
		end

	create_control_collection: WEB_CONTROL_COLLECTION is
		external
			"IL signature (): System.Web.UI.ControlCollection use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"CreateControlCollection"
		end

	render_children (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"RenderChildren"
		end

end -- class WEB_HTML_TABLE
