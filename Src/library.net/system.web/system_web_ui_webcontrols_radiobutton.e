indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.RadioButton"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_RADIOBUTTON

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_IPOSTBACKDATAHANDLER
		rename
			raise_post_data_changed_event as system_web_ui_ipost_back_data_handler_raise_post_data_changed_event_void,
			load_post_data as system_web_ui_ipost_back_data_handler_load_post_data_string_name_value_collection
		select
			system_web_ui_ipost_back_data_handler_raise_post_data_changed_event_void,
			system_web_ui_ipost_back_data_handler_load_post_data_string_name_value_collection
		end
	SYSTEM_WEB_UI_WEBCONTROLS_CHECKBOX
		redefine
			on_pre_render
		end
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

create
	make_radiobutton

feature {NONE} -- Initialization

	frozen make_radiobutton is
		external
			"IL creator use System.Web.UI.WebControls.RadioButton"
		end

feature -- Access

	get_group_name: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.RadioButton"
		alias
			"get_GroupName"
		end

feature -- Element Change

	set_group_name (value: STRING) is
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

	frozen system_web_ui_ipost_back_data_handler_load_post_data_string_name_value_collection (post_data_key: STRING; post_collection: SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION): BOOLEAN is
		external
			"IL signature (System.String, System.Collections.Specialized.NameValueCollection): System.Boolean use System.Web.UI.WebControls.RadioButton"
		alias
			"System.Web.UI.IPostBackDataHandler.LoadPostData"
		end

	on_pre_render (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.RadioButton"
		alias
			"OnPreRender"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_RADIOBUTTON
