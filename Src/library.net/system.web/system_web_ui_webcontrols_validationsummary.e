indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.ValidationSummary"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_VALIDATIONSUMMARY

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_WEBCONTROLS_WEBCONTROL
		redefine
			add_attributes_to_render,
			set_fore_color,
			get_fore_color,
			render,
			on_pre_render
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
	make_validationsummary

feature {NONE} -- Initialization

	frozen make_validationsummary is
		external
			"IL creator use System.Web.UI.WebControls.ValidationSummary"
		end

feature -- Access

	frozen get_header_text: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.ValidationSummary"
		alias
			"get_HeaderText"
		end

	get_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Web.UI.WebControls.ValidationSummary"
		alias
			"get_ForeColor"
		end

	frozen get_show_summary: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.ValidationSummary"
		alias
			"get_ShowSummary"
		end

	frozen get_display_mode: SYSTEM_WEB_UI_WEBCONTROLS_VALIDATIONSUMMARYDISPLAYMODE is
		external
			"IL signature (): System.Web.UI.WebControls.ValidationSummaryDisplayMode use System.Web.UI.WebControls.ValidationSummary"
		alias
			"get_DisplayMode"
		end

	frozen get_enable_client_script: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.ValidationSummary"
		alias
			"get_EnableClientScript"
		end

	frozen get_show_message_box: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.ValidationSummary"
		alias
			"get_ShowMessageBox"
		end

feature -- Element Change

	frozen set_display_mode (value: SYSTEM_WEB_UI_WEBCONTROLS_VALIDATIONSUMMARYDISPLAYMODE) is
		external
			"IL signature (System.Web.UI.WebControls.ValidationSummaryDisplayMode): System.Void use System.Web.UI.WebControls.ValidationSummary"
		alias
			"set_DisplayMode"
		end

	set_fore_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Web.UI.WebControls.ValidationSummary"
		alias
			"set_ForeColor"
		end

	frozen set_show_summary (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.ValidationSummary"
		alias
			"set_ShowSummary"
		end

	frozen set_header_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.ValidationSummary"
		alias
			"set_HeaderText"
		end

	frozen set_enable_client_script (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.ValidationSummary"
		alias
			"set_EnableClientScript"
		end

	frozen set_show_message_box (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.ValidationSummary"
		alias
			"set_ShowMessageBox"
		end

feature {NONE} -- Implementation

	render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.ValidationSummary"
		alias
			"Render"
		end

	on_pre_render (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.ValidationSummary"
		alias
			"OnPreRender"
		end

	add_attributes_to_render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.ValidationSummary"
		alias
			"AddAttributesToRender"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_VALIDATIONSUMMARY
