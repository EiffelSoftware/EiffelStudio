indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.HtmlControls.HtmlTableRow"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_HTML_TABLE_ROW

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
	make_web_html_table_row

feature {NONE} -- Initialization

	frozen make_web_html_table_row is
		external
			"IL creator use System.Web.UI.HtmlControls.HtmlTableRow"
		end

feature -- Access

	frozen get_align: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"get_Align"
		end

	frozen get_border_color: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"get_BorderColor"
		end

	get_inner_html: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"get_InnerHtml"
		end

	frozen get_height: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"get_Height"
		end

	frozen get_valign: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"get_VAlign"
		end

	frozen get_bg_color: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"get_BgColor"
		end

	get_cells: WEB_HTML_TABLE_CELL_COLLECTION is
		external
			"IL signature (): System.Web.UI.HtmlControls.HtmlTableCellCollection use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"get_Cells"
		end

	get_inner_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"get_InnerText"
		end

feature -- Element Change

	frozen set_align (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"set_Align"
		end

	set_inner_html (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"set_InnerHtml"
		end

	frozen set_valign (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"set_VAlign"
		end

	frozen set_bg_color (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"set_BgColor"
		end

	frozen set_height (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"set_Height"
		end

	set_inner_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"set_InnerText"
		end

	frozen set_border_color (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"set_BorderColor"
		end

feature {NONE} -- Implementation

	render_end_tag (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"RenderEndTag"
		end

	create_control_collection: WEB_CONTROL_COLLECTION is
		external
			"IL signature (): System.Web.UI.ControlCollection use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"CreateControlCollection"
		end

	render_children (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"RenderChildren"
		end

end -- class WEB_HTML_TABLE_ROW
