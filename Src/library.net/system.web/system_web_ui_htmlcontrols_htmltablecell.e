indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.HtmlControls.HtmlTableCell"

external class
	SYSTEM_WEB_UI_HTMLCONTROLS_HTMLTABLECELL

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_HTMLCONTROLS_HTMLCONTAINERCONTROL
		redefine
			render_end_tag
		end

create
	make_htmltablecell_1,
	make_htmltablecell

feature {NONE} -- Initialization

	frozen make_htmltablecell_1 (tag_name: STRING) is
		external
			"IL creator signature (System.String) use System.Web.UI.HtmlControls.HtmlTableCell"
		end

	frozen make_htmltablecell is
		external
			"IL creator use System.Web.UI.HtmlControls.HtmlTableCell"
		end

feature -- Access

	frozen get_align: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"get_Align"
		end

	frozen get_width: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"get_Width"
		end

	frozen get_border_color: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"get_BorderColor"
		end

	frozen get_height: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"get_Height"
		end

	frozen get_valign: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"get_VAlign"
		end

	frozen get_bg_color: STRING is
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

	frozen set_bg_color (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"set_BgColor"
		end

	frozen set_border_color (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"set_BorderColor"
		end

	frozen set_width (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"set_Width"
		end

	frozen set_valign (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"set_VAlign"
		end

	frozen set_align (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"set_Align"
		end

	frozen set_height (value: STRING) is
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

	render_end_tag (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlTableCell"
		alias
			"RenderEndTag"
		end

end -- class SYSTEM_WEB_UI_HTMLCONTROLS_HTMLTABLECELL
