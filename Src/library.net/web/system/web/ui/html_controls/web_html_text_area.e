indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.HtmlControls.HtmlTextArea"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_HTML_TEXT_AREA

inherit
	WEB_HTML_CONTAINER_CONTROL
		redefine
			render_attributes,
			on_pre_render,
			add_parsed_sub_object
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
	make_web_html_text_area

feature {NONE} -- Initialization

	frozen make_web_html_text_area is
		external
			"IL creator use System.Web.UI.HtmlControls.HtmlTextArea"
		end

feature -- Access

	frozen get_cols: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.HtmlControls.HtmlTextArea"
		alias
			"get_Cols"
		end

	frozen get_rows: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.HtmlControls.HtmlTextArea"
		alias
			"get_Rows"
		end

	frozen get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTextArea"
		alias
			"get_Value"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTextArea"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_value (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTextArea"
		alias
			"set_Value"
		end

	frozen add_server_change (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.HtmlControls.HtmlTextArea"
		alias
			"add_ServerChange"
		end

	set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlTextArea"
		alias
			"set_Name"
		end

	frozen set_rows (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.HtmlControls.HtmlTextArea"
		alias
			"set_Rows"
		end

	frozen set_cols (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.HtmlControls.HtmlTextArea"
		alias
			"set_Cols"
		end

	frozen remove_server_change (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.HtmlControls.HtmlTextArea"
		alias
			"remove_ServerChange"
		end

feature {NONE} -- Implementation

	render_attributes (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlTextArea"
		alias
			"RenderAttributes"
		end

	frozen system_web_ui_ipost_back_data_handler_load_post_data (post_data_key: SYSTEM_STRING; post_collection: SYSTEM_DLL_NAME_VALUE_COLLECTION): BOOLEAN is
		external
			"IL signature (System.String, System.Collections.Specialized.NameValueCollection): System.Boolean use System.Web.UI.HtmlControls.HtmlTextArea"
		alias
			"System.Web.UI.IPostBackDataHandler.LoadPostData"
		end

	on_server_change (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.HtmlControls.HtmlTextArea"
		alias
			"OnServerChange"
		end

	frozen system_web_ui_ipost_back_data_handler_raise_post_data_changed_event is
		external
			"IL signature (): System.Void use System.Web.UI.HtmlControls.HtmlTextArea"
		alias
			"System.Web.UI.IPostBackDataHandler.RaisePostDataChangedEvent"
		end

	on_pre_render (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.HtmlControls.HtmlTextArea"
		alias
			"OnPreRender"
		end

	add_parsed_sub_object (obj: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.HtmlControls.HtmlTextArea"
		alias
			"AddParsedSubObject"
		end

end -- class WEB_HTML_TEXT_AREA
