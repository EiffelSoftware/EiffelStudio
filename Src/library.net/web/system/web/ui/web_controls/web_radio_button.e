indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.RadioButton"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_RADIO_BUTTON

inherit
	WEB_CHECK_BOX
		redefine
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
			raise_post_data_changed_event as system_web_ui_ipost_back_data_handler_raise_post_data_changed_event_void,
			load_post_data as system_web_ui_ipost_back_data_handler_load_post_data_string_name_value_collection
		select
			system_web_ui_ipost_back_data_handler_raise_post_data_changed_event_void,
			system_web_ui_ipost_back_data_handler_load_post_data_string_name_value_collection
		end

create
	make_web_radio_button

feature {NONE} -- Initialization

	frozen make_web_radio_button is
		external
			"IL creator use System.Web.UI.WebControls.RadioButton"
		end

feature -- Access

	get_group_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.RadioButton"
		alias
			"get_GroupName"
		end

feature -- Element Change

	set_group_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.RadioButton"
		alias
			"set_GroupName"
		end

feature {NONE} -- Implementation

	frozen system_web_ui_ipost_back_data_handler_raise_post_data_changed_event_void is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.RadioButton"
		alias
			"System.Web.UI.IPostBackDataHandler.RaisePostDataChangedEvent"
		end

	frozen system_web_ui_ipost_back_data_handler_load_post_data_string_name_value_collection (post_data_key: SYSTEM_STRING; post_collection: SYSTEM_DLL_NAME_VALUE_COLLECTION): BOOLEAN is
		external
			"IL signature (System.String, System.Collections.Specialized.NameValueCollection): System.Boolean use System.Web.UI.WebControls.RadioButton"
		alias
			"System.Web.UI.IPostBackDataHandler.LoadPostData"
		end

	on_pre_render (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.RadioButton"
		alias
			"OnPreRender"
		end

end -- class WEB_RADIO_BUTTON
