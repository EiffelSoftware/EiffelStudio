indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.TextBox"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_TEXT_BOX

inherit
	WEB_WEB_CONTROL
		redefine
			add_attributes_to_render,
			get_tag_key,
			render,
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
	make_web_text_box

feature {NONE} -- Initialization

	frozen make_web_text_box is
		external
			"IL creator use System.Web.UI.WebControls.TextBox"
		end

feature -- Access

	get_rows: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.TextBox"
		alias
			"get_Rows"
		end

	get_max_length: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.TextBox"
		alias
			"get_MaxLength"
		end

	get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.TextBox"
		alias
			"get_Text"
		end

	get_columns: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.TextBox"
		alias
			"get_Columns"
		end

	get_auto_post_back: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.TextBox"
		alias
			"get_AutoPostBack"
		end

	get_wrap: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.TextBox"
		alias
			"get_Wrap"
		end

	get_text_mode: WEB_TEXT_BOX_MODE is
		external
			"IL signature (): System.Web.UI.WebControls.TextBoxMode use System.Web.UI.WebControls.TextBox"
		alias
			"get_TextMode"
		end

	get_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.TextBox"
		alias
			"get_ReadOnly"
		end

feature -- Element Change

	set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"set_Text"
		end

	frozen remove_text_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"remove_TextChanged"
		end

	set_max_length (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"set_MaxLength"
		end

	set_read_only (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"set_ReadOnly"
		end

	set_columns (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"set_Columns"
		end

	set_text_mode (value: WEB_TEXT_BOX_MODE) is
		external
			"IL signature (System.Web.UI.WebControls.TextBoxMode): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"set_TextMode"
		end

	set_wrap (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"set_Wrap"
		end

	frozen add_text_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"add_TextChanged"
		end

	set_rows (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"set_Rows"
		end

	set_auto_post_back (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"set_AutoPostBack"
		end

feature {NONE} -- Implementation

	add_parsed_sub_object (obj: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"AddParsedSubObject"
		end

	frozen system_web_ui_ipost_back_data_handler_load_post_data (post_data_key: SYSTEM_STRING; post_collection: SYSTEM_DLL_NAME_VALUE_COLLECTION): BOOLEAN is
		external
			"IL signature (System.String, System.Collections.Specialized.NameValueCollection): System.Boolean use System.Web.UI.WebControls.TextBox"
		alias
			"System.Web.UI.IPostBackDataHandler.LoadPostData"
		end

	on_pre_render (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"OnPreRender"
		end

	render (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"Render"
		end

	frozen system_web_ui_ipost_back_data_handler_raise_post_data_changed_event is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"System.Web.UI.IPostBackDataHandler.RaisePostDataChangedEvent"
		end

	add_attributes_to_render (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"AddAttributesToRender"
		end

	on_text_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"OnTextChanged"
		end

	get_tag_key: WEB_HTML_TEXT_WRITER_TAG is
		external
			"IL signature (): System.Web.UI.HtmlTextWriterTag use System.Web.UI.WebControls.TextBox"
		alias
			"get_TagKey"
		end

end -- class WEB_TEXT_BOX
