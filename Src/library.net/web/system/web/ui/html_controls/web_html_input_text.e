indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.HtmlControls.HtmlInputText"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_HTML_INPUT_TEXT

inherit
	WEB_HTML_INPUT_CONTROL
		redefine
			set_value,
			get_value,
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

create
	make_web_html_input_text_1,
	make_web_html_input_text

feature {NONE} -- Initialization

	frozen make_web_html_input_text_1 (type: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Web.UI.HtmlControls.HtmlInputText"
		end

	frozen make_web_html_input_text is
		external
			"IL creator use System.Web.UI.HtmlControls.HtmlInputText"
		end

feature -- Access

	frozen get_max_length: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.HtmlControls.HtmlInputText"
		alias
			"get_MaxLength"
		end

	get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlInputText"
		alias
			"get_Value"
		end

	frozen get_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.HtmlControls.HtmlInputText"
		alias
			"get_Size"
		end

feature -- Element Change

	frozen add_server_change (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.HtmlControls.HtmlInputText"
		alias
			"add_ServerChange"
		end

	frozen set_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.HtmlControls.HtmlInputText"
		alias
			"set_Size"
		end

	set_value (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlInputText"
		alias
			"set_Value"
		end

	frozen set_max_length (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.HtmlControls.HtmlInputText"
		alias
			"set_MaxLength"
		end

	frozen remove_server_change (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.HtmlControls.HtmlInputText"
		alias
			"remove_ServerChange"
		end

feature {NONE} -- Implementation

	render_attributes (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlInputText"
		alias
			"RenderAttributes"
		end

	frozen system_web_ui_ipost_back_data_handler_load_post_data (post_data_key: SYSTEM_STRING; post_collection: SYSTEM_DLL_NAME_VALUE_COLLECTION): BOOLEAN is
		external
			"IL signature (System.String, System.Collections.Specialized.NameValueCollection): System.Boolean use System.Web.UI.HtmlControls.HtmlInputText"
		alias
			"System.Web.UI.IPostBackDataHandler.LoadPostData"
		end

	on_server_change (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.HtmlControls.HtmlInputText"
		alias
			"OnServerChange"
		end

	frozen system_web_ui_ipost_back_data_handler_raise_post_data_changed_event is
		external
			"IL signature (): System.Void use System.Web.UI.HtmlControls.HtmlInputText"
		alias
			"System.Web.UI.IPostBackDataHandler.RaisePostDataChangedEvent"
		end

	on_pre_render (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.HtmlControls.HtmlInputText"
		alias
			"OnPreRender"
		end

end -- class WEB_HTML_INPUT_TEXT
