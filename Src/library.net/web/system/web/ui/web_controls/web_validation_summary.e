indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.ValidationSummary"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_VALIDATION_SUMMARY

inherit
	WEB_WEB_CONTROL
		redefine
			add_attributes_to_render,
			set_fore_color,
			get_fore_color,
			render,
			on_pre_render
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
	make_web_validation_summary

feature {NONE} -- Initialization

	frozen make_web_validation_summary is
		external
			"IL creator use System.Web.UI.WebControls.ValidationSummary"
		end

feature -- Access

	frozen get_header_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.ValidationSummary"
		alias
			"get_HeaderText"
		end

	get_fore_color: DRAWING_COLOR is
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

	frozen get_display_mode: WEB_VALIDATION_SUMMARY_DISPLAY_MODE is
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

	frozen set_display_mode (value: WEB_VALIDATION_SUMMARY_DISPLAY_MODE) is
		external
			"IL signature (System.Web.UI.WebControls.ValidationSummaryDisplayMode): System.Void use System.Web.UI.WebControls.ValidationSummary"
		alias
			"set_DisplayMode"
		end

	set_fore_color (value: DRAWING_COLOR) is
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

	frozen set_header_text (value: SYSTEM_STRING) is
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

	render (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.ValidationSummary"
		alias
			"Render"
		end

	on_pre_render (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.ValidationSummary"
		alias
			"OnPreRender"
		end

	add_attributes_to_render (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.ValidationSummary"
		alias
			"AddAttributesToRender"
		end

end -- class WEB_VALIDATION_SUMMARY
