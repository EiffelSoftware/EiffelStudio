indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.HtmlControls.HtmlTableRow"

external class
	SYSTEM_WEB_UI_HTMLCONTROLS_HTMLTABLEROW

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
	make_htmltablerow

feature {NONE} -- Initialization

	frozen make_htmltablerow is
		external
			"IL creator use System.Web.UI.HtmlControls.HtmlTableRow"
		end

feature -- Access

	frozen get_align: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"get_Align"
		end

	frozen get_border_color: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"get_BorderColor"
		end

	get_inner_html: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"get_InnerHtml"
		end

	frozen get_height: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"get_Height"
		end

	frozen get_valign: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"get_VAlign"
		end

	frozen get_bg_color: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"get_BgColor"
		end

	get_cells: SYSTEM_WEB_UI_HTMLCONTROLS_HTMLTABLECELLCOLLECTION is
		external
			"IL signature (): System.Web.UI.HtmlControls.HtmlTableCellCollection use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"get_Cells"
		end

	get_inner_text: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"get_InnerText"
		end

feature -- Element Change

	frozen set_align (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"set_Align"
		end

	set_inner_html (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"set_InnerHtml"
		end

	frozen set_valign (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"set_VAlign"
		end

	frozen set_bg_color (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"set_BgColor"
		end

	frozen set_height (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"set_Height"
		end

	set_inner_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"set_InnerText"
		end

	frozen set_border_color (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"set_BorderColor"
		end

feature {NONE} -- Implementation

	render_end_tag (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"RenderEndTag"
		end

	create_control_collection: SYSTEM_WEB_UI_CONTROLCOLLECTION is
		external
			"IL signature (): System.Web.UI.ControlCollection use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"CreateControlCollection"
		end

	render_children (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlTableRow"
		alias
			"RenderChildren"
		end

end -- class SYSTEM_WEB_UI_HTMLCONTROLS_HTMLTABLEROW
