indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.HtmlControls.HtmlTable"

external class
	SYSTEM_WEB_UI_HTMLCONTROLS_HTMLTABLE

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
			render_end_tag,
			set_inner_text,
			get_inner_text,
			set_inner_html,
			get_inner_html,
			create_control_collection,
			render_children
		end

create
	make_htmltable

feature {NONE} -- Initialization

	frozen make_htmltable is
		external
			"IL creator use System.Web.UI.HtmlControls.HtmlTable"
		end

feature -- Access

	frozen get_align: STRING is
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

	get_rows: SYSTEM_WEB_UI_HTMLCONTROLS_HTMLTABLEROWCOLLECTION is
		external
			"IL signature (): System.Web.UI.HtmlControls.HtmlTableRowCollection use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"get_Rows"
		end

	frozen get_border_color: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"get_BorderColor"
		end

	frozen get_height: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"get_Height"
		end

	get_inner_html: STRING is
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

	frozen get_bg_color: STRING is
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

	frozen get_width: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"get_Width"
		end

	get_inner_text: STRING is
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

	set_inner_html (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"set_InnerHtml"
		end

	frozen set_bg_color (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"set_BgColor"
		end

	frozen set_border_color (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"set_BorderColor"
		end

	frozen set_width (value: STRING) is
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

	set_inner_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"set_InnerText"
		end

	frozen set_align (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"set_Align"
		end

	frozen set_height (value: STRING) is
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

	render_end_tag (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"RenderEndTag"
		end

	create_control_collection: SYSTEM_WEB_UI_CONTROLCOLLECTION is
		external
			"IL signature (): System.Web.UI.ControlCollection use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"CreateControlCollection"
		end

	render_children (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlTable"
		alias
			"RenderChildren"
		end

end -- class SYSTEM_WEB_UI_HTMLCONTROLS_HTMLTABLE
