indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.CheckBox"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_CHECK_BOX

inherit
	WEB_WEB_CONTROL
		redefine
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
	WEB_IPOST_BACK_DATA_HANDLER
		rename
			raise_post_data_changed_event as system_web_ui_ipost_back_data_handler_raise_post_data_changed_event,
			load_post_data as system_web_ui_ipost_back_data_handler_load_post_data
		end

create
	make_web_check_box

feature {NONE} -- Initialization

	frozen make_web_check_box is
		external
			"IL creator use System.Web.UI.WebControls.CheckBox"
		end

feature -- Access

	get_auto_post_back: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.CheckBox"
		alias
			"get_AutoPostBack"
		end

	get_text_align: WEB_TEXT_ALIGN is
		external
			"IL signature (): System.Web.UI.WebControls.TextAlign use System.Web.UI.WebControls.CheckBox"
		alias
			"get_TextAlign"
		end

	get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.CheckBox"
		alias
			"get_Text"
		end

	get_checked: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.CheckBox"
		alias
			"get_Checked"
		end

feature -- Element Change

	set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.CheckBox"
		alias
			"set_Text"
		end

	set_checked (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.CheckBox"
		alias
			"set_Checked"
		end

	frozen remove_checked_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.WebControls.CheckBox"
		alias
			"remove_CheckedChanged"
		end

	set_auto_post_back (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.CheckBox"
		alias
			"set_AutoPostBack"
		end

	set_text_align (value: WEB_TEXT_ALIGN) is
		external
			"IL signature (System.Web.UI.WebControls.TextAlign): System.Void use System.Web.UI.WebControls.CheckBox"
		alias
			"set_TextAlign"
		end

	frozen add_checked_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.WebControls.CheckBox"
		alias
			"add_CheckedChanged"
		end

feature {NONE} -- Implementation

	frozen system_web_ui_ipost_back_data_handler_load_post_data (post_data_key: SYSTEM_STRING; post_collection: SYSTEM_DLL_NAME_VALUE_COLLECTION): BOOLEAN is
		external
			"IL signature (System.String, System.Collections.Specialized.NameValueCollection): System.Boolean use System.Web.UI.WebControls.CheckBox"
		alias
			"System.Web.UI.IPostBackDataHandler.LoadPostData"
		end

	frozen system_web_ui_ipost_back_data_handler_raise_post_data_changed_event is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.CheckBox"
		alias
			"System.Web.UI.IPostBackDataHandler.RaisePostDataChangedEvent"
		end

	on_checked_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.CheckBox"
		alias
			"OnCheckedChanged"
		end

	on_pre_render (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.CheckBox"
		alias
			"OnPreRender"
		end

	render (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.CheckBox"
		alias
			"Render"
		end

end -- class WEB_CHECK_BOX
