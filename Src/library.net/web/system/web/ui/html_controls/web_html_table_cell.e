indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.HtmlControls.HtmlTableCell"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_HTML_TABLE_CELL

inherit
	WEB_HTML_CONTAINER_CONTROL
		redefine
			render_end_tag
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
	make_web_html_table_cell,
	make_web_html_table_cell_1

feature {NONE} -- Initialization

	frozen make_web_html_table_cell is
		external
			"IL creator use System.Web.UI.HtmlControls.HtmlTableCell"
		end

	frozen make_web_html_table_cell_1 (tag_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Web.UI.HtmlControls.HtmlTableCell"
		end

feature -- Access

	frozen get_align: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"get_Align"
		end

	frozen get_width: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"get_Width"
		end

	frozen get_border_color: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"get_BorderColor"
		end

	frozen get_height: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"get_Height"
		end

	frozen get_valign: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"get_VAlign"
		end

	frozen get_bg_color: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"get_BgColor"
		end

	frozen get_row_span: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"get_RowSpan"
		end

	frozen get_col_span: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"get_ColSpan"
		end

	frozen get_no_wrap: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"get_NoWrap"
		end

feature -- Element Change

	frozen set_col_span (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"set_ColSpan"
		end

	frozen set_row_span (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"set_RowSpan"
		end

	frozen set_bg_color (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"set_BgColor"
		end

	frozen set_border_color (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"set_BorderColor"
		end

	frozen set_width (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"set_Width"
		end

	frozen set_valign (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"set_VAlign"
		end

	frozen set_align (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"set_Align"
		end

	frozen set_height (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"set_Height"
		end

	frozen set_no_wrap (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"set_NoWrap"
		end

feature {NONE} -- Implementation

	render_end_tag (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"RenderEndTag"
		end

end -- class WEB_HTML_TABLE_CELL
