indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.ImageButton"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_IMAGE_BUTTON

inherit
	WEB_IMAGE
		redefine
			add_attributes_to_render,
			get_tag_key,
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
	make_web_image_button

feature {NONE} -- Initialization

	frozen make_web_image_button is
		external
			"IL creator use System.Web.UI.WebControls.ImageButton"
		end

feature -- Access

	frozen get_command_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.ImageButton"
		alias
			"get_CommandName"
		end

	frozen get_command_argument: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.ImageButton"
		alias
			"get_CommandArgument"
		end

	frozen get_causes_validation: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.ImageButton"
		alias
			"get_CausesValidation"
		end

feature -- Element Change

	frozen remove_click (value: WEB_IMAGE_CLICK_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.ImageClickEventHandler): System.Void use System.Web.UI.WebControls.ImageButton"
		alias
			"remove_Click"
		end

	frozen add_click (value: WEB_IMAGE_CLICK_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.ImageClickEventHandler): System.Void use System.Web.UI.WebControls.ImageButton"
		alias
			"add_Click"
		end

	frozen set_causes_validation (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.ImageButton"
		alias
			"set_CausesValidation"
		end

	frozen set_command_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.ImageButton"
		alias
			"set_CommandName"
		end

	frozen add_command (value: WEB_COMMAND_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.CommandEventHandler): System.Void use System.Web.UI.WebControls.ImageButton"
		alias
			"add_Command"
		end

	frozen remove_command (value: WEB_COMMAND_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.CommandEventHandler): System.Void use System.Web.UI.WebControls.ImageButton"
		alias
			"remove_Command"
		end

	frozen set_command_argument (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.ImageButton"
		alias
			"set_CommandArgument"
		end

feature {NONE} -- Implementation

	frozen system_web_ui_ipost_back_event_handler_raise_post_back_event (event_argument: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.ImageButton"
		alias
			"System.Web.UI.IPostBackEventHandler.RaisePostBackEvent"
		end

	frozen system_web_ui_ipost_back_data_handler_load_post_data (post_data_key: SYSTEM_STRING; post_collection: SYSTEM_DLL_NAME_VALUE_COLLECTION): BOOLEAN is
		external
			"IL signature (System.String, System.Collections.Specialized.NameValueCollection): System.Boolean use System.Web.UI.WebControls.ImageButton"
		alias
			"System.Web.UI.IPostBackDataHandler.LoadPostData"
		end

	on_click (e: WEB_IMAGE_CLICK_EVENT_ARGS) is
		external
			"IL signature (System.Web.UI.ImageClickEventArgs): System.Void use System.Web.UI.WebControls.ImageButton"
		alias
			"OnClick"
		end

	on_pre_render (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.ImageButton"
		alias
			"OnPreRender"
		end

	on_command (e: WEB_COMMAND_EVENT_ARGS) is
		external
			"IL signature (System.Web.UI.WebControls.CommandEventArgs): System.Void use System.Web.UI.WebControls.ImageButton"
		alias
			"OnCommand"
		end

	frozen system_web_ui_ipost_back_data_handler_raise_post_data_changed_event is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.ImageButton"
		alias
			"System.Web.UI.IPostBackDataHandler.RaisePostDataChangedEvent"
		end

	add_attributes_to_render (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.ImageButton"
		alias
			"AddAttributesToRender"
		end

	get_tag_key: WEB_HTML_TEXT_WRITER_TAG is
		external
			"IL signature (): System.Web.UI.HtmlTextWriterTag use System.Web.UI.WebControls.ImageButton"
		alias
			"get_TagKey"
		end

end -- class WEB_IMAGE_BUTTON
