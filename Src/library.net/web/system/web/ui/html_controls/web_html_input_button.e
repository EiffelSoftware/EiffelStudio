indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.HtmlControls.HtmlInputButton"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_HTML_INPUT_BUTTON

inherit
	WEB_HTML_INPUT_CONTROL
		redefine
			render_attributes,
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
	WEB_IPOST_BACK_EVENT_HANDLER
		rename
			raise_post_back_event as system_web_ui_ipost_back_event_handler_raise_post_back_event
		end

create
	make_web_html_input_button,
	make_web_html_input_button_1

feature {NONE} -- Initialization

	frozen make_web_html_input_button is
		external
			"IL creator use System.Web.UI.HtmlControls.HtmlInputButton"
		end

	frozen make_web_html_input_button_1 (type: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Web.UI.HtmlControls.HtmlInputButton"
		end

feature -- Access

	frozen get_causes_validation: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.HtmlControls.HtmlInputButton"
		alias
			"get_CausesValidation"
		end

feature -- Element Change

	frozen add_server_click (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.HtmlControls.HtmlInputButton"
		alias
			"add_ServerClick"
		end

	frozen set_causes_validation (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.HtmlControls.HtmlInputButton"
		alias
			"set_CausesValidation"
		end

	frozen remove_server_click (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.HtmlControls.HtmlInputButton"
		alias
			"remove_ServerClick"
		end

feature {NONE} -- Implementation

	render_attributes (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlInputButton"
		alias
			"RenderAttributes"
		end

	on_pre_render (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.HtmlControls.HtmlInputButton"
		alias
			"OnPreRender"
		end

	frozen system_web_ui_ipost_back_event_handler_raise_post_back_event (event_argument: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlInputButton"
		alias
			"System.Web.UI.IPostBackEventHandler.RaisePostBackEvent"
		end

	on_server_click (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.HtmlControls.HtmlInputButton"
		alias
			"OnServerClick"
		end

end -- class WEB_HTML_INPUT_BUTTON
