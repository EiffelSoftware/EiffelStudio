indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.HtmlControls.HtmlInputImage"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_HTML_INPUT_IMAGE

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
	WEB_IPOST_BACK_DATA_HANDLER
		rename
			raise_post_data_changed_event as system_web_ui_ipost_back_data_handler_raise_post_data_changed_event,
			load_post_data as system_web_ui_ipost_back_data_handler_load_post_data
		end
	WEB_IPOST_BACK_EVENT_HANDLER
		rename
			raise_post_back_event as system_web_ui_ipost_back_event_handler_raise_post_back_event
		end

create
	make_web_html_input_image

feature {NONE} -- Initialization

	frozen make_web_html_input_image is
		external
			"IL creator use System.Web.UI.HtmlControls.HtmlInputImage"
		end

feature -- Access

	frozen get_border: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"get_Border"
		end

	frozen get_align: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"get_Align"
		end

	frozen get_causes_validation: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"get_CausesValidation"
		end

	frozen get_alt: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"get_Alt"
		end

	frozen get_src: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"get_Src"
		end

feature -- Element Change

	frozen set_align (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"set_Align"
		end

	frozen set_src (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"set_Src"
		end

	frozen set_causes_validation (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"set_CausesValidation"
		end

	frozen remove_server_click (value: WEB_IMAGE_CLICK_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.ImageClickEventHandler): System.Void use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"remove_ServerClick"
		end

	frozen set_border (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"set_Border"
		end

	frozen set_alt (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"set_Alt"
		end

	frozen add_server_click (value: WEB_IMAGE_CLICK_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.ImageClickEventHandler): System.Void use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"add_ServerClick"
		end

feature {NONE} -- Implementation

	render_attributes (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"RenderAttributes"
		end

	frozen system_web_ui_ipost_back_data_handler_load_post_data (post_data_key: SYSTEM_STRING; post_collection: SYSTEM_DLL_NAME_VALUE_COLLECTION): BOOLEAN is
		external
			"IL signature (System.String, System.Collections.Specialized.NameValueCollection): System.Boolean use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"System.Web.UI.IPostBackDataHandler.LoadPostData"
		end

	frozen system_web_ui_ipost_back_data_handler_raise_post_data_changed_event is
		external
			"IL signature (): System.Void use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"System.Web.UI.IPostBackDataHandler.RaisePostDataChangedEvent"
		end

	on_pre_render (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"OnPreRender"
		end

	frozen system_web_ui_ipost_back_event_handler_raise_post_back_event (event_argument: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"System.Web.UI.IPostBackEventHandler.RaisePostBackEvent"
		end

	on_server_click (e: WEB_IMAGE_CLICK_EVENT_ARGS) is
		external
			"IL signature (System.Web.UI.ImageClickEventArgs): System.Void use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"OnServerClick"
		end

end -- class WEB_HTML_INPUT_IMAGE
