indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.HtmlControls.HtmlInputFile"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_HTML_INPUT_FILE

inherit
	WEB_HTML_INPUT_CONTROL
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
	make_web_html_input_file

feature {NONE} -- Initialization

	frozen make_web_html_input_file is
		external
			"IL creator use System.Web.UI.HtmlControls.HtmlInputFile"
		end

feature -- Access

	frozen get_accept: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlInputFile"
		alias
			"get_Accept"
		end

	frozen get_max_length: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.HtmlControls.HtmlInputFile"
		alias
			"get_MaxLength"
		end

	frozen get_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.HtmlControls.HtmlInputFile"
		alias
			"get_Size"
		end

	frozen get_posted_file: WEB_HTTP_POSTED_FILE is
		external
			"IL signature (): System.Web.HttpPostedFile use System.Web.UI.HtmlControls.HtmlInputFile"
		alias
			"get_PostedFile"
		end

feature -- Element Change

	frozen set_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.HtmlControls.HtmlInputFile"
		alias
			"set_Size"
		end

	frozen set_accept (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlInputFile"
		alias
			"set_Accept"
		end

	frozen set_max_length (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.HtmlControls.HtmlInputFile"
		alias
			"set_MaxLength"
		end

feature {NONE} -- Implementation

	frozen system_web_ui_ipost_back_data_handler_load_post_data (post_data_key: SYSTEM_STRING; post_collection: SYSTEM_DLL_NAME_VALUE_COLLECTION): BOOLEAN is
		external
			"IL signature (System.String, System.Collections.Specialized.NameValueCollection): System.Boolean use System.Web.UI.HtmlControls.HtmlInputFile"
		alias
			"System.Web.UI.IPostBackDataHandler.LoadPostData"
		end

	frozen system_web_ui_ipost_back_data_handler_raise_post_data_changed_event is
		external
			"IL signature (): System.Void use System.Web.UI.HtmlControls.HtmlInputFile"
		alias
			"System.Web.UI.IPostBackDataHandler.RaisePostDataChangedEvent"
		end

end -- class WEB_HTML_INPUT_FILE
